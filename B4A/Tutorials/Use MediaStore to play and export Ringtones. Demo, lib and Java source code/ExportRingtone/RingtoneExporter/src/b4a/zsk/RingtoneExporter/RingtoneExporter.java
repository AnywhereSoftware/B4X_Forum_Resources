package b4a.zsk.RingtoneExporter;

import android.media.Ringtone;
import android.media.RingtoneManager;
import android.media.MediaPlayer;
import android.net.Uri;
import android.database.Cursor;
import android.provider.MediaStore;
import android.widget.Toast; 

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.List;
import java.util.ArrayList;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.BA.Author;
import anywheresoftware.b4a.BA.Version;
import anywheresoftware.b4a.BA.ShortName;

@ShortName("RingtoneExporter")
@Version(1.0F)
@Author("ZSK")

public class RingtoneExporter
{
	private static BA BAProcess;
	private String BAPrefix;
	private int RingtoneType = 1;

	public void Initialize(final BA BAProc, final String EventPrefix)
	{
		BAProcess = BAProc;
	}

	public String setRingtoneType(int type)
	{
		RingtoneType = type;
		return getDefaultRingtoneUri(RingtoneType).toString();
	}

	public void PlayRingtone()
	{
		//if (MyMediaPlayer.isPlaying()) {MyMediaPlayer.stop()}																	//Honer9似乎无法停止循环播放TYPE_RINGTONE = 1
		MediaPlayer MyMediaPlayer = MediaPlayer.create(BAProcess.applicationContext, getDefaultRingtoneUri(RingtoneType)); 
		MyMediaPlayer.setLooping(false); 
		MyMediaPlayer.start(); 
	}

    public void SaveRingtone()
	{
		//https://www.cnblogs.com/Sharley/p/8602735.html
        Uri RingtoneUri = getDefaultRingtoneUri(RingtoneType);
		String UriPath = null;
		String[] Columns = {MediaStore.Images.Media.DATA};																		//查询的列. https://m.imooc.com/wenda/detail/350348
		Cursor MyCursor = BAProcess.applicationContext.getContentResolver().query(RingtoneUri, Columns, null, null, null);
		if (MyCursor.moveToFirst())
		{
			int ColumnIndex = MyCursor.getColumnIndexOrThrow(MediaStore.Audio.Media.DATA);
			UriPath = MyCursor.getString(ColumnIndex);
		}
		MyCursor.close();
		File RingtoneFile = new File(UriPath);
		File RingtoneFileCopy = new File(BAProcess.applicationContext.getExternalCacheDir(), RingtoneFile.getName());			//ExternalCacheDir无须权限

		//https://blog.csdn.net/Bearin/article/details/90081162
		try
		{
			int ByteSum = 0;
			int ByteRead = 0;
			FileInputStream MyInputStream = new FileInputStream(RingtoneFile);
			FileOutputStream MyFileOutputStream = new FileOutputStream(RingtoneFileCopy);
			byte[] StreamBuffer = new byte[1024];
			while ( (ByteRead = MyInputStream.read(StreamBuffer)) != -1)
			{
				ByteSum += ByteRead;
				MyFileOutputStream.write(StreamBuffer, 0, ByteRead);
			}
			MyInputStream.close();
			Toast.makeText(BAProcess.applicationContext, "导出: " + BAProcess.applicationContext.getExternalCacheDir().toString(), Toast.LENGTH_LONG).show();
		}
		catch (Exception e)
		{
			Toast.makeText(BAProcess.applicationContext, "错误: " + e.toString(), Toast.LENGTH_LONG).show();
		}
    }
	
	private Uri getDefaultRingtoneUri(int type)
	{
		return RingtoneManager.getActualDefaultRingtoneUri(BAProcess.applicationContext, type);
	}
	
	//以下方法均未使用
	/* private Ringtone getDefaultRingtone(int type)
	{
		return RingtoneManager.getRingtone(BAProcess.applicationContext, RingtoneManager.getActualDefaultRingtoneUri(BAProcess.applicationContext, type));
	}
	
	private List<Ringtone> getRingtoneList(int type)
	{
		List<Ringtone> resArr = new ArrayList<Ringtone>();
		RingtoneManager manager = new RingtoneManager(BAProcess.applicationContext);
		manager.setType(type);
		Cursor MyCursor = manager.getCursor();
		int count = MyCursor.getCount();
		for(int i = 0 ; i < count ; i ++){
			resArr.add(manager.getRingtone(i));
		}
		return resArr;
	}
	
	private Ringtone getRingtone(int type,int pos)
	{
		RingtoneManager manager = new RingtoneManager(BAProcess.applicationContext);
		manager.setType(type);
		return manager.getRingtone(pos);
	}
	
	private List<String> getRingtoneTitleList(int type)
	{
		List<String> resArr = new ArrayList<String>();
		RingtoneManager manager = new RingtoneManager(BAProcess.applicationContext);
		manager.setType(type);
		Cursor MyCursor = manager.getCursor();
		if(MyCursor.moveToFirst()){
			do{
				resArr.add(MyCursor.getString(RingtoneManager.TITLE_COLUMN_INDEX));
			}while(MyCursor.moveToNext());
		}
		return resArr;
	} 
	
	private String getRingtoneUriPath(int type,int pos,String def)
	{
		RingtoneManager manager = new RingtoneManager(BAProcess.applicationContext);
		manager.setType(type);
		Uri RingtoneUri = manager.getRingtoneUri(pos);
		return RingtoneUri==null?def:RingtoneUri.toString();
	}
	
	private Ringtone getRingtoneByUriPath(int type ,String uriPath)
	{
		RingtoneManager manager = new RingtoneManager(BAProcess.applicationContext);
		manager.setType(type);
		Uri RingtoneUri = Uri.parse(uriPath);
		return manager.getRingtone(BAProcess.applicationContext, RingtoneUri);
	} */
}
