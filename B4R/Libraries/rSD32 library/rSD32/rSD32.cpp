#include "B4RDefines.h"
#include "SD.h" 

namespace B4R {

    B4RSD32::B4RSD32()
    {
	stream.wrappedStream = &b4rfile.file;
    }
    bool B4RSD32::Initialize(bool format_if_empty)
    {   
       return SD.begin(5); //,format_if_empty);         
    }    
    bool B4RSD32::Initialize1(uint8_t spi, uint8_t SDss, ULong frequency, byte max_files, bool format_if_empty)
    {  SPIClass *sd_SPI = NULL;
       sd_SPI = new SPIClass(spi & 0x03); 
       sd_SPI->begin(-1, -1, -1, SDss);
       return SD.begin(SDss, *sd_SPI,frequency, "/sd", max_files, format_if_empty);  
    }
    bool B4RSD32::Initialize2(uint8_t spi, uint8_t SDss, uint8_t SCLK, uint8_t MISO, uint8_t MOSI, bool format_if_empty)
    {  SPIClass *sd_SPI = NULL;
       sd_SPI = new SPIClass(spi & 0x03); 
       sd_SPI->begin(SCLK, MISO, MOSI, SDss);
       return SD.begin(SDss, *sd_SPI, 4000000, "/sd", 5, format_if_empty);         
    }    
    bool B4RSD32::Initialize3(uint8_t spi, uint8_t SDss, uint8_t SCLK, uint8_t MISO, uint8_t MOSI, ULong frequency, byte max_files, bool format_if_empty)
    {  SPIClass *sd_SPI = NULL;
       sd_SPI = new SPIClass(spi & 0x03); 
       sd_SPI->begin(SCLK, MISO, MOSI, SDss);
       return SD.begin(SDss, *sd_SPI, frequency, "/sd", max_files, format_if_empty);  
    }    
    void B4RSD32::end()
    {   
       SD.end();
    }    
    byte B4RSD32::getcardType()
    {   uint8_t tmp=SD.cardType(); uint8_t d;
        switch(tmp) {
        case CARD_SDHC : d = 3 ;break;
        case CARD_SD   : d = 2 ;break;
        case CARD_MMC  : d = 1 ;break;
        case CARD_NONE : d = 0 ;break;
        default        : d = 4 ;break;   //CARD_UNKNOWN
        }
        return d;
    }
    ULong B4RSD32::getcardSize()
    {        
        return SD.cardSize();
    }
    ULong B4RSD32::gettotalBytes()
    {        
        return SD.totalBytes();
    }
    ULong B4RSD32::getusedBytes()
    {        
        return SD.usedBytes();
    }
    bool B4RSD32::readRAW(ArrayByte* buff, ULong sector)
    {
        return SD.readRAW((uint8_t*)buff->data, sector); 
    }
    bool B4RSD32::writeRAW(ArrayByte* buff, ULong sector)
    {
        return SD.writeRAW((uint8_t*)buff->data, sector); 
    }
    bool B4RSD32::open (B4RString* FileName, const char* mode) 
    { 
	b4rfile.file.close();
	b4rfile.file = SD.open(FileName->data, mode);       
	if (b4rfile.file == true) {
	    b4rfile.file.seek(0, SeekSet);   
	    return true; }
        else    
	    return false;
    }
    bool B4RSD32::OpenRead(B4RString* FileName) 
    {  
	return open(FileName, "r");
    }
    bool B4RSD32::OpenReadWrite (B4RString* FileName) 
    {
 	if (Exists(FileName))
   	    return open(FileName, "r+");
	else
	    return open(FileName, "w+");
    }
    bool B4RSD32::OpenAppend(B4RString* FileName) 
    {
        if (open(FileName, "a")) {
           b4rfile.file.seek(b4rfile.file.size(), SeekSet);   
           return true; }
        else
           return false;
    }         
    bool B4RSD32::Exists(B4RString* FileName) 
    { 
	return SD.exists(FileName->data); 
    }
    B4RStream* B4RSD32::getStream() 
    {
	return &stream;
    }
    ULong B4RSD32::getPosition() 
    { 
	return b4rfile.file.position();
    }
    void B4RSD32::SetPosition(ULong p) 
    { 
	b4rfile.file.seek(p, SeekSet);
    }
    B4RFile* B4RSD32::getCurrentFile() 
    { 
	return &b4rfile;
    }
    void B4RSD32::Close() 
    { 
	return b4rfile.file.close();
    }
    bool B4RSD32::Remove(B4RString* FileName) {
	return SD.remove(FileName->data);
    }
    bool B4RSD32::Rename(B4RString* FileName1,B4RString* FileName2) 
    {
        return SD.rename(FileName1->data,FileName2->data);
    }
    FileIterator* B4RSD32::ListFiles(B4RString* DirName) 
    {
	FileIterator* it = CreateStackMemoryObject (FileIterator);
	#ifdef ESP32
	    it->dir = SD.open(DirName->data);
	#else
	    it->dir = SD.openDir(DirName->data);
	#endif
		
	it->current = new (it->backend) B4RFile();
	it->o.wrapPointer(it->current);
	return it;		
    }	
    ULong B4RFile::getSize() 
    { 
	return file.size();
    }       
    B4RString* B4RFile::getName() 
    {                            
	stringBackend.wrap(file.name());
	return &stringBackend;
    }  
    bool B4RFile::getIsDirectory() 
    {  
	return file.isDirectory();
    }     
    bool B4RSD32::MKDir (B4RString* DIRName) 
    {
	return SD.mkdir(DIRName->data);
    }
    bool B4RSD32::RMDir (B4RString* DIRName) 
    {
	   return SD.rmdir(DIRName->data);
    }    	
    bool FileIterator::MoveNext() 
    {
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