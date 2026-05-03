#include "B4RDefines.h"
namespace B4R
{
	
//class ArrayListByte
    void B4RArrayListByte::Initialize( byte typeSize, uint16_t initialSize)
    {  //typeSize =00,01 FIXED - DYNAMIC2  	
		   ArrayList<byte>  AlistBy(); // ArrayList<byte>::DYNAMIC2, initialSize);
		   AListBy.initsize(initialSize);		   
	   if ((typeSize &1)==01) {
	       AListBy.setSizeType(ArrayList<byte>::DYNAMIC2);			   
		   }
	   else {
	       AListBy.setSizeType(ArrayList<byte>::FIXED);			   
		}
    };	 

    bool B4RArrayListByte::add( byte item)
    {
       return AListBy.add(item);
    };

    bool B4RArrayListByte::insert(uint16_t index, byte item)
    {
       return AListBy.insert(index, item);
    };

    bool B4RArrayListByte::removeItem(byte item)
    {
       return AListBy.removeItem( item);
    };

    bool B4RArrayListByte::remove(uint16_t index)
    {
       return AListBy.remove(index);
    };

    void B4RArrayListByte::clear()
    {
       AListBy.clear();
    };

    byte B4RArrayListByte::get(uint16_t index)
    {
       return AListBy.get(index);
    };

	B4RString* B4RArrayListByte::getAsString(uint16_t index)
	{
	   String rax = String(AListBy.get( index));
       PrintToMemory pm;
       B4RString* s = B4RString::PrintableToString(NULL);
       pm.print(rax);
       StackMemory::buffer[StackMemory::cp++] = 0;
       return s;
	};	

    bool B4RArrayListByte::contains(byte item)
    {
       return AListBy.contains( item);
    };

    int16_t B4RArrayListByte::indexOf(byte item)
    {
       return AListBy.indexOf( item);
    };

    uint16_t B4RArrayListByte::capacity()
    {
       return AListBy.capacity();
    };

    uint16_t B4RArrayListByte::size()
    {
       return AListBy.size();
    };

    bool B4RArrayListByte::isEmpty()
    {
       return AListBy.isEmpty();
    };

    bool B4RArrayListByte::set( uint16_t index, byte item)
    {
       return AListBy.set(index, item);
    };

    bool B4RArrayListByte::removeRange(uint16_t fromIndex, uint16_t toIndex)
	{
	   return AListBy.removeRange(fromIndex, toIndex);
	};
	
	void B4RArrayListByte::ensureCapacity(uint16_t minCapacity)
	{
	   AListBy.ensureCapacity( minCapacity);
	};

    bool B4RArrayListByte::trimToSize()	
    {	
       return AListBy.trimToSize();
    };
	
	bool B4RArrayListByte::addAll(ArrayByte* other)
	{   int16_t len = other->length; byte* tmp1 =(byte*)other->data; 
        return AListBy.addAll( tmp1, len);
    };

    bool B4RArrayListByte::insertAll(uint16_t index, ArrayByte* other)
    {   int16_t len = other->length;	byte* tmp1 =(byte*)other->data;
        return AListBy.insertAll( index, tmp1, len);
	};
   
    bool B4RArrayListByte::toArray(ArrayByte* outputArray)
	{	int16_t len1 = AListBy.size(); int16_t len2 = outputArray->length;
		if (len2 < len1) {return false;}		
		byte* tmp2 = (byte*)outputArray->data;
        AListBy.toArray(tmp2);
		return true;
	};
    bool B4RArrayListByte::subtoArray(ArrayByte* outputArray, uint16_t fromIndex, uint16_t toIndex)
	{   int16_t len1 = toIndex-fromIndex; int16_t len2 = outputArray->length;
		if (len2 < len1) {return false;}
		byte* tmp2 = (byte*)outputArray->data;
	    AListBy.subtoArray(tmp2, fromIndex, toIndex);
		return true;
    };	

    void B4RArrayListByte::setSizeType(byte typeSize){
		if ((typeSize &1)==01) {
		   AListBy.setSizeType(ArrayList<byte>::DYNAMIC2);}
	   else {
	       AListBy.setSizeType(ArrayList<byte>::FIXED);}	 
    };

    byte B4RArrayListByte::getSizeType()
	{
		//SizeType tmp = 
		switch (AListBy.getSizeType()){
	    case ArrayList<byte>::DYNAMIC2 :
		   return 01;
		case ArrayList<byte>::DYNAMIC :
	       return 02;
	   case ArrayList<byte>::FIXED :
	       return 00;
	   default :
	      return 0xFF;}
    };

	
//class ArrayListInt
    void B4RArrayListInt::Initialize( byte typeSize, uint16_t initialSize)
    {  //typeSize =00,01,02  FIXED - FIXED2 - DYNAMIC2  
	   ArrayList<int16_t>  AlistI();
	   AListI.initsize(initialSize);
	   if ((typeSize &1)==01) {AListI.setSizeType(ArrayList<int16_t>::DYNAMIC2); }
	   else {AListI.setSizeType(ArrayList<int16_t>::FIXED);}
    };	 

    bool B4RArrayListInt::add( int16_t item)
    {
       return AListI.add(item);
    };

    bool B4RArrayListInt::insert(uint16_t index, int16_t item)
    {
       return AListI.insert(index, item);
    };

    bool B4RArrayListInt::removeItem(int16_t item)
    {
       return AListI.removeItem( item);
    };

    bool B4RArrayListInt::remove(uint16_t index)
    {
       return AListI.remove(index);
    };

    void B4RArrayListInt::clear()
    {
       AListI.clear();
    };

    int16_t B4RArrayListInt::get(uint16_t index)
    {
       return AListI.get(index);
    };
	
	B4RString* B4RArrayListInt::getAsString(uint16_t index)
	{
	   String rax = String(AListI.get( index));
       PrintToMemory pm;
       B4RString* s = B4RString::PrintableToString(NULL);
       pm.print(rax);
       StackMemory::buffer[StackMemory::cp++] = 0;
       return s;
	};

    bool B4RArrayListInt::contains(int16_t item)
    {
       return AListI.contains( item);
    };

    int16_t B4RArrayListInt::indexOf(int16_t item)
    {
       return AListI.indexOf( item);
    };

    uint16_t B4RArrayListInt::capacity()
    {
       return AListI.capacity();
    };

    uint16_t B4RArrayListInt::size()
    {
       return AListI.size();
    };

    bool B4RArrayListInt::isEmpty()
    {
       return AListI.isEmpty();
    };

    bool B4RArrayListInt::set( uint16_t index, int16_t item)
    {
       return AListI.set(index, item);
    };
	
    bool B4RArrayListInt::removeRange(uint16_t fromIndex, uint16_t toIndex)
	{
	   return AListI.removeRange(fromIndex, toIndex);
	};
	
	void B4RArrayListInt::ensureCapacity(uint16_t minCapacity)
	{
	   AListI.ensureCapacity( minCapacity);
	};

    bool B4RArrayListInt::trimToSize()	
    {	
       return AListI.trimToSize();
    };
			
	bool B4RArrayListInt::addAll(ArrayInt* other)
	{  int16_t len = other->length; int16_t* tmp1 =(int16_t*)other->data; 
        return AListI.addAll( tmp1, len);
    };

    bool B4RArrayListInt::insertAll(uint16_t index, ArrayInt* other)
    {  int16_t len = other->length;	int16_t* tmp1 =(int16_t*)other->data;
        return AListI.insertAll( index, tmp1, len);
	};
   
    bool B4RArrayListInt::toArray(ArrayInt* outputArray)
	{	int16_t len1 = AListI.size(); int16_t len2 = outputArray->length;
		if (len2 < len1) {return false;}		
		int16_t* tmp2 = (int16_t*)outputArray->data;
        AListI.toArray(tmp2);
		return true;
	};

    bool B4RArrayListInt::subtoArray(ArrayInt* outputArray, uint16_t fromIndex, uint16_t toIndex)
	{   int16_t len1 = toIndex-fromIndex; int16_t len2 = outputArray->length;
		if (len2 < len1) {return false;}
		int16_t* tmp2 = (int16_t*)outputArray->data;
	    AListI.subtoArray(tmp2, fromIndex, toIndex);
		return true;
    };
	
    void B4RArrayListInt::setSizeType(byte typeSize)
	{
		if ((typeSize &1)==01) {
		   AListI.setSizeType(ArrayList<int16_t>::DYNAMIC2);}
	   else {
	       AListI.setSizeType(ArrayList<int16_t>::FIXED);}	 
    };

    byte B4RArrayListInt::getSizeType()
	{
		//SizeType tmp = 
		switch (AListI.getSizeType()){
	    case ArrayList<int16_t>::DYNAMIC2 :
		   return 01;
	    case ArrayList<int16_t>::DYNAMIC :
	       return 02;	   
	   case ArrayList<int16_t>::FIXED :
	       return 00;
	   default :
	      return 0xFF;}
    };


	

//class ArrayListUInt
    void B4RArrayListUInt::Initialize( byte typeSize, uint16_t initialSize)
    {  //typeSize =00,01  FIXED - DYNAMIC2  
	   ArrayList<uint16_t>  AlistUI();
	   AListUI.initsize(initialSize);	
	   if ((typeSize &1)==01) {AListUI.setSizeType(ArrayList<uint16_t>::DYNAMIC2); }
	   else {AListUI.setSizeType(ArrayList<uint16_t>::FIXED);}
    };
	
    bool B4RArrayListUInt::add( uint16_t item)
    {
       return AListUI.add(item);
    };

    bool B4RArrayListUInt::insert(uint16_t index, uint16_t item)
    {
       return AListUI.insert(index, item);
    };

    bool B4RArrayListUInt::removeItem(uint16_t item)
    {
       return AListUI.removeItem( item);
    };

    bool B4RArrayListUInt::remove(uint16_t index)
    {
       return AListUI.remove(index);
    };

    void B4RArrayListUInt::clear()
    {
       AListUI.clear();
    };

    uint16_t B4RArrayListUInt::get(uint16_t index)
    {
       return AListUI.get(index);
    };

	B4RString* B4RArrayListUInt::getAsString(uint16_t index)
	{
	   String rax = String(AListUI.get( index));
       PrintToMemory pm;
       B4RString* s = B4RString::PrintableToString(NULL);
       pm.print(rax);
       StackMemory::buffer[StackMemory::cp++] = 0;
       return s;
	};

    bool B4RArrayListUInt::contains(uint16_t item)
    {
       return AListUI.contains( item);
    };

    int16_t B4RArrayListUInt::indexOf(uint16_t item)
    {
       return AListUI.indexOf( item);
    };

    uint16_t B4RArrayListUInt::capacity()
    {
       return AListUI.capacity();
    };

    uint16_t B4RArrayListUInt::size()
    {
       return AListUI.size();
    };

    bool B4RArrayListUInt::isEmpty()
    {
       return AListUI.isEmpty();
    };

    bool B4RArrayListUInt::set( uint16_t index, uint16_t item)
    {
       return AListUI.set(index, item);
    };
	
    bool B4RArrayListUInt::removeRange(uint16_t fromIndex, uint16_t toIndex)
	{
	   return AListUI.removeRange(fromIndex, toIndex);
	};
	
	void B4RArrayListUInt::ensureCapacity(uint16_t minCapacity)
	{
	   AListUI.ensureCapacity( minCapacity);
	};

    bool B4RArrayListUInt::trimToSize()	
    {	
       return AListUI.trimToSize();
    };

	bool B4RArrayListUInt::addAll(ArrayUInt* other)
	{  int16_t len = other->length; uint16_t* tmp1 =(uint16_t*)other->data; 
        return AListUI.addAll( tmp1, len);
    };

    bool B4RArrayListUInt::insertAll(uint16_t index, ArrayUInt* other)
    {  int16_t len = other->length;	uint16_t* tmp1 =(uint16_t*)other->data;
        return AListUI.insertAll( index, tmp1, len);
	};
   
    bool B4RArrayListUInt::toArray(ArrayUInt* outputArray)
	{	int16_t len1 = AListUI.size(); int16_t len2 = outputArray->length;
		if (len2 < len1) {return false;}		
		uint16_t* tmp2 = (uint16_t*)outputArray->data;
        AListUI.toArray(tmp2);
		return true;
	};
	
	bool B4RArrayListUInt::subtoArray(ArrayUInt* outputArray, uint16_t fromIndex, uint16_t toIndex)
	{   int16_t len1 = toIndex-fromIndex; int16_t len2 = outputArray->length;
		if (len2 < len1) {return false;}
		uint16_t* tmp2 = (uint16_t*)outputArray->data;
	    AListUI.subtoArray(tmp2, fromIndex, toIndex);
		return true;
    };
	
    void B4RArrayListUInt::setSizeType(byte typeSize)
	{
		if ((typeSize &1)==01) {
		   AListUI.setSizeType(ArrayList<uint16_t>::DYNAMIC2);}
	   else {
	       AListUI.setSizeType(ArrayList<uint16_t>::FIXED);}	 
    };

    byte B4RArrayListUInt::getSizeType()
	{
		//SizeType tmp = 
		switch (AListUI.getSizeType()){
	    case ArrayList<uint16_t>::DYNAMIC2 :
		   return 01;
       case ArrayList<uint16_t>::DYNAMIC :
	       return 02;		   
	   case ArrayList<uint16_t>::FIXED :
	       return 00;
	   default :
	      return 0xFF;}
    };

//class ArrayListLong
    void B4RArrayListLong::Initialize( byte typeSize, uint16_t initialSize)
    {  //typeSize =00,01  FIXED - DYNAMIC2  
		   ArrayList<int32_t>  AlistL();
		   AListL.initsize(initialSize);	
	   if ((typeSize &1)==01) {AListL.setSizeType(ArrayList<int32_t>::DYNAMIC2); }
	   else  {AListL.setSizeType(ArrayList<int32_t>::FIXED); }
    }; 

    bool B4RArrayListLong::add( int32_t item)
    {
       return AListL.add(item);
    };

    bool B4RArrayListLong::insert(uint16_t index, int32_t item)
    {
       return AListL.insert(index, item);
    };

    bool B4RArrayListLong::removeItem(int32_t item)
    {
       return AListL.removeItem( item);
    };

    bool B4RArrayListLong::remove(uint16_t index)
    {
       return AListL.remove(index);
    };

    void B4RArrayListLong::clear()
    {
       AListL.clear();
    };

    int32_t B4RArrayListLong::get(uint16_t index)
    {
       return AListL.get(index);
    };

	B4RString* B4RArrayListLong::getAsString(uint16_t index)
	{
	   String rax = String(AListL.get( index));
       PrintToMemory pm;
       B4RString* s = B4RString::PrintableToString(NULL);
       pm.print(rax);
       StackMemory::buffer[StackMemory::cp++] = 0;
       return s;
	};

    bool B4RArrayListLong::contains(int32_t item)
    {
       return AListL.contains( item);
    };

    int16_t B4RArrayListLong::indexOf(int32_t item)
    {
       return AListL.indexOf( item);
    };

    uint16_t B4RArrayListLong::capacity()
    {
       return AListL.capacity();
    };

    uint16_t B4RArrayListLong::size()
    {
       return AListL.size();
    };

    bool B4RArrayListLong::isEmpty()
    {
       return AListL.isEmpty();
    };

    bool B4RArrayListLong::set( uint16_t index, int32_t item)
    {
       return AListL.set(index, item);
    };

    bool B4RArrayListLong::removeRange(uint16_t fromIndex, uint16_t toIndex)
	{
	   return AListL.removeRange(fromIndex, toIndex);
	};
	
	void B4RArrayListLong::ensureCapacity(uint16_t minCapacity)
	{
	   AListL.ensureCapacity( minCapacity);
	};

    bool B4RArrayListLong::trimToSize()	
    {	
       return AListL.trimToSize();
    };
	
	bool B4RArrayListLong::addAll(ArrayLong* other)
	{  int16_t len = other->length; int32_t* tmp1 =(int32_t*)other->data; 
        return AListL.addAll( tmp1, len);
    };

    bool B4RArrayListLong::insertAll(uint16_t index, ArrayLong* other)
    {  int16_t len = other->length;	int32_t* tmp1 =(int32_t*)other->data;
        return AListL.insertAll( index, tmp1, len);
	};
   
    bool B4RArrayListLong::toArray(ArrayLong* outputArray)
	{	int16_t len1 = AListL.size(); int16_t len2 = outputArray->length;
		if (len2 < len1) {return false;}		
		int32_t* tmp2 = (int32_t*)outputArray->data;
        AListL.toArray(tmp2);
		return true;
	};
	
    bool B4RArrayListLong::subtoArray(ArrayLong* outputArray, uint16_t fromIndex, uint16_t toIndex)
	{   int16_t len1 = toIndex-fromIndex; int16_t len2 = outputArray->length;
		if (len2 < len1) {return false;}
		int32_t* tmp2 = (int32_t*)outputArray->data;
	    AListL.subtoArray(tmp2, fromIndex, toIndex);
		return true;
    };
	
    void B4RArrayListLong::setSizeType(byte typeSize)
	{
		if ((typeSize &1)==01) {
		   AListL.setSizeType(ArrayList<int32_t>::DYNAMIC2);}
	   else {
	       AListL.setSizeType(ArrayList<int32_t>::FIXED);}	 
    };	
	
	byte B4RArrayListLong::getSizeType()
	{
		//SizeType tmp = 
		switch (AListL.getSizeType()){
	    case ArrayList<int32_t>::DYNAMIC2 :
		   return 01;
       case ArrayList<int32_t>::DYNAMIC :
	       return 02;		   
	   case ArrayList<int32_t>::FIXED :
	       return 00;
	   default :
	      return 0xFF;}
    };
	
	
//class ArrayListULong
    void B4RArrayListULong::Initialize( byte typeSize, uint16_t initialSize)
    {  //typeSize =00,01  FIXED - DYNAMIC2  
		ArrayList<uint32_t>  AlistUL();
		AListUL.initsize(initialSize);	
	   if ((typeSize &1)==01) {AListUL.setSizeType(ArrayList<uint32_t>::DYNAMIC2); }
	   else {AListUL.setSizeType(ArrayList<uint32_t>::FIXED);}
    };	

    bool B4RArrayListULong::add( uint32_t item)
    {
       return AListUL.add(item);
    };

    bool B4RArrayListULong::insert(uint16_t index, uint32_t item)
    {
       return AListUL.insert(index, item);
    };

    bool B4RArrayListULong::removeItem(uint32_t item)
    {
       return AListUL.removeItem( item);
    };

    bool B4RArrayListULong::remove(uint16_t index)
    {
       return AListUL.remove(index);
    };

    void B4RArrayListULong::clear()
    {
       AListUL.clear();
    };

    uint32_t B4RArrayListULong::get(uint16_t index)
    {
       return AListUL.get(index);
    };
	B4RString* B4RArrayListULong::getAsString(uint16_t index)
	{
	   String rax = String(AListUL.get( index));
       PrintToMemory pm;
       B4RString* s = B4RString::PrintableToString(NULL);
       pm.print(rax);
       StackMemory::buffer[StackMemory::cp++] = 0;
       return s;
	};
    bool B4RArrayListULong::contains(uint32_t item)
    {
       return AListUL.contains( item);
    };

    int16_t B4RArrayListULong::indexOf(uint32_t item)
    {
       return AListUL.indexOf( item);
    };

    uint16_t B4RArrayListULong::capacity()
    {
       return AListUL.capacity();
    };

    uint16_t B4RArrayListULong::size()
    {
       return AListUL.size();
    };

    bool B4RArrayListULong::isEmpty()
    {
       return AListUL.isEmpty();
    };

    bool B4RArrayListULong::set( uint16_t index, uint32_t item)
    {
       return AListUL.set(index, item);
    };

    bool B4RArrayListULong::removeRange(uint16_t fromIndex, uint16_t toIndex)
	{
	   return AListUL.removeRange(fromIndex, toIndex);
	};
	
	void B4RArrayListULong::ensureCapacity(uint16_t minCapacity)
	{
	   AListUL.ensureCapacity( minCapacity);
	};

    bool B4RArrayListULong::trimToSize()	
    {	
       return AListUL.trimToSize();
    };	

	bool B4RArrayListULong::addAll(ArrayULong* other)
	{  int16_t len = other->length; uint32_t* tmp1 =(uint32_t*)other->data; 
        return AListUL.addAll( tmp1, len);
    };

    bool B4RArrayListULong::insertAll(uint16_t index, ArrayULong* other)
    {  int16_t len = other->length;	uint32_t* tmp1 =(uint32_t*)other->data;
        return AListUL.insertAll( index, tmp1, len);
	};
   
    bool B4RArrayListULong::toArray(ArrayULong* outputArray)
	{	int16_t len1 = AListUL.size(); int16_t len2 = outputArray->length;
		if (len2 < len1) {return false;}		
		uint32_t* tmp2 = (uint32_t*)outputArray->data;
        AListUL.toArray(tmp2);
		return true;
	};
	
	bool B4RArrayListULong::subtoArray(ArrayULong* outputArray, uint16_t fromIndex, uint16_t toIndex)
	{   int16_t len1 = toIndex-fromIndex; int16_t len2 = outputArray->length;
		if (len2 < len1) {return false;}
		uint32_t* tmp2 = (uint32_t*)outputArray->data;
	    AListUL.subtoArray(tmp2, fromIndex, toIndex);
		return true;
    };
	
    void B4RArrayListULong::setSizeType(byte typeSize)
	{
		if ((typeSize &1)==01) {
		   AListUL.setSizeType(ArrayList<uint32_t>::DYNAMIC2);}
	   else {
	       AListUL.setSizeType(ArrayList<uint32_t>::FIXED);}	 
    };	
	
	byte B4RArrayListULong::getSizeType()
	{
		//SizeType tmp = 
		switch (AListUL.getSizeType()){
	    case ArrayList<uint32_t>::DYNAMIC2 :
		   return 01;
       case ArrayList<uint32_t>::DYNAMIC :
	       return 02;		   
	   case ArrayList<uint32_t>::FIXED :
	       return 00;
	   default :
	      return 0xFF;}
    };


//class ArrayListDouble
    void B4RArrayListDouble::Initialize( byte typeSize, uint16_t initialSize)
    {  //typeSize =00,01  FIXED - DYNAMIC2  
		ArrayList<float>  AlistDo();
		AListDo.initsize(initialSize);	
	   if ((typeSize &1)==01) {AListDo.setSizeType(ArrayList<float>::DYNAMIC2); }
	   else {AListDo.setSizeType(ArrayList<float>::FIXED);}
    };	

    bool B4RArrayListDouble::add( float item)
    {
       return AListDo.add(item);
    };

    bool B4RArrayListDouble::insert(uint16_t index, float item)
    {
       return AListDo.insert(index, item);
    };

    bool B4RArrayListDouble::removeItem(float item)
    {
       return AListDo.removeItem( item);
    };

    bool B4RArrayListDouble::remove(uint16_t index)
    {
       return AListDo.remove(index);
    };

    void B4RArrayListDouble::clear()
    {
       AListDo.clear();
    };

    float B4RArrayListDouble::get(uint16_t index)
    {
       return AListDo.get(index);
    };
	B4RString* B4RArrayListDouble::getAsString(uint16_t index)
	{
	   String rax = String(AListDo.get( index));
       PrintToMemory pm;
       B4RString* s = B4RString::PrintableToString(NULL);
       pm.print(rax);
       StackMemory::buffer[StackMemory::cp++] = 0;
       return s;
	};
    bool B4RArrayListDouble::contains(float item)
    {
       return AListDo.contains( item);
    };

    int16_t B4RArrayListDouble::indexOf(float item)
    {
       return AListDo.indexOf( item);
    };

    uint16_t B4RArrayListDouble::capacity()
    {
       return AListDo.capacity();
    };

    uint16_t B4RArrayListDouble::size()
    {
       return AListDo.size();
    };

    bool B4RArrayListDouble::isEmpty()
    {
       return AListDo.isEmpty();
    };

    bool B4RArrayListDouble::set( uint16_t index, float item)
    {
       return AListDo.set(index, item);
    };

    bool B4RArrayListDouble::removeRange(uint16_t fromIndex, uint16_t toIndex)
	{
	   return AListDo.removeRange(fromIndex, toIndex);
	};
	
	void B4RArrayListDouble::ensureCapacity(uint16_t minCapacity)
	{
	   AListDo.ensureCapacity( minCapacity);
	};

    bool B4RArrayListDouble::trimToSize()	
    {	
       return AListDo.trimToSize();
    };	

	bool B4RArrayListDouble::addAll(ArrayDouble* other)
	{  int16_t len = other->length; float* tmp1 =(float*)other->data; 
        return AListDo.addAll( tmp1, len);
    };

    bool B4RArrayListDouble::insertAll(uint16_t index, ArrayDouble* other)
    {  int16_t len = other->length;	float* tmp1 =(float*)other->data;
        return AListDo.insertAll( index, tmp1, len);
	};
   
    bool B4RArrayListDouble::toArray(ArrayDouble* outputArray)
	{	int16_t len1 = AListDo.size(); int16_t len2 = outputArray->length;
		if (len2 < len1) {return false;}		
		float* tmp2 = (float*)outputArray->data;
        AListDo.toArray(tmp2);
		return true;
	};
	
	bool B4RArrayListDouble::subtoArray(ArrayDouble* outputArray, uint16_t fromIndex, uint16_t toIndex)
	{   int16_t len1 = toIndex-fromIndex; int16_t len2 = outputArray->length;
		if (len2 < len1) {return false;}
		float* tmp2 = (float*)outputArray->data;
	    AListDo.subtoArray(tmp2, fromIndex, toIndex);
		return true;
    };
	
    void B4RArrayListDouble::setSizeType(byte typeSize)
	{
		if ((typeSize &1)==01) {
		   AListDo.setSizeType(ArrayList<float>::DYNAMIC2);}
	   else {
	       AListDo.setSizeType(ArrayList<float>::FIXED);}	 
    };	
	
	byte B4RArrayListDouble::getSizeType()
	{
		//SizeType tmp = 
		switch (AListDo.getSizeType()){
	    case ArrayList<float>::DYNAMIC2 :
		   return 01;
       case ArrayList<float>::DYNAMIC :
	       return 02;		   
	   case ArrayList<float>::FIXED :
	       return 00;
	   default :
	      return 0xFF;}
    };
	
	
	
//class ArrayListString
    void B4RArrayListString::Initialize( byte typeSize, uint16_t initialSize)
    {  //typeSize =00,01 FIXED - DYNAMIC2 
		ArrayList<String>  AlistStr();
		AListStr.initsize(initialSize);	
	   if ((typeSize &1)==01) {AListStr.setSizeType(ArrayList<String>::DYNAMIC2);}
	   else {AListStr.setSizeType(ArrayList<String>::FIXED);}
    };	 

    bool B4RArrayListString::add( B4RString* item)
    {
       return AListStr.add(item->data);
    };

    bool B4RArrayListString::insert(uint16_t index, B4RString* item)
    {
       return AListStr.insert(index, item->data);
    };

    bool B4RArrayListString::removeItem(B4RString* item)
    {
       return AListStr.removeItem( item->data);
    };

    bool B4RArrayListString::remove(uint16_t index)
    {
       return AListStr.remove(index);
    };

    void B4RArrayListString::clear()
    {
       AListStr.clear();
    };

    B4RString* B4RArrayListString::get(uint16_t index)
    {
       String rax = AListStr.get(index);
       PrintToMemory pm;
       B4RString* s = B4RString::PrintableToString(NULL);
       pm.print(rax);
       StackMemory::buffer[StackMemory::cp++] = 0;
       return s;
    };

    bool B4RArrayListString::contains(B4RString* item)
    {
       return AListStr.contains( item->data);
    };

    int16_t B4RArrayListString::indexOf(B4RString* item)
    {
       return AListStr.indexOf( item->data);
    };

    uint16_t B4RArrayListString::capacity()
    {
       return AListStr.capacity();
    };

    uint16_t B4RArrayListString::size()
    {
       return AListStr.size();
    };

    bool B4RArrayListString::isEmpty()
    {
       return AListStr.isEmpty();
    };

    bool B4RArrayListString::set( uint16_t index, B4RString* item)
    {
       return AListStr.set(index, item->data);
    };

    bool B4RArrayListString::removeRange(uint16_t fromIndex, uint16_t toIndex)
	{
	   return AListStr.removeRange(fromIndex, toIndex);
	};
	
	void B4RArrayListString::ensureCapacity(uint16_t minCapacity)
	{
	   AListStr.ensureCapacity( minCapacity);
	};

    bool B4RArrayListString::trimToSize()	
    {	
       return AListStr.trimToSize();
    };
	
	void B4RArrayListString::concat(uint16_t index1, uint16_t index2)
	{
	   AListStr.set(index1, (AListStr.get(index1)+AListStr.get(index2)));
	};		

	void B4RArrayListString::join(uint16_t index1, B4RString* item)
	{
	   AListStr.set(index1, (AListStr.get(index1)+item->data));
	};   
	
    void B4RArrayListString::setSizeType(byte typeSize)
	{
		if ((typeSize &1)==01) {
		   AListStr.setSizeType(ArrayList<String>::DYNAMIC2);}
	   else {
	       AListStr.setSizeType(ArrayList<String>::FIXED);}	 
    };	
	
	byte B4RArrayListString::getSizeType()
	{
		//SizeType tmp = 
		switch (AListStr.getSizeType()){
	    case ArrayList<String>::DYNAMIC2 :
		   return 01;
       case ArrayList<String>::DYNAMIC :
	       return 02;
	   case ArrayList<String>::FIXED :
	       return 00;
	   default :
	      return 0xFF;}
    };
}












		 
	   
       	

//    enum SizeType { FIXED, DYNAMIC, DYNAMIC2 }; // Size type
//    enum SortAlgorithm { BUBBLE_SORT, QUICK_SORT, MERGE_SORT }; // Sorting algorithms

//https://github.com/braydenanderson2014/C-Arduino-Libraries/tree/main/lib/ArrayList