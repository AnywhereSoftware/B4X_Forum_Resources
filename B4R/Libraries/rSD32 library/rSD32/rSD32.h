#pragma once
#include "B4RDefines.h"
#include "FS.h"
namespace B4R {
	//~version: 1.02
	//~shortname: File

	class B4RFile 
        {
	private:
	    B4RString stringBackend;
	public:
	    //~hide
	    File file;
	    //Returns the file size (number of bytes).
	    ULong getSize();
	    //Returns the file name.
	    B4RString* getName();
            //Returns true if this file entry is a directory.
	    bool getIsDirectory();
	};

	//~hide
	class FileIterator : public Iterator
    	{
	public:
	    Object o;
	    B4RFile* current;
	    uint8_t backend[sizeof(B4RFile)];
	    #ifdef ESP32
		File dir;
	    #else
		Dir dir;
	    #endif
			
	    virtual bool MoveNext() override;
	    virtual Object* Get() override;						
	};
	
	//~shortname: SD32
	class B4RSD32
        {
	private:
	    B4RFile b4rfile;
	    B4RStream stream;
	    bool open (B4RString* FileName, const char* mode);
	public:
	    //~hide
	    B4RSD32();                                                                                                         
            //Initializes SPI system on SPI by default and with all SD parameters by default. Returns True if successful.
           //Default Initialize : spi=SPI, ssPin= -1, sck=-1, miso=-1, mosi=-1, frequency=4000000, mountpoint="/sd", max_files=5, format_if_empty=false
            bool Initialize(bool format_if_empty);
            //Initializes file system on SPI configured(default if not configured). SDss=SPI_CS configured. With more parameters for SD. Returns True if successful.
           //Default Initialize : spi=SPI, ssPin= -1, sck=-1, miso=-1, mosi=-1, frequency=4000000, mountpoint="/sd", max_files=5, format_if_empty=false
	        bool Initialize1(uint8_t spi, uint8_t SDss, ULong frequency, byte max_files, bool format_if_empty);
            //Initializes file system on SPI configuration provided. SDss=SPI_CS. Returns True if successful.    
           //Default Initialize : spi=SPI, ssPin= -1, sck=-1, miso=-1, mosi=-1, frequency=4000000, mountpoint="/sd", max_files=5, format_if_empty=false
            bool Initialize2(uint8_t spi, uint8_t SDss, uint8_t SCLK, uint8_t MISO, uint8_t MOSI, bool format_if_empty);
            //Initializes file system on SPI configurationprovided. SDss=SPI_CS. With more parameters for SD Returns True if successful.  
           //Default Initialize : spi=SPI, ssPin= -1, sck=-1, miso=-1, mosi=-1, frequency=4000000, mountpoint="/sd", max_files=5, format_if_empty=false
	        bool Initialize3(uint8_t spi, uint8_t SDss, uint8_t SCLK, uint8_t MISO, uint8_t MOSI, ULong frequency, byte max_files, bool format_if_empty);            
           
            void end();
            
            byte getcardType();

            ULong getcardSize();

            ULong gettotalBytes();

            ULong getusedBytes();

            bool readRAW(ArrayByte* buffer, ULong sector);

            bool writeRAW(ArrayByte* buffer, ULong sector);

	    //Opens a file in read only mode. Returns true if the file was opened successfully.
	    bool OpenRead (B4RString* FileName);
	    //Opens a file in read and write mode. Returns true if the file was opened successfully.
	    bool OpenReadWrite (B4RString* FileName);
   	    //Opens a file in append mode. Returns true if the file was opened successfully.
	    bool OpenAppend (B4RString* FileName);
	    //Returns the current open file.
	    B4RFile* getCurrentFile();
	    //Returns the stream of the current open file.
	    B4RStream* getStream();
	    //Gets or sets the position in the current open file.
	    ULong getPosition();
	    void SetPosition(ULong p);
	    //Closes the current open file.
	    void Close();
	    //Checks whether the given file or directory exist.
	    bool Exists(B4RString* FileName);
	    //Deletes the given file. Returns true if the file was successfully deleted.
	    bool Remove(B4RString* FileName);
            //Rename a file Returns true if rename is successfull.
	    bool Rename(B4RString* FileName1,B4RString* FileName2);
            //check if directory or file
            bool getIsDirectory();
            
	    bool MKDir (B4RString* DIRName);             

	    bool RMDir (B4RString* DIRName);                  
                       
		/**
		*Can be used in a For Each loop to iterate over the files in the folder.
		*Example:<code>
		 *For Each f As File In fs.ListFiles("/")
		 *	Log("Name: ", f.Name, ", Size: ", f.Size)
		 *Next</code>
		*/
	    FileIterator* ListFiles(B4RString* DirName);

            #define /*byte   ESP32_FSPI;*/             B4R_FSPI                 0x1 
            #define /*byte   ESP32_HSPI;*/             B4R_HSPI                 0x2
            #define /*byte   ESP32_VSPI;*/             B4R_VSPI                 0x3    
            #define /*byte   ESP32C3_FSPI;*/           B4RC3_FSPI               0x0   
            #define /*byte   ESP32C3_HSPI;*/           B4RC3_HSPI               0x1   
            #define /*byte   ESP32S2_FSPI;*/           B4RS2_FSPI               0x1   
            #define /*byte   ESP32S2_HSPI;*/           B4RS2_HSPI               0x2   
            #define /*byte   ESP32S3_FSPI;*/           B4RS3_FSPI               0x0   
            #define /*byte   ESP32S3_HSPI;*/           B4RS3_HSPI               0x1
                                                   
            #define /*Byte   CARD_NONE;*/          B4R_CARD_NONE           0   
            #define /*Byte   CARD_MMC;*/           B4R_CARD_MMC            1   
            #define /*Byte   CARD_SD;*/            B4R_CARD_SD             2  
            #define /*Byte   CARD_SDHC;*/          B4R_CARD_SDHC           3
            #define /*Byte   CARD_UNKNOWN;*/       B4R_CARD_UNKNOWN        4                                                      
	};
}