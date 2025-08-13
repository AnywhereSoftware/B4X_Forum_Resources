#include "B4RDefines.h"
#include "LittleFS.h" 

namespace B4R {

	B4RLittleFS::B4RLittleFS(){
		stream.wrappedStream = &b4rfile.file;
	}
	bool B4RLittleFS::Initialize() {   
        #ifdef ESP32  
		  return LittleFS.begin(true);
        #else
          return LittleFS.begin();
        #endif        
	}
	bool B4RLittleFS::Format() {
        return LittleFS.format(); 
	}
	bool B4RLittleFS::open (B4RString* FileName, const char* mode) { 
		b4rfile.file.close();
		b4rfile.file = LittleFS.open(FileName->data, mode);       
		if (b4rfile.file == true) {
			b4rfile.file.seek(0, SeekSet);   
			return true; }
         else    
		    return false;
	}
	bool B4RLittleFS::OpenRead(B4RString* FileName) {  
		return open(FileName, "r");
	}
	bool B4RLittleFS::OpenReadWrite (B4RString* FileName) {
 		if (Exists(FileName))
			return open(FileName, "r+");
		else
			return open(FileName, "w+");
	}
    
    bool B4RLittleFS::OpenAppend(B4RString* FileName) {
        if (open(FileName, "a")) {
           b4rfile.file.seek(b4rfile.file.size(), SeekSet);   
           return true; }
        else
           return false;
     }         
    
	bool B4RLittleFS::Exists(B4RString* FileName) { 
		return LittleFS.exists(FileName->data); 
	}
	B4RStream* B4RLittleFS::getStream() {
		return &stream;
	}
	ULong B4RLittleFS::getPosition() { 
		return b4rfile.file.position();
	}
	void B4RLittleFS::setPosition(ULong p) { 
		b4rfile.file.seek(p, SeekSet);
	}
	B4RFile* B4RLittleFS::getCurrentFile() { 
		return &b4rfile;
	}
	void B4RLittleFS::Close() { 
		return b4rfile.file.close();
	}
	bool B4RLittleFS::Remove(B4RString* FileName) {
		return LittleFS.remove(FileName->data);
	}
    bool B4RLittleFS::Rename(B4RString* FileName1,B4RString* FileName2) {
        return LittleFS.rename(FileName1->data,FileName2->data);
    }
	ULong B4RLittleFS::getTotalSize() { 
		#ifdef ESP32
		return LittleFS.totalBytes();
		#else			
		FSInfo f;
		LittleFS.info(f);
		return f.totalBytes;
		#endif
	}
	ULong B4RLittleFS::getUsedSize() { 
		#ifdef ESP32
		return LittleFS.usedBytes();
		#else			
		FSInfo f;
		LittleFS.info(f);
		return f.usedBytes;
		#endif
	}
	FileIterator* B4RLittleFS::ListFiles(B4RString* DirName) {
		FileIterator* it = CreateStackMemoryObject (FileIterator);
		#ifdef ESP32
		it->dir = LittleFS.open(DirName->data);
		#else
		it->dir = LittleFS.openDir(DirName->data);
		#endif
		
		it->current = new (it->backend) B4RFile();
		it->o.wrapPointer(it->current);
		return it;
		
	}
	
	ULong B4RFile::getSize() { 
		return file.size();
	}
       
	B4RString* B4RFile::getName() {                            
		stringBackend.wrap(file.name());
		return &stringBackend;
	}  
	
	bool B4RFile::getIsDirectory() {  
		return file.isDirectory();
	} 
   	bool B4RFile::getIsFile() {  
        #ifdef ESP32
        return (!file.isDirectory());
        #else
	   	return file.isFile();
        #endif    
	}    
    
	bool B4RLittleFS::MKDir (B4RString* DIRName) {
	    return LittleFS.mkdir(DIRName->data);
    }
    
	bool B4RLittleFS::RMDir (B4RString* DIRName) {
	    return LittleFS.rmdir(DIRName->data);
    }    



	
	bool FileIterator::MoveNext() {
		current->file.close();
		#ifdef ESP32
		if (current->file = dir.openNextFile()) {
			return true;
		#else
			
		if (dir.next()) {
			current->file = dir.openFile("r");
			return true;
		#endif
		} else {
			this->~FileIterator();
		return false;
		}
	}
	Object* FileIterator::Get() {
		return &o;
	}
	
	
}