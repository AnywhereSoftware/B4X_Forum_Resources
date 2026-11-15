package com.microsdsqlite;

import android.app.Activity;
import android.content.ContentResolver;
import android.content.Intent;
import android.content.UriPermission;
import android.database.Cursor;
import android.net.Uri;
import android.os.Build;
import android.os.Environment;
import android.os.ParcelFileDescriptor;
import android.provider.DocumentsContract;
import android.provider.DocumentsContract.Document;
import android.provider.Settings;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.RandomAccessFile;
import java.nio.charset.StandardCharsets;
import java.nio.channels.FileChannel;
import java.nio.channels.FileLock;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.IOnActivityResult;
import anywheresoftware.b4a.sql.SQL;

@BA.ShortName("MicroSDSQLite")
@BA.Version(1.1f)
@BA.Author("Codex")
@BA.Events(values = {
        "SafFolderSelected (Success As Boolean, FolderUri As String)",
        "ManageAllFilesResult (Granted As Boolean)",
        "Error (Operation As String, Message As String)"
})
public class MicroSDSQLite implements BA.CheckForReinitialize {
    private BA ba;
    private String eventName = "";
    private String lastError = "";
    private boolean initialized;

    private File managedDir;
    private String managedFileName = "";
    private File lockFile;
    private RandomAccessFile lockRaf;
    private FileChannel lockChannel;
    private FileLock lock;
    private final LinkedHashMap<String, ManagedDirectLock> attachedDirectLocks = new LinkedHashMap<String, ManagedDirectLock>();

    private Uri safTreeUri;
    private Uri safDatabaseUri;
    private Uri safLockUri;
    private ParcelFileDescriptor safPfd;
    private String safDatabaseName = "";
    private String safFdPath = "";
    private IOnActivityResult safFolderResult;
    private IOnActivityResult manageAllFilesResult;

    public void Initialize(final BA ba, String EventName) {
        this.ba = ba;
        this.eventName = EventName == null ? "" : EventName.toLowerCase(BA.cul);
        this.initialized = true;
        this.lastError = "";
    }

    public boolean IsInitialized() {
        return initialized;
    }

    public String getLastError() {
        return lastError;
    }

    public boolean getHasOpenDatabase() {
        return lock != null;
    }

    public int getAttachedDatabaseCount() {
        return attachedDirectLocks.size();
    }

    public String getManagedDir() {
        return managedDir == null ? "" : managedDir.getAbsolutePath();
    }

    public String getManagedFileName() {
        return managedFileName;
    }

    public String getManagedPath() {
        if (managedDir == null || managedFileName.length() == 0) {
            return "";
        }
        return new File(managedDir, managedFileName).getAbsolutePath();
    }

    public String getLockPath() {
        return lockFile == null ? "" : lockFile.getAbsolutePath();
    }

    public String[] GetAttachedSchemas() {
        return attachedDirectLocks.keySet().toArray(new String[attachedDirectLocks.size()]);
    }

    public String getSafFolderUri() {
        return safTreeUri == null ? "" : safTreeUri.toString();
    }

    public String getSafDatabaseUri() {
        return safDatabaseUri == null ? "" : safDatabaseUri.toString();
    }

    public String getSafFdPath() {
        return safFdPath;
    }

    public boolean getHasOpenSafDatabase() {
        return safPfd != null;
    }

    public String[] GetExternalFilesDirs() {
        File[] dirs = BA.applicationContext.getExternalFilesDirs(null);
        ArrayList<String> result = new ArrayList<String>();
        if (dirs != null) {
            for (File dir : dirs) {
                if (dir != null) {
                    result.add(dir.getAbsolutePath());
                }
            }
        }
        return result.toArray(new String[result.size()]);
    }

    public String GetExternalFilesDirInfo() {
        File[] dirs = BA.applicationContext.getExternalFilesDirs(null);
        StringBuilder sb = new StringBuilder();
        if (dirs == null || dirs.length == 0) {
            return "";
        }
        for (int i = 0; i < dirs.length; i++) {
            File dir = dirs[i];
            if (dir == null) {
                continue;
            }
            if (sb.length() > 0) {
                sb.append('\n');
            }
            sb.append(i)
                    .append(": path=").append(dir.getAbsolutePath())
                    .append("; removable=").append(isRemovable(dir))
                    .append("; state=").append(getStorageState(dir))
                    .append("; writable=").append(isWritableState(dir))
                    .append("; usableBytes=").append(dir.getUsableSpace());
        }
        return sb.toString();
    }

    public String GetPrimaryAppSpecificRoot() {
        File[] dirs = BA.applicationContext.getExternalFilesDirs(null);
        if (dirs != null && dirs.length > 0 && dirs[0] != null) {
            return dirs[0].getAbsolutePath();
        }
        return "";
    }

    public String GetRemovableAppSpecificRoot() {
        File[] dirs = BA.applicationContext.getExternalFilesDirs(null);
        if (dirs == null) {
            return "";
        }
        for (File dir : dirs) {
            if (dir != null && isRemovable(dir) && Environment.MEDIA_MOUNTED.equals(getStorageState(dir))) {
                return dir.getAbsolutePath();
            }
        }
        return "";
    }

    public String GetRemovableVolumeRoot() {
        String appRoot = GetRemovableAppSpecificRoot();
        if (appRoot.length() == 0) {
            return "";
        }
        return GetVolumeRootFromAppSpecificDir(appRoot);
    }

    public String GetVolumeRootFromAppSpecificDir(String AppSpecificDir) {
        if (AppSpecificDir == null || AppSpecificDir.length() == 0) {
            return "";
        }
        String normalized = AppSpecificDir.replace('\\', '/');
        String packagePart = "/Android/data/" + BA.packageName + "/files";
        int index = normalized.indexOf(packagePart);
        if (index > 0) {
            return normalized.substring(0, index);
        }
        int androidIndex = normalized.indexOf("/Android/");
        if (androidIndex > 0) {
            return normalized.substring(0, androidIndex);
        }
        return "";
    }

    public String CombinePath(String Parent, String Child) {
        if (Parent == null || Parent.length() == 0) {
            return normalizeChildPath(Child);
        }
        String child = normalizeChildPath(Child);
        if (child.length() == 0) {
            return new File(Parent).getAbsolutePath();
        }
        return new File(Parent, child).getAbsolutePath();
    }

    public String ResolveRemovableSubDir(String SubFolder) {
        String root = GetRemovableAppSpecificRoot();
        if (root.length() == 0) {
            return "";
        }
        return CombinePath(root, SubFolder);
    }

    public boolean EnsureDirectory(String Dir) {
        try {
            File dir = requireDirectoryPath(Dir, false);
            if (dir.exists()) {
                if (!dir.isDirectory()) {
                    throw new IOException("Path exists but is not a directory: " + dir.getAbsolutePath());
                }
                return true;
            }
            if (!dir.mkdirs() && !dir.isDirectory()) {
                throw new IOException("Could not create directory: " + dir.getAbsolutePath());
            }
            return true;
        } catch (Exception e) {
            return fail("EnsureDirectory", e);
        }
    }

    public boolean IsDirectoryWritable(String Dir) {
        try {
            File dir = requireDirectoryPath(Dir, true);
            File test = File.createTempFile(".microsdsqlite-write-test-", ".tmp", dir);
            try {
                FileOutputStream out = new FileOutputStream(test);
                try {
                    out.write(1);
                    out.getFD().sync();
                } finally {
                    out.close();
                }
                return true;
            } finally {
                if (test.exists()) {
                    test.delete();
                }
            }
        } catch (Exception e) {
            return fail("IsDirectoryWritable", e);
        }
    }

    public long GetUsableBytes(String Dir) {
        try {
            File dir = requireDirectoryPath(Dir, true);
            return dir.getUsableSpace();
        } catch (Exception e) {
            fail("GetUsableBytes", e);
            return -1;
        }
    }

    public long GetFreeBytes(String Dir) {
        try {
            File dir = requireDirectoryPath(Dir, true);
            return dir.getFreeSpace();
        } catch (Exception e) {
            fail("GetFreeBytes", e);
            return -1;
        }
    }

    public long GetTotalBytes(String Dir) {
        try {
            File dir = requireDirectoryPath(Dir, true);
            return dir.getTotalSpace();
        } catch (Exception e) {
            fail("GetTotalBytes", e);
            return -1;
        }
    }

    public void PickSafFolder(final BA ba) {
        this.ba = ba;
        try {
            Intent intent = new Intent(Intent.ACTION_OPEN_DOCUMENT_TREE);
            intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
            intent.addFlags(Intent.FLAG_GRANT_WRITE_URI_PERMISSION);
            intent.addFlags(Intent.FLAG_GRANT_PERSISTABLE_URI_PERMISSION);
            intent.addFlags(Intent.FLAG_GRANT_PREFIX_URI_PERMISSION);
            safFolderResult = new IOnActivityResult() {
                @Override
                public void ResultArrived(int resultCode, Intent data) {
                    if (resultCode != Activity.RESULT_OK || data == null || data.getData() == null) {
                        raiseSafFolderSelected(false, "");
                        return;
                    }
                    Uri uri = data.getData();
                    try {
                        int takeFlags = data.getFlags()
                                & (Intent.FLAG_GRANT_READ_URI_PERMISSION | Intent.FLAG_GRANT_WRITE_URI_PERMISSION);
                        if (takeFlags != 0) {
                            BA.applicationContext.getContentResolver().takePersistableUriPermission(uri, takeFlags);
                        }
                        safTreeUri = uri;
                        raiseSafFolderSelected(true, uri.toString());
                    } catch (Exception e) {
                        fail("PickSafFolder", e);
                        raiseSafFolderSelected(false, uri.toString());
                    }
                }
            };
            ba.startActivityForResult(safFolderResult, intent);
        } catch (Exception e) {
            fail("PickSafFolder", e);
            raiseSafFolderSelected(false, "");
        }
    }

    public boolean SetSafFolderUri(String FolderUri) {
        try {
            if (FolderUri == null || FolderUri.trim().length() == 0) {
                safTreeUri = null;
                return true;
            }
            Uri uri = Uri.parse(FolderUri);
            if (Build.VERSION.SDK_INT >= 21 && !DocumentsContract.isTreeUri(uri)) {
                throw new IOException("URI is not a SAF tree URI: " + FolderUri);
            }
            safTreeUri = uri;
            return true;
        } catch (Exception e) {
            return fail("SetSafFolderUri", e);
        }
    }

    public boolean HasSafFolderPermission() {
        if (safTreeUri == null) {
            return false;
        }
        List<UriPermission> permissions = BA.applicationContext.getContentResolver().getPersistedUriPermissions();
        for (UriPermission permission : permissions) {
            if (safTreeUri.equals(permission.getUri())
                    && permission.isReadPermission()
                    && permission.isWritePermission()) {
                return true;
            }
        }
        return false;
    }

    public boolean OpenSafDatabase(SQL Sql, String DatabaseName, boolean CreateIfNecessary) {
        try {
            return openSafDatabaseInternal(Sql, validateFileName(DatabaseName), CreateIfNecessary);
        } catch (Throwable t) {
            return fail("OpenSafDatabase", t);
        }
    }

    public boolean OpenSafDatabaseAtRelativePath(SQL Sql, String RelativePath, boolean CreateIfNecessary) {
        try {
            return openSafDatabaseInternal(Sql, normalizeSafRelativePath(RelativePath), CreateIfNecessary);
        } catch (Throwable t) {
            return fail("OpenSafDatabaseAtRelativePath", t);
        }
    }

    private boolean openSafDatabaseInternal(SQL Sql, String cleanRelativePath, boolean CreateIfNecessary) throws Throwable {
        String[] parts = cleanRelativePath.split("/");
        String cleanName = parts[parts.length - 1];
        ensureInitialized();
        if (Sql == null) {
            throw new IllegalArgumentException("Sql cannot be null.");
        }
        if (safPfd != null) {
            throw new IllegalStateException("A SAF database is already open. CloseSafDatabase must be called first.");
        }
        if (lock != null) {
            throw new IllegalStateException("A direct-path database is already managed. CloseDatabase must be called first.");
        }
        Uri parent = getSafTreeDocumentUri();
        for (int i = 0; i < parts.length - 1; i++) {
            parent = resolveSafDirectory(parent, parts[i], CreateIfNecessary);
        }
        acquireSafLock(parent, cleanName);
        try {
            Uri dbUri = findSafChild(parent, cleanName);
            if (dbUri == null) {
                if (!CreateIfNecessary) {
                    throw new IOException("Database document does not exist: " + cleanRelativePath);
                }
                dbUri = DocumentsContract.createDocument(
                        BA.applicationContext.getContentResolver(),
                        parent,
                        "application/vnd.sqlite3",
                        cleanName);
                if (dbUri == null) {
                    throw new IOException("Could not create database document: " + cleanName);
                }
            }
            ParcelFileDescriptor pfd = BA.applicationContext.getContentResolver().openFileDescriptor(dbUri, "rw");
            if (pfd == null) {
                throw new IOException("Could not open database document descriptor: " + cleanName);
            }
            String fdName = String.valueOf(pfd.getFd());
            try {
                Sql.Initialize("/proc/self/fd", fdName, CreateIfNecessary);
                configureSafSqliteConnection(Sql);
            } catch (Throwable t) {
                try {
                    pfd.close();
                } catch (Throwable ignored) {
                    // Ignore close error while reporting the original SQLite open failure.
                }
                throw t;
            }
            safPfd = pfd;
            safDatabaseUri = dbUri;
            safDatabaseName = cleanRelativePath;
            safFdPath = "/proc/self/fd/" + fdName;
            lastError = "";
            return true;
        } catch (Throwable t) {
            releaseSafLockQuietly();
            throw t;
        }
    }

    public boolean CloseSafDatabase(SQL Sql) {
        Throwable thrown = null;
        try {
            if (Sql != null && Sql.IsInitialized()) {
                try {
                    Sql.Close();
                } catch (Throwable t) {
                    thrown = t;
                }
            }
            if (safPfd != null) {
                try {
                    safPfd.close();
                } catch (Throwable t) {
                    if (thrown == null) {
                        thrown = t;
                    }
                }
            }
            safPfd = null;
            safDatabaseUri = null;
            safDatabaseName = "";
            safFdPath = "";
            try {
                releaseSafLock();
            } catch (Throwable t) {
                if (thrown == null) {
                    thrown = t;
                }
            }
            if (thrown != null) {
                throw thrown;
            }
            lastError = "";
            return true;
        } catch (Throwable t) {
            return fail("CloseSafDatabase", t);
        }
    }

    public boolean ReleaseSafLockOnly() {
        try {
            releaseSafLock();
            return true;
        } catch (Exception e) {
            return fail("ReleaseSafLockOnly", e);
        }
    }

    public boolean DeleteSafLockFileIfExists(String DatabaseName) {
        try {
            return deleteSafLockFileInternal(validateFileName(DatabaseName));
        } catch (Exception e) {
            return fail("DeleteSafLockFileIfExists", e);
        }
    }

    public boolean DeleteSafLockFileAtRelativePath(String RelativePath) {
        try {
            return deleteSafLockFileInternal(normalizeSafRelativePath(RelativePath));
        } catch (Exception e) {
            return fail("DeleteSafLockFileAtRelativePath", e);
        }
    }

    private boolean deleteSafLockFileInternal(String cleanRelativePath) throws IOException {
        String[] parts = cleanRelativePath.split("/");
        String cleanName = parts[parts.length - 1];
        Uri parent = getSafTreeDocumentUri();
        for (int i = 0; i < parts.length - 1; i++) {
            parent = resolveSafDirectory(parent, parts[i], false);
        }
        Uri existing = findSafLockChild(parent, cleanName);
        if (existing == null) {
            return true;
        }
        if (safLockUri != null && safLockUri.equals(existing)) {
            throw new IOException("This process currently holds the SAF lock. Use CloseSafDatabase or ReleaseSafLockOnly.");
        }
        if (!DocumentsContract.deleteDocument(BA.applicationContext.getContentResolver(), existing)) {
            throw new IOException("Could not delete SAF lock document.");
        }
        return true;
    }

    public boolean IsManageAllFilesGranted() {
        if (Build.VERSION.SDK_INT < 30) {
            return true;
        }
        return Environment.isExternalStorageManager();
    }

    public void OpenManageAllFilesSettings(final BA ba) {
        this.ba = ba;
        if (Build.VERSION.SDK_INT < 30) {
            raiseManageAllFilesResult(true);
            return;
        }
        try {
            Intent intent = new Intent(Settings.ACTION_MANAGE_APP_ALL_FILES_ACCESS_PERMISSION);
            intent.setData(Uri.parse("package:" + BA.packageName));
            startSettingsActivity(ba, intent);
        } catch (Exception first) {
            try {
                Intent fallback = new Intent(Settings.ACTION_MANAGE_ALL_FILES_ACCESS_PERMISSION);
                startSettingsActivity(ba, fallback);
            } catch (Exception second) {
                fail("OpenManageAllFilesSettings", second);
            }
        }
    }

    public boolean OpenDatabase(SQL Sql, String Dir, String FileName, boolean CreateIfNecessary) {
        try {
            ensureInitialized();
            if (Sql == null) {
                throw new IllegalArgumentException("Sql cannot be null.");
            }
            if (lock != null) {
                throw new IllegalStateException("A database is already managed. CloseDatabase must be called first.");
            }
            if (safPfd != null) {
                throw new IllegalStateException("A SAF database is already open. CloseSafDatabase must be called first.");
            }
            String cleanName = validateFileName(FileName);
            File dir = requireDirectoryPath(Dir, false);
            if (!dir.exists() && !dir.mkdirs()) {
                throw new IOException("Could not create directory: " + dir.getAbsolutePath());
            }
            if (!dir.isDirectory()) {
                throw new IOException("Path is not a directory: " + dir.getAbsolutePath());
            }
            File db = new File(dir, cleanName);
            if (!CreateIfNecessary && !db.isFile()) {
                throw new IOException("Database does not exist: " + db.getAbsolutePath());
            }

            acquireLock(dir, cleanName);
            try {
                Sql.Initialize(dir.getAbsolutePath(), cleanName, CreateIfNecessary);
            } catch (Throwable t) {
                releaseLockQuietly();
                throw t;
            }
            managedDir = dir;
            managedFileName = cleanName;
            lastError = "";
            return true;
        } catch (Throwable t) {
            return fail("OpenDatabase", t);
        }
    }

    public boolean OpenDatabaseAtFullPath(SQL Sql, String FullPath, boolean CreateIfNecessary) {
        try {
            File db = requireFilePath(FullPath);
            File parent = db.getParentFile();
            if (parent == null) {
                throw new IOException("The full path must include a parent directory.");
            }
            return OpenDatabase(Sql, parent.getAbsolutePath(), db.getName(), CreateIfNecessary);
        } catch (Exception e) {
            return fail("OpenDatabaseAtFullPath", e);
        }
    }

    public boolean AttachDatabase(SQL Sql, String Dir, String FileName, String SchemaName, boolean CreateIfNecessary) {
        try {
            ensureInitialized();
            if (Sql == null || !Sql.IsInitialized()) {
                throw new IOException("Sql must be initialized before attaching a database.");
            }
            if (lock == null || managedDir == null || managedFileName.length() == 0) {
                throw new IOException("Open the main database through this MicroSDSQLite manager before attaching another database.");
            }
            if (safPfd != null) {
                throw new IOException("AttachDatabase is supported for direct-path mode only.");
            }
            String cleanName = validateFileName(FileName);
            String cleanSchema = validateSchemaName(SchemaName);
            String schemaKey = schemaKey(cleanSchema);
            if (attachedDirectLocks.containsKey(schemaKey)) {
                throw new IOException("Schema is already attached through this manager: " + cleanSchema);
            }
            File dir = requireDirectoryPath(Dir, false);
            if (!dir.exists() && !dir.mkdirs()) {
                throw new IOException("Could not create directory: " + dir.getAbsolutePath());
            }
            if (!dir.isDirectory()) {
                throw new IOException("Path is not a directory: " + dir.getAbsolutePath());
            }
            File db = new File(dir, cleanName);
            if (sameCanonicalFile(db, new File(managedDir, managedFileName))) {
                throw new IOException("Cannot attach the main database as another schema.");
            }

            ManagedDirectLock attachLock = acquireManagedDirectLock(dir, cleanName, "attached:" + cleanSchema);
            try {
                if (!db.exists()) {
                    if (!CreateIfNecessary) {
                        throw new IOException("Attached database does not exist: " + db.getAbsolutePath());
                    }
                    if (!db.createNewFile() && !db.isFile()) {
                        throw new IOException("Could not create attached database file: " + db.getAbsolutePath());
                    }
                }
                if (!db.isFile()) {
                    throw new IOException("Attached database path is not a file: " + db.getAbsolutePath());
                }
                Sql.ExecNonQuery("ATTACH DATABASE '" + sqliteStringLiteral(db.getAbsolutePath()) + "' AS " + quoteIdentifier(cleanSchema));
                attachedDirectLocks.put(schemaKey, attachLock);
                lastError = "";
                return true;
            } catch (Throwable t) {
                releaseManagedDirectLockQuietly(attachLock);
                throw t;
            }
        } catch (Throwable t) {
            return fail("AttachDatabase", t);
        }
    }

    public boolean AttachDatabaseAtFullPath(SQL Sql, String FullPath, String SchemaName, boolean CreateIfNecessary) {
        try {
            File db = requireFilePath(FullPath);
            File parent = db.getParentFile();
            if (parent == null) {
                throw new IOException("The full path must include a parent directory.");
            }
            return AttachDatabase(Sql, parent.getAbsolutePath(), db.getName(), SchemaName, CreateIfNecessary);
        } catch (Throwable t) {
            return fail("AttachDatabaseAtFullPath", t);
        }
    }

    public boolean DetachDatabase(SQL Sql, String SchemaName) {
        try {
            ensureInitialized();
            if (Sql == null || !Sql.IsInitialized()) {
                throw new IOException("Sql must be initialized before detaching a database.");
            }
            String cleanSchema = validateSchemaName(SchemaName);
            String schemaKey = schemaKey(cleanSchema);
            ManagedDirectLock attachLock = attachedDirectLocks.get(schemaKey);
            if (attachLock == null) {
                throw new IOException("Schema is not attached through this manager: " + cleanSchema);
            }
            Sql.ExecNonQuery("DETACH DATABASE " + quoteIdentifier(cleanSchema));
            attachedDirectLocks.remove(schemaKey);
            releaseManagedDirectLock(attachLock);
            lastError = "";
            return true;
        } catch (Throwable t) {
            return fail("DetachDatabase", t);
        }
    }

    public boolean CloseDatabase(SQL Sql, boolean CheckpointWal) {
        Throwable thrown = null;
        try {
            if (Sql != null && Sql.IsInitialized()) {
                if (CheckpointWal) {
                    checkpointWal(Sql);
                    checkpointAttachedWal(Sql);
                }
                try {
                    Sql.Close();
                } catch (Throwable t) {
                    thrown = t;
                }
            }
            try {
                releaseAttachedDirectLocks();
            } catch (Throwable t) {
                if (thrown == null) {
                    thrown = t;
                }
            }
            try {
                releaseLock();
            } catch (Throwable t) {
                if (thrown == null) {
                    thrown = t;
                }
            }
            if (thrown != null) {
                throw thrown;
            }
            lastError = "";
            return true;
        } catch (Throwable t) {
            return fail("CloseDatabase", t);
        }
    }

    public boolean ReleaseLockOnly() {
        try {
            releaseAttachedDirectLocks();
            releaseLock();
            return true;
        } catch (Exception e) {
            return fail("ReleaseLockOnly", e);
        }
    }

    public boolean DeleteLockFileIfNotHeld(String Dir, String FileName) {
        try {
            File dir = requireDirectoryPath(Dir, true);
            String cleanName = validateFileName(FileName);
            File candidate = new File(dir, cleanName + ".microsdsqlite.lock");
            if (!candidate.exists()) {
                return true;
            }
            if (lockFile != null && lockFile.getAbsolutePath().equals(candidate.getAbsolutePath()) && lock != null) {
                throw new IOException("This process currently holds the lock. Use CloseDatabase or ReleaseLockOnly.");
            }
            if (!candidate.delete() && candidate.exists()) {
                throw new IOException("Could not delete lock file: " + candidate.getAbsolutePath());
            }
            return true;
        } catch (Exception e) {
            return fail("DeleteLockFileIfNotHeld", e);
        }
    }

    private void startSettingsActivity(final BA ba, Intent intent) {
        manageAllFilesResult = new IOnActivityResult() {
            @Override
            public void ResultArrived(int resultCode, Intent data) {
                raiseManageAllFilesResult(IsManageAllFilesGranted());
            }
        };
        ba.startActivityForResult(manageAllFilesResult, intent);
    }

    private void raiseManageAllFilesResult(boolean granted) {
        if (ba != null && eventName.length() > 0) {
            ba.raiseEventFromUI(this, eventName + "_manageallfilesresult", granted);
        }
    }

    private void raiseSafFolderSelected(boolean success, String uri) {
        if (ba != null && eventName.length() > 0) {
            ba.raiseEventFromUI(this, eventName + "_saffolderselected", success, uri);
        }
    }

    private Uri getSafTreeDocumentUri() throws IOException {
        if (safTreeUri == null) {
            throw new IOException("No SAF folder URI is set. Call PickSafFolder or SetSafFolderUri first.");
        }
        if (Build.VERSION.SDK_INT < 21) {
            throw new IOException("ACTION_OPEN_DOCUMENT_TREE requires Android 5.0 or newer.");
        }
        return DocumentsContract.buildDocumentUriUsingTree(
                safTreeUri,
                DocumentsContract.getTreeDocumentId(safTreeUri));
    }

    private Uri findSafChild(Uri parentDocumentUri, String displayName) throws IOException {
        return findSafChild(parentDocumentUri, displayName, null);
    }

    private Uri findSafChild(Uri parentDocumentUri, String displayName, String requiredMimeType) throws IOException {
        ContentResolver resolver = BA.applicationContext.getContentResolver();
        Uri childrenUri = DocumentsContract.buildChildDocumentsUriUsingTree(
                parentDocumentUri,
                DocumentsContract.getDocumentId(parentDocumentUri));
        Cursor cursor = null;
        boolean wrongTypeFound = false;
        try {
            cursor = resolver.query(
                    childrenUri,
                    new String[]{Document.COLUMN_DOCUMENT_ID, Document.COLUMN_DISPLAY_NAME, Document.COLUMN_MIME_TYPE},
                    null,
                    null,
                    null);
            if (cursor == null) {
                throw new IOException("Could not query SAF folder children.");
            }
            while (cursor.moveToNext()) {
                String childName = cursor.getString(1);
                if (displayName.equals(childName)) {
                    String mimeType = cursor.getString(2);
                    if (requiredMimeType != null && !requiredMimeType.equals(mimeType)) {
                        wrongTypeFound = true;
                        continue;
                    }
                    String documentId = cursor.getString(0);
                    return DocumentsContract.buildDocumentUriUsingTree(safTreeUri, documentId);
                }
            }
            if (wrongTypeFound) {
                throw new IOException("SAF child exists but is not the required type: " + displayName);
            }
            return null;
        } finally {
            if (cursor != null) {
                cursor.close();
            }
        }
    }

    private Uri resolveSafDirectory(Uri parentDocumentUri, String displayName, boolean createIfMissing) throws IOException {
        Uri existing = findSafChild(parentDocumentUri, displayName, Document.MIME_TYPE_DIR);
        if (existing != null) {
            return existing;
        }
        if (!createIfMissing) {
            throw new IOException("SAF directory does not exist: " + displayName);
        }
        Uri created = DocumentsContract.createDocument(
                BA.applicationContext.getContentResolver(),
                parentDocumentUri,
                Document.MIME_TYPE_DIR,
                displayName);
        if (created == null) {
            throw new IOException("Could not create SAF directory: " + displayName);
        }
        return created;
    }

    private void acquireSafLock(Uri parentDocumentUri, String databaseName) throws IOException {
        ContentResolver resolver = BA.applicationContext.getContentResolver();
        String lockName = databaseName + ".microsdsqlite.lock";
        Uri existing = findSafChild(parentDocumentUri, lockName);
        if (existing != null) {
            throw new IOException("SAF manager lock already exists: " + lockName);
        }
        Uri created = DocumentsContract.createDocument(resolver, parentDocumentUri, "application/octet-stream", lockName);
        if (created == null) {
            throw new IOException("Could not create SAF lock document: " + lockName);
        }
        safLockUri = created;
        OutputStream out = null;
        try {
            out = resolver.openOutputStream(created, "wt");
            if (out == null) {
                throw new IOException("Could not open SAF lock document for writing.");
            }
            String body = "package=" + BA.packageName + "\n"
                    + "database=" + databaseName + "\n"
                    + "timeMillis=" + System.currentTimeMillis() + "\n";
            out.write(body.getBytes(StandardCharsets.UTF_8));
            out.flush();
        } finally {
            if (out != null) {
                out.close();
            }
        }
    }

    private Uri findSafLockChild(Uri parentDocumentUri, String databaseName) throws IOException {
        String lockName = databaseName + ".microsdsqlite.lock";
        Uri existing = findSafChild(parentDocumentUri, lockName);
        if (existing != null) {
            return existing;
        }
        return findSafChild(parentDocumentUri, lockName + ".txt");
    }

    private void releaseSafLock() throws IOException {
        Uri oldLock = safLockUri;
        safLockUri = null;
        if (oldLock != null) {
            DocumentsContract.deleteDocument(BA.applicationContext.getContentResolver(), oldLock);
        }
    }

    private void releaseSafLockQuietly() {
        try {
            releaseSafLock();
        } catch (Exception ignored) {
            safLockUri = null;
        }
    }

    private void configureSafSqliteConnection(SQL sql) {
        android.database.Cursor cursor = null;
        try {
            cursor = sql.ExecQuery("PRAGMA locking_mode=EXCLUSIVE");
            if (cursor != null) {
                cursor.close();
                cursor = null;
            }
        } catch (Throwable ignored) {
            if (cursor != null) {
                try {
                    cursor.close();
                } catch (Throwable ignored2) {
                    // Ignore best-effort cursor close errors.
                }
                cursor = null;
            }
        }
        try {
            cursor = sql.ExecQuery("PRAGMA journal_mode=MEMORY");
            if (cursor != null) {
                cursor.close();
                cursor = null;
            }
        } catch (Throwable ignored) {
            if (cursor != null) {
                try {
                    cursor.close();
                } catch (Throwable ignored2) {
                    // Ignore best-effort cursor close errors.
                }
                cursor = null;
            }
        }
        try {
            sql.ExecNonQuery("PRAGMA temp_store=MEMORY");
        } catch (Throwable ignored) {
            // Temporary files may still be needed for large sorts. Let callers discover that through real operations.
        }
    }

    private boolean fail(String operation, Throwable t) {
        String message = t == null ? "Unknown error" : t.getMessage();
        if (message == null || message.length() == 0) {
            message = t == null ? "Unknown error" : t.toString();
        }
        lastError = message;
        if (ba != null) {
            if (t instanceof Exception) {
                ba.setLastException((Exception) t);
            } else {
                ba.setLastException(new Exception(t));
            }
            if (eventName.length() > 0) {
                ba.raiseEventFromUI(this, eventName + "_error", operation, message);
            }
        }
        return false;
    }

    private void ensureInitialized() {
        if (!initialized) {
            throw new IllegalStateException("MicroSDSQLite is not initialized.");
        }
    }

    private File requireDirectoryPath(String dir, boolean mustExist) throws IOException {
        if (dir == null || dir.trim().length() == 0) {
            throw new IOException("Directory path is empty.");
        }
        File f = new File(dir);
        if (mustExist && !f.isDirectory()) {
            throw new IOException("Directory does not exist: " + f.getAbsolutePath());
        }
        return f;
    }

    private File requireFilePath(String fullPath) throws IOException {
        if (fullPath == null || fullPath.trim().length() == 0) {
            throw new IOException("File path is empty.");
        }
        return new File(fullPath);
    }

    private String validateFileName(String fileName) throws IOException {
        if (fileName == null) {
            throw new IOException("File name is empty.");
        }
        String clean = fileName.trim();
        if (clean.length() == 0) {
            throw new IOException("File name is empty.");
        }
        if (clean.indexOf('/') >= 0 || clean.indexOf('\\') >= 0) {
            throw new IOException("File name must not contain path separators. Use OpenDatabaseAtFullPath for a full path.");
        }
        if (".".equals(clean) || "..".equals(clean)) {
            throw new IOException("Invalid file name: " + clean);
        }
        return clean;
    }

    private String validateSchemaName(String schemaName) throws IOException {
        if (schemaName == null) {
            throw new IOException("Schema name is empty.");
        }
        String clean = schemaName.trim();
        if (clean.length() == 0) {
            throw new IOException("Schema name is empty.");
        }
        String lower = clean.toLowerCase(Locale.US);
        if ("main".equals(lower) || "temp".equals(lower)) {
            throw new IOException("Schema name is reserved: " + clean);
        }
        char first = clean.charAt(0);
        if (!((first >= 'A' && first <= 'Z') || (first >= 'a' && first <= 'z') || first == '_')) {
            throw new IOException("Schema name must start with a letter or underscore: " + clean);
        }
        for (int i = 1; i < clean.length(); i++) {
            char ch = clean.charAt(i);
            boolean ok = (ch >= 'A' && ch <= 'Z')
                    || (ch >= 'a' && ch <= 'z')
                    || (ch >= '0' && ch <= '9')
                    || ch == '_';
            if (!ok) {
                throw new IOException("Schema name may contain only letters, numbers, and underscore: " + clean);
            }
        }
        return clean;
    }

    private String schemaKey(String schemaName) {
        return schemaName.toLowerCase(Locale.US);
    }

    private String quoteIdentifier(String identifier) {
        return "\"" + identifier.replace("\"", "\"\"") + "\"";
    }

    private String sqliteStringLiteral(String value) {
        return value.replace("'", "''");
    }

    private boolean sameCanonicalFile(File a, File b) throws IOException {
        return a.getCanonicalFile().equals(b.getCanonicalFile());
    }

    private String normalizeSafRelativePath(String relativePath) throws IOException {
        if (relativePath == null) {
            throw new IOException("SAF relative path is empty.");
        }
        String normalized = relativePath.replace('\\', '/').trim();
        while (normalized.startsWith("/")) {
            normalized = normalized.substring(1);
        }
        if (normalized.length() == 0 || normalized.endsWith("/")) {
            throw new IOException("SAF relative path must include a database file name.");
        }
        ArrayList<String> parts = new ArrayList<String>();
        String[] raw = normalized.split("/");
        for (String part : raw) {
            if (part.length() == 0 || ".".equals(part)) {
                continue;
            }
            if ("..".equals(part)) {
                throw new IOException("SAF relative path must not contain '..'.");
            }
            parts.add(validateFileName(part));
        }
        if (parts.size() == 0) {
            throw new IOException("SAF relative path must include a database file name.");
        }
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < parts.size(); i++) {
            if (i > 0) {
                sb.append('/');
            }
            sb.append(parts.get(i));
        }
        return sb.toString();
    }

    private String normalizeChildPath(String child) {
        if (child == null) {
            return "";
        }
        String normalized = child.replace('\\', '/').trim();
        while (normalized.startsWith("/")) {
            normalized = normalized.substring(1);
        }
        List<String> parts = new ArrayList<String>();
        if (normalized.length() > 0) {
            String[] raw = normalized.split("/");
            for (String part : raw) {
                if (part.length() == 0 || ".".equals(part)) {
                    continue;
                }
                if ("..".equals(part)) {
                    throw new IllegalArgumentException("Child path must not contain '..'.");
                }
                parts.add(part);
            }
        }
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < parts.size(); i++) {
            if (i > 0) {
                sb.append(File.separatorChar);
            }
            sb.append(parts.get(i));
        }
        return sb.toString();
    }

    private boolean isRemovable(File dir) {
        if (Build.VERSION.SDK_INT >= 21) {
            return Environment.isExternalStorageRemovable(dir);
        }
        return false;
    }

    private String getStorageState(File dir) {
        if (Build.VERSION.SDK_INT >= 21) {
            return Environment.getExternalStorageState(dir);
        }
        return Environment.getExternalStorageState();
    }

    private boolean isWritableState(File dir) {
        return Environment.MEDIA_MOUNTED.equals(getStorageState(dir));
    }

    private ManagedDirectLock acquireManagedDirectLock(File dir, String dbFileName, String role) throws IOException {
        ManagedDirectLock state = new ManagedDirectLock();
        state.lockFile = new File(dir, dbFileName + ".microsdsqlite.lock");
        try {
            state.lockRaf = new RandomAccessFile(state.lockFile, "rw");
            state.lockChannel = state.lockRaf.getChannel();
            state.lock = state.lockChannel.tryLock();
            if (state.lock == null) {
                throw new IOException("Database manager lock is already held: " + state.lockFile.getAbsolutePath());
            }
            String body = "package=" + BA.packageName + "\n"
                    + "database=" + dbFileName + "\n"
                    + "role=" + role + "\n"
                    + "timeMillis=" + System.currentTimeMillis() + "\n";
            state.lockRaf.setLength(0);
            state.lockRaf.write(body.getBytes(StandardCharsets.UTF_8));
            state.lockRaf.getFD().sync();
            return state;
        } catch (IOException e) {
            releaseManagedDirectLockQuietly(state);
            throw e;
        } catch (RuntimeException e) {
            releaseManagedDirectLockQuietly(state);
            throw e;
        }
    }

    private void acquireLock(File dir, String dbFileName) throws IOException {
        ManagedDirectLock state = acquireManagedDirectLock(dir, dbFileName, "main");
        lockFile = state.lockFile;
        lockRaf = state.lockRaf;
        lockChannel = state.lockChannel;
        lock = state.lock;
    }

    private void releaseManagedDirectLock(ManagedDirectLock state) throws IOException {
        if (state == null) {
            return;
        }
        IOException thrown = null;
        if (state.lock != null) {
            try {
                state.lock.release();
            } catch (IOException e) {
                thrown = e;
            }
        }
        if (state.lockChannel != null) {
            try {
                state.lockChannel.close();
            } catch (IOException e) {
                if (thrown == null) {
                    thrown = e;
                }
            }
        }
        if (state.lockRaf != null) {
            try {
                state.lockRaf.close();
            } catch (IOException e) {
                if (thrown == null) {
                    thrown = e;
                }
            }
        }
        File oldLock = state.lockFile;
        state.lock = null;
        state.lockChannel = null;
        state.lockRaf = null;
        state.lockFile = null;
        if (oldLock != null && oldLock.exists() && !oldLock.delete() && oldLock.exists()) {
            if (thrown == null) {
                thrown = new IOException("Could not delete lock file: " + oldLock.getAbsolutePath());
            }
        }
        if (thrown != null) {
            throw thrown;
        }
    }

    private void releaseManagedDirectLockQuietly(ManagedDirectLock state) {
        try {
            releaseManagedDirectLock(state);
        } catch (Exception ignored) {
            // Best-effort cleanup during an earlier failure.
        }
    }

    private void releaseAttachedDirectLocks() throws IOException {
        IOException thrown = null;
        for (Map.Entry<String, ManagedDirectLock> entry : attachedDirectLocks.entrySet()) {
            try {
                releaseManagedDirectLock(entry.getValue());
            } catch (IOException e) {
                if (thrown == null) {
                    thrown = e;
                }
            }
        }
        attachedDirectLocks.clear();
        if (thrown != null) {
            throw thrown;
        }
    }

    private void checkpointAttachedWal(SQL sql) {
        for (String schema : attachedDirectLocks.keySet()) {
            checkpointWal(sql, schema);
        }
    }

    private static class ManagedDirectLock {
        File lockFile;
        RandomAccessFile lockRaf;
        FileChannel lockChannel;
        FileLock lock;
    }

    private void releaseLock() throws IOException {
        IOException thrown = null;
        if (lock != null) {
            try {
                lock.release();
            } catch (IOException e) {
                thrown = e;
            }
        }
        if (lockChannel != null) {
            try {
                lockChannel.close();
            } catch (IOException e) {
                if (thrown == null) {
                    thrown = e;
                }
            }
        }
        if (lockRaf != null) {
            try {
                lockRaf.close();
            } catch (IOException e) {
                if (thrown == null) {
                    thrown = e;
                }
            }
        }
        File oldLock = lockFile;
        clearManagedState();
        if (oldLock != null && oldLock.exists() && !oldLock.delete() && oldLock.exists()) {
            if (thrown == null) {
                thrown = new IOException("Could not delete lock file: " + oldLock.getAbsolutePath());
            }
        }
        if (thrown != null) {
            throw thrown;
        }
    }

    private void releaseLockQuietly() {
        try {
            releaseLock();
        } catch (Exception ignored) {
            clearManagedState();
        }
    }

    private void clearManagedState() {
        lock = null;
        lockChannel = null;
        lockRaf = null;
        lockFile = null;
        managedDir = null;
        managedFileName = "";
    }

    private void checkpointWal(SQL sql) {
        checkpointWal(sql, "");
    }

    private void checkpointWal(SQL sql, String schemaName) {
        android.database.Cursor cursor = null;
        try {
            String pragma = schemaName == null || schemaName.length() == 0
                    ? "PRAGMA wal_checkpoint(TRUNCATE)"
                    : "PRAGMA " + schemaName + ".wal_checkpoint(TRUNCATE)";
            cursor = sql.ExecQuery(pragma);
            if (cursor != null) {
                cursor.close();
            }
        } catch (Throwable ignored) {
            if (cursor != null) {
                try {
                    cursor.close();
                } catch (Throwable ignored2) {
                    // Ignore close errors during best-effort checkpoint cleanup.
                }
            }
        }
    }
}
