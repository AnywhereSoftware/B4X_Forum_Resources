#pragma once
#include "B4RDefines.h"
#include "ArrayList.h"
//#define SkinnyArray


    //~Event: 
    //~Version: 1 
    //~Author - 
    //~Libray Arduino from https://github.com/braydenanderson2014/C-Arduino-Libraries/tree/main/lib/ArrayList

namespace B4R
{
   //~shortname:ArrayListByte
   class B4RArrayListByte
    {
      private:
         ArrayList<byte> AListBy;
      public:
// * @brief Constructs a new ArrayList.
// *
// * This constructor creates a new ArrayList with the specified size type, initial size.
// * The size type determines whether the size of the ArrayList is static or dynamic. The initial size specifies
// * the initial capacity of the ArrayList. 
// *
// * @param type The size type of the ArrayList. This should be either DYNAMIC or STATIC.
// * @param initialSize The initial capacity of the ArrayList.	  
         void Initialize( byte typeSize, uint16_t initialSize);

// * @brief Adds an item to the ArrayList.
// *
// * This function adds the specified item to the ArrayList. If the size type of the ArrayList is DYNAMIC and the ArrayList is full, 
// * it resizes the ArrayList to accommodate the new item. If the ArrayList is not full, it adds the item to the ArrayList.
// * If the ArrayList is full and its size type is STATIC, it does not add the item.
// * @param item The item to add to the ArrayList.
         bool add( byte item);
		 
// * @brief Inserts an item at a specific index in the ArrayList.
// *
// * This function inserts the specified item at the specified index in the ArrayList. If the index is greater than the count of items in the ArrayList, 
// * it returns false. If the ArrayList is full, it resizes the ArrayList if its size type is DYNAMIC, or returns false if its size type is STATIC.
// * If the index is valid and the ArrayList is not full, or has been resized successfully, it shifts all items from the index to the end of the ArrayList one position to the right, inserts the item at the index, and increments the count of items.
// *
// * @param index The index at which to insert the item.
// * @param item The item to insert.
// * @return true if the item was inserted successfully, false otherwise.
         bool insert(uint16_t index, byte item);

// * @brief Removes an item from the ArrayList.
// *
// * This function removes the specified item from the ArrayList. If the item is not found in the ArrayList, it prints an error message and returns false.
// * If the item is found in the ArrayList, it removes the item from the ArrayList and returns true.
// *
// * @param item The item to remove from the ArrayList.
// * @return true if the item was removed successfully, false otherwise.
         bool removeItem(byte item);

// * @brief Removes an item at a specific index from the ArrayList.
// *
// * This function removes the item at the specified index from the ArrayList. If the index is less than the count of items in the ArrayList, 
// * it shifts all items from the index + 1 to the end of the ArrayList one position to the left, and decrements the count of items.
// *
// * @param index The index of the item to remove.
         bool remove(uint16_t index);

// * @brief Clears all items from the ArrayList.
// *
// * This function clears all items from the ArrayList and sets the count of items to 0.
         void clear();

// * @brief Retrieves the item at a specific index in the ArrayList.
// *
// * This function retrieves the item at the specified index in the ArrayList. If the index is less than the count of items in the ArrayList, 
// * it returns the item at the index. If the index is out of bounds, it returns a default-constructed instance.
// *
// * @param index The index of the item to retrieve.
// * @return The item at the specified index, or a default-constructed instance if the index is out of bounds.
         byte get(uint16_t index);

// * @brief Retrieves the item at a specific index in the ArrayList as a String.
// *
// * This function retrieves the item at the specified index in the ArrayList and converts it to a String. If the index is less than the count of items in the ArrayList,
// * it returns the item at the index as a String. If the index is out of bounds, it returns a default-constructed instance of type T as a String.
// *
// * @param index The index of the item to retrieve.
// * @return The item at the specified index as a String, or a default-constructed instance of type T as a String if the index is out of bounds.
		B4RString* getAsString(uint16_t index);

// * @brief Checks if the ArrayList contains an item.
// *
// * This function checks if the ArrayList contains the specified item. If the item is found in the ArrayList, it returns true.
// * If the item is not found in the ArrayList, it returns false.
// *
// * @param item The item to check for.
// * @return true if the ArrayList contains the item, false otherwise.
         bool contains(byte item);
		 
// * @brief Finds the index of the first occurrence of the specified item in the ArrayList.
// *
// * This function returns the index of the first occurrence of the specified item in the ArrayList, or -1 if the ArrayList does not contain the item.
// * It iterates over the ArrayList from the beginning to the end, comparing each item with the specified item using the == operator.
// * If it finds a match, it returns the index of the match. If it does not find a match, it prints an error message (if debug is true) and returns -1.
// *
// * @param item The item to find in the ArrayList.
// * @return The index of the first occurrence of the item in the ArrayList, or -1 if the ArrayList does not contain the item.
         int16_t indexOf(byte item);

// * @brief Retrieves the capacity of the ArrayList.
// *
// * This function returns the current capacity of the ArrayList, which is the maximum number of items it can hold without resizing.
// *
// * @return The capacity of the ArrayList.
         uint16_t capacity();

// * @brief Retrieves the count of items in the ArrayList.
// *
// * This function returns the current count of items in the ArrayList.
// *
// * @return The count of items in the ArrayList.
         uint16_t size();

// * @brief Checks if the ArrayList is empty.
// *
// * This function checks if the ArrayList is empty. If the ArrayList is empty, it returns true. If the ArrayList is not empty, it returns false.
// *
// * @return true if the ArrayList is empty, false otherwise.
         bool isEmpty();

// * @brief Sets the item at a specific index in the ArrayList.
// *
// * This function updates the item at the specified index in the ArrayList with the provided item.
// * If the index is within bounds, it sets the item and returns true if the operation succeeds.
// * If the index is out of bounds, it returns false.
// *
// * @param index The index at which to set the item.
// * @param item The item to set at the specified index.
// * @return true if the item was successfully set, false if the item was not set or the index is out of bounds.
         bool set( uint16_t index, byte item);

// * @brief Removes a range of items from the ArrayList.
// *
// * This function removes a range of items from the ArrayList, from the specified fromIndex (inclusive) to the specified toIndex (exclusive).
// * If fromIndex is greater than toIndex, or if either index is out of bounds, it prints an error message and returns without removing any items.
// * If the indices are valid, it shifts all items from toIndex to the end of the ArrayList to the left to fill the gaps left by the removed items, and decrements the count of items by the number of removed items.
// *
// * @param fromIndex The start index of the range to remove (inclusive).
// * @param toIndex The end index of the range to remove (exclusive).	
         bool removeRange(uint16_t fromIndex, uint16_t toIndex);

// * @brief Ensures that the ArrayList can hold at least the specified number of items without needing to resize.
// *
// * This function checks if the ArrayList's current capacity is less than the specified minimum capacity.
// * If it is, it resizes the ArrayList to the specified minimum capacity.
// * The function uses the memcpy function to copy the items to the new array, so the type T must be trivially copyable.
// *
// * @param minCapacity The minimum capacity that the ArrayList should be able to hold without resizing.	
	     void ensureCapacity(uint16_t minCapacity);

// * @brief Trims the capacity of the ArrayList to its current size.
// *
// * This function reduces the capacity of the ArrayList to its current size, i.e., the number of items it contains.
// * If the ArrayList is dynamic and its capacity is greater than its size, it creates a new array with a capacity equal to the size, copies the items to the new array, and deletes the old array.
// * If the ArrayList is already trimmed or is fixed size, it prints an error message (if debug is true).
         bool trimToSize();	

// * @brief Adds all items from an array to this ArrayList.
// *
// * This function adds all items from the specified array to this ArrayList. If the size type of this ArrayList is DYNAMIC and 
// * the total count of items in the ArrayList and the array exceeds the capacity of this ArrayList, it resizes this ArrayList to accommodate the new items.
// * If the total count of items in the ArrayList and the array does not exceed the capacity of this ArrayList, it adds the items from the array to this ArrayList.
// * If the total count of items in the ArrayList and the array exceeds the capacity of this ArrayList and its size type is STATIC, it prints an error message and does not add the items.
// *
// * @param other The array/List whose items should be added to this ArrayList.
// * @param length The length of the array/List.
// * @return true if the items were added successfully, false otherwise.		 
	    bool addAll(ArrayByte* other);
		
// * @brief Inserts all items from an array at a specific index in this ArrayList.
// *
// * This function inserts all items from the specified array at the specified index in this ArrayList. 
// * If the index is greater than the count of items in this ArrayList, it returns false. 
// * If the ArrayList is full, it resizes the ArrayList if its size type is DYNAMIC, or returns false if its size type is STATIC.
// * If the index is valid and the ArrayList is not full, or has been resized successfully, it shifts all items from the index to the end of the ArrayList one position to the right, inserts the items from the array at the index, and increments the count of items.
// *
// * @param index The index at which to insert the items.
// * @param other The array whose items should be inserted.
// * @param length The length of the array/List.
// * @return true if the items were inserted successfully, false otherwise.
        bool insertAll(uint16_t index, ArrayByte* other);

// * @brief Converts the ArrayList to an array.
// *
// * This function copies the items from the ArrayList into the specified output array.
// * The output array must be large enough to hold all items in the ArrayList.
// * The function uses the memcpy function to copy the items, so the type T must be trivially copyable.
// *
// * @param outputArray The array into which to copy the items.
// * @return The output array.		
		bool toArray(ArrayByte* outputArray);
		
		bool subtoArray(ArrayByte* outputArray, uint16_t fromIndex, uint16_t toIndex);
		 
// * @brief Sets the size type of the ArrayList.
// *
// * This function sets the size type of the ArrayList. (DYNAMIC, DYNAMIC2, FIXED)
// * 
// * @param type The size type to set.		 
        void setSizeType(byte typeSize);

// * @brief Gets the size type of the ArrayList.
// *
// * This function gets the size type of the ArrayList. (DYNAMIC, DYNAMIC2, FIXED)
// * 
// * @return The size type of the ArrayList.
        byte getSizeType();
		
		 
//ArrayType		 
	 #define /*Byte LIST_FIXED;*/ B4R_FIXED                             		 0
//ArrayType	 
     #define /*Byte LIST_DYNAMIC;*/ B4R_DYNAMIC2                                 1  		 
    };
	
	
	
   //~shortname:ArrayListInt
   class B4RArrayListInt
    {
      private:
         ArrayList<int16_t> AListI;
      public:
// * @brief Constructs a new ArrayList.
// *
// * This constructor creates a new ArrayList with the specified size type, initial size.
// * The size type determines whether the size of the ArrayList is static or dynamic. The initial size specifies
// * the initial capacity of the ArrayList. 
// *
// * @param type The size type of the ArrayList. This should be either DYNAMIC or STATIC.
// * @param initialSize The initial capacity of the ArrayList.	  
         void Initialize( byte typeSize, uint16_t initialSize);

// * @brief Adds an item to the ArrayList.
// *
// * This function adds the specified item to the ArrayList. If the size type of the ArrayList is DYNAMIC and the ArrayList is full, 
// * it resizes the ArrayList to accommodate the new item. If the ArrayList is not full, it adds the item to the ArrayList.
// * If the ArrayList is full and its size type is STATIC, it does not add the item.
// * @param item The item to add to the ArrayList.
         bool add( int16_t item);
		 
// * @brief Inserts an item at a specific index in the ArrayList.
// *
// * This function inserts the specified item at the specified index in the ArrayList. If the index is greater than the count of items in the ArrayList, 
// * it returns false. If the ArrayList is full, it resizes the ArrayList if its size type is DYNAMIC, or returns false if its size type is STATIC.
// * If the index is valid and the ArrayList is not full, or has been resized successfully, it shifts all items from the index to the end of the ArrayList one position to the right, inserts the item at the index, and increments the count of items.
// *
// * @param index The index at which to insert the item.
// * @param item The item to insert.
// * @return true if the item was inserted successfully, false otherwise.
         bool insert(uint16_t index, int16_t item);

// * @brief Removes an item from the ArrayList.
// *
// * This function removes the specified item from the ArrayList. If the item is not found in the ArrayList, it prints an error message and returns false.
// * If the item is found in the ArrayList, it removes the item from the ArrayList and returns true.
// *
// * @param item The item to remove from the ArrayList.
// * @return true if the item was removed successfully, false otherwise.
         bool removeItem(int16_t item);

// * @brief Removes an item at a specific index from the ArrayList.
// *
// * This function removes the item at the specified index from the ArrayList. If the index is less than the count of items in the ArrayList, 
// * it shifts all items from the index + 1 to the end of the ArrayList one position to the left, and decrements the count of items.
// *
// * @param index The index of the item to remove.
         bool remove(uint16_t index);

// * @brief Clears all items from the ArrayList.
// *
// * This function clears all items from the ArrayList and sets the count of items to 0.
         void clear();

// * @brief Retrieves the item at a specific index in the ArrayList.
// *
// * This function retrieves the item at the specified index in the ArrayList. If the index is less than the count of items in the ArrayList, 
// * it returns the item at the index. If the index is out of bounds, it returns a default-constructed instance.
// *
// * @param index The index of the item to retrieve.
// * @return The item at the specified index, or a default-constructed instance if the index is out of bounds.
         int16_t get(uint16_t index);
// * @brief Retrieves the item at a specific index in the ArrayList as a String.
// *
// * This function retrieves the item at the specified index in the ArrayList and converts it to a String. If the index is less than the count of items in the ArrayList,
// * it returns the item at the index as a String. If the index is out of bounds, it returns a default-constructed instance of type T as a String.
// *
// * @param index The index of the item to retrieve.
// * @return The item at the specified index as a String, or a default-constructed instance of type T as a String if the index is out of bounds.
		B4RString* getAsString(uint16_t index);
		
// * @brief Checks if the ArrayList contains an item.
// *
// * This function checks if the ArrayList contains the specified item. If the item is found in the ArrayList, it returns true.
// * If the item is not found in the ArrayList, it returns false.
// *
// * @param item The item to check for.
// * @return true if the ArrayList contains the item, false otherwise.
         bool contains(int16_t item);
		 
// * @brief Finds the index of the first occurrence of the specified item in the ArrayList.
// *
// * This function returns the index of the first occurrence of the specified item in the ArrayList, or -1 if the ArrayList does not contain the item.
// * It iterates over the ArrayList from the beginning to the end, comparing each item with the specified item using the == operator.
// * If it finds a match, it returns the index of the match. If it does not find a match, it prints an error message (if debug is true) and returns -1.
// *
// * @param item The item to find in the ArrayList.
// * @return The index of the first occurrence of the item in the ArrayList, or -1 if the ArrayList does not contain the item.
         int16_t indexOf(int16_t item);

// * @brief Retrieves the capacity of the ArrayList.
// *
// * This function returns the current capacity of the ArrayList, which is the maximum number of items it can hold without resizing.
// *
// * @return The capacity of the ArrayList.
         uint16_t capacity();

// * @brief Retrieves the count of items in the ArrayList.
// *
// * This function returns the current count of items in the ArrayList.
// *
// * @return The count of items in the ArrayList.
         uint16_t size();

// * @brief Checks if the ArrayList is empty.
// *
// * This function checks if the ArrayList is empty. If the ArrayList is empty, it returns true. If the ArrayList is not empty, it returns false.
// *
// * @return true if the ArrayList is empty, false otherwise.
         bool isEmpty();

// * @brief Sets the item at a specific index in the ArrayList.
// *
// * This function updates the item at the specified index in the ArrayList with the provided item.
// * If the index is within bounds, it sets the item and returns true if the operation succeeds.
// * If the index is out of bounds, it returns false.
// *
// * @param index The index at which to set the item.
// * @param item The item to set at the specified index.
// * @return true if the item was successfully set, false if the item was not set or the index is out of bounds.
         bool set( uint16_t index, int16_t item);

// * @brief Removes a range of items from the ArrayList.
// *
// * This function removes a range of items from the ArrayList, from the specified fromIndex (inclusive) to the specified toIndex (exclusive).
// * If fromIndex is greater than toIndex, or if either index is out of bounds, it prints an error message and returns without removing any items.
// * If the indices are valid, it shifts all items from toIndex to the end of the ArrayList to the left to fill the gaps left by the removed items, and decrements the count of items by the number of removed items.
// *
// * @param fromIndex The start index of the range to remove (inclusive).
// * @param toIndex The end index of the range to remove (exclusive).	
         bool removeRange(uint16_t fromIndex, uint16_t toIndex);

// * @brief Ensures that the ArrayList can hold at least the specified number of items without needing to resize.
// *
// * This function checks if the ArrayList's current capacity is less than the specified minimum capacity.
// * If it is, it resizes the ArrayList to the specified minimum capacity.
// * The function uses the memcpy function to copy the items to the new array, so the type T must be trivially copyable.
// *
// * @param minCapacity The minimum capacity that the ArrayList should be able to hold without resizing.	
	     void ensureCapacity(uint16_t minCapacity);

// * @brief Trims the capacity of the ArrayList to its current size.
// *
// * This function reduces the capacity of the ArrayList to its current size, i.e., the number of items it contains.
// * If the ArrayList is dynamic and its capacity is greater than its size, it creates a new array with a capacity equal to the size, copies the items to the new array, and deletes the old array.
// * If the ArrayList is already trimmed or is fixed size, it prints an error message (if debug is true).
         bool trimToSize();	

// * @brief Adds all items from an array to this ArrayList.
// *
// * This function adds all items from the specified array to this ArrayList. If the size type of this ArrayList is DYNAMIC and 
// * the total count of items in the ArrayList and the array exceeds the capacity of this ArrayList, it resizes this ArrayList to accommodate the new items.
// * If the total count of items in the ArrayList and the array does not exceed the capacity of this ArrayList, it adds the items from the array to this ArrayList.
// * If the total count of items in the ArrayList and the array exceeds the capacity of this ArrayList and its size type is STATIC, it prints an error message and does not add the items.
// *
// * @param other The array/List whose items should be added to this ArrayList.
// * @param length The length of the array/List.
// * @return true if the items were added successfully, false otherwise.		 
	    bool addAll(ArrayInt* other);
		
// * @brief Inserts all items from an array at a specific index in this ArrayList.
// *
// * This function inserts all items from the specified array at the specified index in this ArrayList. 
// * If the index is greater than the count of items in this ArrayList, it returns false. 
// * If the ArrayList is full, it resizes the ArrayList if its size type is DYNAMIC, or returns false if its size type is STATIC.
// * If the index is valid and the ArrayList is not full, or has been resized successfully, it shifts all items from the index to the end of the ArrayList one position to the right, inserts the items from the array at the index, and increments the count of items.
// *
// * @param index The index at which to insert the items.
// * @param other The array whose items should be inserted.
// * @param length The length of the array/List.
// * @return true if the items were inserted successfully, false otherwise.
        bool insertAll(uint16_t index, ArrayInt* other);

// * @brief Converts the ArrayList to an array.
// *
// * This function copies the items from the ArrayList into the specified output array.
// * The output array must be large enough to hold all items in the ArrayList.
// * The function uses the memcpy function to copy the items, so the type T must be trivially copyable.
// *
// * @param outputArray The array into which to copy the items.
// * @return The output array.		
		bool toArray(ArrayInt* outputArray);
		
		bool subtoArray(ArrayInt* outputArray, uint16_t fromIndex, uint16_t toIndex);
		 
// * @brief Sets the size type of the ArrayList.
// *
// * This function sets the size type of the ArrayList. (DYNAMIC, DYNAMIC2, FIXED)
// * 
// * @param type The size type to set.		 
        void setSizeType(byte typeSize);

// * @brief Gets the size type of the ArrayList.
// *
// * This function gets the size type of the ArrayList. (DYNAMIC, DYNAMIC2, FIXED)
// * 
// * @return The size type of the ArrayList.
        byte getSizeType();
		

//ArrayType		 
	 #define /*Byte LIST_FIXED;*/ B4R_FIXED                             		 0
//ArrayType	 
     #define /*Byte LIST_DYNAMIC;*/ B4R_DYNAMIC2                                 1  		  
    };


	
   //~shortname:ArrayListUInt
   class B4RArrayListUInt
    {
      private:
         ArrayList<uint16_t> AListUI;
      public:
// * @brief Constructs a new ArrayList.
// *
// * This constructor creates a new ArrayList with the specified size type, initial size.
// * The size type determines whether the size of the ArrayList is static or dynamic. The initial size specifies
// * the initial capacity of the ArrayList. 
// *
// * @param type The size type of the ArrayList. This should be either DYNAMIC or STATIC.
// * @param initialSize The initial capacity of the ArrayList.	  
         void Initialize( byte typeSize, uint16_t initialSize);

// * @brief Adds an item to the ArrayList.
// *
// * This function adds the specified item to the ArrayList. If the size type of the ArrayList is DYNAMIC and the ArrayList is full, 
// * it resizes the ArrayList to accommodate the new item. If the ArrayList is not full, it adds the item to the ArrayList.
// * If the ArrayList is full and its size type is STATIC, it does not add the item.
// * @param item The item to add to the ArrayList.
         bool add( uint16_t item);
		 
// * @brief Inserts an item at a specific index in the ArrayList.
// *
// * This function inserts the specified item at the specified index in the ArrayList. If the index is greater than the count of items in the ArrayList, 
// * it returns false. If the ArrayList is full, it resizes the ArrayList if its size type is DYNAMIC, or returns false if its size type is STATIC.
// * If the index is valid and the ArrayList is not full, or has been resized successfully, it shifts all items from the index to the end of the ArrayList one position to the right, inserts the item at the index, and increments the count of items.
// *
// * @param index The index at which to insert the item.
// * @param item The item to insert.
// * @return true if the item was inserted successfully, false otherwise.
         bool insert(uint16_t index, uint16_t item);

// * @brief Removes an item from the ArrayList.
// *
// * This function removes the specified item from the ArrayList. If the item is not found in the ArrayList, it prints an error message and returns false.
// * If the item is found in the ArrayList, it removes the item from the ArrayList and returns true.
// *
// * @param item The item to remove from the ArrayList.
// * @return true if the item was removed successfully, false otherwise.
         bool removeItem(uint16_t item);

// * @brief Removes an item at a specific index from the ArrayList.
// *
// * This function removes the item at the specified index from the ArrayList. If the index is less than the count of items in the ArrayList, 
// * it shifts all items from the index + 1 to the end of the ArrayList one position to the left, and decrements the count of items.
// *
// * @param index The index of the item to remove.
         bool remove(uint16_t index);

// * @brief Clears all items from the ArrayList.
// *
// * This function clears all items from the ArrayList and sets the count of items to 0.
         void clear();

// * @brief Retrieves the item at a specific index in the ArrayList.
// *
// * This function retrieves the item at the specified index in the ArrayList. If the index is less than the count of items in the ArrayList, 
// * it returns the item at the index. If the index is out of bounds, it returns a default-constructed instance.
// *
// * @param index The index of the item to retrieve.
// * @return The item at the specified index, or a default-constructed instance if the index is out of bounds.
         uint16_t get(uint16_t index);

// * @brief Retrieves the item at a specific index in the ArrayList as a String.
// *
// * This function retrieves the item at the specified index in the ArrayList and converts it to a String. If the index is less than the count of items in the ArrayList,
// * it returns the item at the index as a String. If the index is out of bounds, it returns a default-constructed instance of type T as a String.
// *
// * @param index The index of the item to retrieve.
// * @return The item at the specified index as a String, or a default-constructed instance of type T as a String if the index is out of bounds.
		B4RString* getAsString(uint16_t index);

// * @brief Checks if the ArrayList contains an item.
// *
// * This function checks if the ArrayList contains the specified item. If the item is found in the ArrayList, it returns true.
// * If the item is not found in the ArrayList, it returns false.
// *
// * @param item The item to check for.
// * @return true if the ArrayList contains the item, false otherwise.
         bool contains(uint16_t item);
		 
// * @brief Finds the index of the first occurrence of the specified item in the ArrayList.
// *
// * This function returns the index of the first occurrence of the specified item in the ArrayList, or -1 if the ArrayList does not contain the item.
// * It iterates over the ArrayList from the beginning to the end, comparing each item with the specified item using the == operator.
// * If it finds a match, it returns the index of the match. If it does not find a match, it prints an error message (if debug is true) and returns -1.
// *
// * @param item The item to find in the ArrayList.
// * @return The index of the first occurrence of the item in the ArrayList, or -1 if the ArrayList does not contain the item.
         int16_t indexOf(uint16_t item);

// * @brief Retrieves the capacity of the ArrayList.
// *
// * This function returns the current capacity of the ArrayList, which is the maximum number of items it can hold without resizing.
// *
// * @return The capacity of the ArrayList.
         uint16_t capacity();

// * @brief Retrieves the count of items in the ArrayList.
// *
// * This function returns the current count of items in the ArrayList.
// *
// * @return The count of items in the ArrayList.
         uint16_t size();

// * @brief Checks if the ArrayList is empty.
// *
// * This function checks if the ArrayList is empty. If the ArrayList is empty, it returns true. If the ArrayList is not empty, it returns false.
// *
// * @return true if the ArrayList is empty, false otherwise.
         bool isEmpty();

// * @brief Sets the item at a specific index in the ArrayList.
// *
// * This function updates the item at the specified index in the ArrayList with the provided item.
// * If the index is within bounds, it sets the item and returns true if the operation succeeds.
// * If the index is out of bounds, it returns false.
// *
// * @param index The index at which to set the item.
// * @param item The item to set at the specified index.
// * @return true if the item was successfully set, false if the item was not set or the index is out of bounds.
         bool set( uint16_t index, uint16_t item);

// * @brief Removes a range of items from the ArrayList.
// *
// * This function removes a range of items from the ArrayList, from the specified fromIndex (inclusive) to the specified toIndex (exclusive).
// * If fromIndex is greater than toIndex, or if either index is out of bounds, it prints an error message and returns without removing any items.
// * If the indices are valid, it shifts all items from toIndex to the end of the ArrayList to the left to fill the gaps left by the removed items, and decrements the count of items by the number of removed items.
// *
// * @param fromIndex The start index of the range to remove (inclusive).
// * @param toIndex The end index of the range to remove (exclusive).	
         bool removeRange(uint16_t fromIndex, uint16_t toIndex);

// * @brief Ensures that the ArrayList can hold at least the specified number of items without needing to resize.
// *
// * This function checks if the ArrayList's current capacity is less than the specified minimum capacity.
// * If it is, it resizes the ArrayList to the specified minimum capacity.
// * The function uses the memcpy function to copy the items to the new array, so the type T must be trivially copyable.
// *
// * @param minCapacity The minimum capacity that the ArrayList should be able to hold without resizing.	
	     void ensureCapacity(uint16_t minCapacity);

// * @brief Trims the capacity of the ArrayList to its current size.
// *
// * This function reduces the capacity of the ArrayList to its current size, i.e., the number of items it contains.
// * If the ArrayList is dynamic and its capacity is greater than its size, it creates a new array with a capacity equal to the size, copies the items to the new array, and deletes the old array.
// * If the ArrayList is already trimmed or is fixed size, it prints an error message (if debug is true).
         bool trimToSize();	

// * @brief Adds all items from an array to this ArrayList.
// *
// * This function adds all items from the specified array to this ArrayList. If the size type of this ArrayList is DYNAMIC and 
// * the total count of items in the ArrayList and the array exceeds the capacity of this ArrayList, it resizes this ArrayList to accommodate the new items.
// * If the total count of items in the ArrayList and the array does not exceed the capacity of this ArrayList, it adds the items from the array to this ArrayList.
// * If the total count of items in the ArrayList and the array exceeds the capacity of this ArrayList and its size type is STATIC, it prints an error message and does not add the items.
// *
// * @param other The array/List whose items should be added to this ArrayList.
// * @param length The length of the array/List.
// * @return true if the items were added successfully, false otherwise.		 
	    bool addAll(ArrayUInt* other);
		
// * @brief Inserts all items from an array at a specific index in this ArrayList.
// *
// * This function inserts all items from the specified array at the specified index in this ArrayList. 
// * If the index is greater than the count of items in this ArrayList, it returns false. 
// * If the ArrayList is full, it resizes the ArrayList if its size type is DYNAMIC, or returns false if its size type is STATIC.
// * If the index is valid and the ArrayList is not full, or has been resized successfully, it shifts all items from the index to the end of the ArrayList one position to the right, inserts the items from the array at the index, and increments the count of items.
// *
// * @param index The index at which to insert the items.
// * @param other The array whose items should be inserted.
// * @param length The length of the array/List.
// * @return true if the items were inserted successfully, false otherwise.
        bool insertAll(uint16_t index, ArrayUInt* other);

// * @brief Converts the ArrayList to an array.
// *
// * This function copies the items from the ArrayList into the specified output array.
// * The output array must be large enough to hold all items in the ArrayList.
// * The function uses the memcpy function to copy the items, so the type T must be trivially copyable.
// *
// * @param outputArray The array into which to copy the items.
// * @return The output array.		
		bool toArray(ArrayUInt* outputArray);
		
		bool subtoArray(ArrayUInt* outputArray, uint16_t fromIndex, uint16_t toIndex);
		 
// * @brief Sets the size type of the ArrayList.
// *
// * This function sets the size type of the ArrayList. (DYNAMIC, DYNAMIC2, FIXED)
// * 
// * @param type The size type to set.		 
        void setSizeType(byte typeSize);

// * @brief Gets the size type of the ArrayList.
// *
// * This function gets the size type of the ArrayList. (DYNAMIC, DYNAMIC2, FIXED)
// * 
// * @return The size type of the ArrayList.
        byte getSizeType();
		 
//ArrayType		 
	 #define /*Byte LIST_FIXED;*/ B4R_FIXED                             		 0
//ArrayType	 
     #define /*Byte LIST_DYNAMIC;*/ B4R_DYNAMIC2                                 1  		 
    };
	
	
	
   //~shortname:ArrayListLong
   class B4RArrayListLong
    {
      private:
         ArrayList<int32_t> AListL;
      public:
// * @brief Constructs a new ArrayList.
// *
// * This constructor creates a new ArrayList with the specified size type, initial size.
// * The size type determines whether the size of the ArrayList is static or dynamic. The initial size specifies
// * the initial capacity of the ArrayList. 
// *
// * @param type The size type of the ArrayList. This should be either DYNAMIC or STATIC.
// * @param initialSize The initial capacity of the ArrayList.	  
         void Initialize( byte typeSize, uint16_t initialSize);

// * @brief Adds an item to the ArrayList.
// *
// * This function adds the specified item to the ArrayList. If the size type of the ArrayList is DYNAMIC and the ArrayList is full, 
// * it resizes the ArrayList to accommodate the new item. If the ArrayList is not full, it adds the item to the ArrayList.
// * If the ArrayList is full and its size type is STATIC, it does not add the item.
// * @param item The item to add to the ArrayList.
         bool add( int32_t item);
		 
// * @brief Inserts an item at a specific index in the ArrayList.
// *
// * This function inserts the specified item at the specified index in the ArrayList. If the index is greater than the count of items in the ArrayList, 
// * it returns false. If the ArrayList is full, it resizes the ArrayList if its size type is DYNAMIC, or returns false if its size type is STATIC.
// * If the index is valid and the ArrayList is not full, or has been resized successfully, it shifts all items from the index to the end of the ArrayList one position to the right, inserts the item at the index, and increments the count of items.
// *
// * @param index The index at which to insert the item.
// * @param item The item to insert.
// * @return true if the item was inserted successfully, false otherwise.
         bool insert(uint16_t index, int32_t item);

// * @brief Removes an item from the ArrayList.
// *
// * This function removes the specified item from the ArrayList. If the item is not found in the ArrayList, it prints an error message and returns false.
// * If the item is found in the ArrayList, it removes the item from the ArrayList and returns true.
// *
// * @param item The item to remove from the ArrayList.
// * @return true if the item was removed successfully, false otherwise.
         bool removeItem(int32_t item);

// * @brief Removes an item at a specific index from the ArrayList.
// *
// * This function removes the item at the specified index from the ArrayList. If the index is less than the count of items in the ArrayList, 
// * it shifts all items from the index + 1 to the end of the ArrayList one position to the left, and decrements the count of items.
// *
// * @param index The index of the item to remove.
         bool remove(uint16_t index);

// * @brief Clears all items from the ArrayList.
// *
// * This function clears all items from the ArrayList and sets the count of items to 0.
         void clear();

// * @brief Retrieves the item at a specific index in the ArrayList.
// *
// * This function retrieves the item at the specified index in the ArrayList. If the index is less than the count of items in the ArrayList, 
// * it returns the item at the index. If the index is out of bounds, it returns a default-constructed instance.
// *
// * @param index The index of the item to retrieve.
// * @return The item at the specified index, or a default-constructed instance if the index is out of bounds.
         int32_t get(uint16_t index);

// * @brief Retrieves the item at a specific index in the ArrayList as a String.
// *
// * This function retrieves the item at the specified index in the ArrayList and converts it to a String. If the index is less than the count of items in the ArrayList,
// * it returns the item at the index as a String. If the index is out of bounds, it returns a default-constructed instance of type T as a String.
// *
// * @param index The index of the item to retrieve.
// * @return The item at the specified index as a String, or a default-constructed instance of type T as a String if the index is out of bounds.
		B4RString* getAsString(uint16_t index);

// * @brief Checks if the ArrayList contains an item.
// *
// * This function checks if the ArrayList contains the specified item. If the item is found in the ArrayList, it returns true.
// * If the item is not found in the ArrayList, it returns false.
// *
// * @param item The item to check for.
// * @return true if the ArrayList contains the item, false otherwise.
         bool contains(int32_t item);
		 
// * @brief Finds the index of the first occurrence of the specified item in the ArrayList.
// *
// * This function returns the index of the first occurrence of the specified item in the ArrayList, or -1 if the ArrayList does not contain the item.
// * It iterates over the ArrayList from the beginning to the end, comparing each item with the specified item using the == operator.
// * If it finds a match, it returns the index of the match. If it does not find a match, it prints an error message (if debug is true) and returns -1.
// *
// * @param item The item to find in the ArrayList.
// * @return The index of the first occurrence of the item in the ArrayList, or -1 if the ArrayList does not contain the item.
         int16_t indexOf(int32_t item);

// * @brief Retrieves the capacity of the ArrayList.
// *
// * This function returns the current capacity of the ArrayList, which is the maximum number of items it can hold without resizing.
// *
// * @return The capacity of the ArrayList.
         uint16_t capacity();

// * @brief Retrieves the count of items in the ArrayList.
// *
// * This function returns the current count of items in the ArrayList.
// *
// * @return The count of items in the ArrayList.
         uint16_t size();

// * @brief Checks if the ArrayList is empty.
// *
// * This function checks if the ArrayList is empty. If the ArrayList is empty, it returns true. If the ArrayList is not empty, it returns false.
// *
// * @return true if the ArrayList is empty, false otherwise.
         bool isEmpty();

// * @brief Sets the item at a specific index in the ArrayList.
// *
// * This function updates the item at the specified index in the ArrayList with the provided item.
// * If the index is within bounds, it sets the item and returns true if the operation succeeds.
// * If the index is out of bounds, it returns false.
// *
// * @param index The index at which to set the item.
// * @param item The item to set at the specified index.
// * @return true if the item was successfully set, false if the item was not set or the index is out of bounds.
         bool set( uint16_t index, int32_t item);

// * @brief Removes a range of items from the ArrayList.
// *
// * This function removes a range of items from the ArrayList, from the specified fromIndex (inclusive) to the specified toIndex (exclusive).
// * If fromIndex is greater than toIndex, or if either index is out of bounds, it prints an error message and returns without removing any items.
// * If the indices are valid, it shifts all items from toIndex to the end of the ArrayList to the left to fill the gaps left by the removed items, and decrements the count of items by the number of removed items.
// *
// * @param fromIndex The start index of the range to remove (inclusive).
// * @param toIndex The end index of the range to remove (exclusive).	
         bool removeRange(uint16_t fromIndex, uint16_t toIndex);

// * @brief Ensures that the ArrayList can hold at least the specified number of items without needing to resize.
// *
// * This function checks if the ArrayList's current capacity is less than the specified minimum capacity.
// * If it is, it resizes the ArrayList to the specified minimum capacity.
// * The function uses the memcpy function to copy the items to the new array, so the type T must be trivially copyable.
// *
// * @param minCapacity The minimum capacity that the ArrayList should be able to hold without resizing.	
	     void ensureCapacity(uint16_t minCapacity);

// * @brief Trims the capacity of the ArrayList to its current size.
// *
// * This function reduces the capacity of the ArrayList to its current size, i.e., the number of items it contains.
// * If the ArrayList is dynamic and its capacity is greater than its size, it creates a new array with a capacity equal to the size, copies the items to the new array, and deletes the old array.
// * If the ArrayList is already trimmed or is fixed size, it prints an error message (if debug is true).
         bool trimToSize();	

// * @brief Adds all items from an array to this ArrayList.
// *
// * This function adds all items from the specified array to this ArrayList. If the size type of this ArrayList is DYNAMIC and 
// * the total count of items in the ArrayList and the array exceeds the capacity of this ArrayList, it resizes this ArrayList to accommodate the new items.
// * If the total count of items in the ArrayList and the array does not exceed the capacity of this ArrayList, it adds the items from the array to this ArrayList.
// * If the total count of items in the ArrayList and the array exceeds the capacity of this ArrayList and its size type is STATIC, it prints an error message and does not add the items.
// *
// * @param other The array/List whose items should be added to this ArrayList.
// * @param length The length of the array/List.
// * @return true if the items were added successfully, false otherwise.		 
	    bool addAll(ArrayLong* other);
		
// * @brief Inserts all items from an array at a specific index in this ArrayList.
// *
// * This function inserts all items from the specified array at the specified index in this ArrayList. 
// * If the index is greater than the count of items in this ArrayList, it returns false. 
// * If the ArrayList is full, it resizes the ArrayList if its size type is DYNAMIC, or returns false if its size type is STATIC.
// * If the index is valid and the ArrayList is not full, or has been resized successfully, it shifts all items from the index to the end of the ArrayList one position to the right, inserts the items from the array at the index, and increments the count of items.
// *
// * @param index The index at which to insert the items.
// * @param other The array whose items should be inserted.
// * @param length The length of the array/List.
// * @return true if the items were inserted successfully, false otherwise.
        bool insertAll(uint16_t index, ArrayLong* other);

// * @brief Converts the ArrayList to an array.
// *
// * This function copies the items from the ArrayList into the specified output array.
// * The output array must be large enough to hold all items in the ArrayList.
// * The function uses the memcpy function to copy the items, so the type T must be trivially copyable.
// *
// * @param outputArray The array into which to copy the items.
// * @return The output array.		
		bool toArray(ArrayLong* outputArray);
		
		bool subtoArray(ArrayLong* outputArray, uint16_t fromIndex, uint16_t toIndex);
		 
// * @brief Sets the size type of the ArrayList.
// *
// * This function sets the size type of the ArrayList. (DYNAMIC, DYNAMIC2, FIXED)
// * 
// * @param type The size type to set.		 
        void setSizeType(byte typeSize);

// * @brief Gets the size type of the ArrayList.
// *
// * This function gets the size type of the ArrayList. (DYNAMIC, DYNAMIC2, FIXED)
// * 
// * @return The size type of the ArrayList.
        byte getSizeType();

//ArrayType		 
	 #define /*Byte LIST_FIXED;*/ B4R_FIXED                             		 0
//ArrayType	 
     #define /*Byte LIST_DYNAMIC;*/ B4R_DYNAMIC2                                 1  		  
    };
	

	
   //~shortname:ArrayListULong
   class B4RArrayListULong
    {
      private:
         ArrayList<uint32_t> AListUL;
      public:
// * @brief Constructs a new ArrayList.
// *
// * This constructor creates a new ArrayList with the specified size type, initial size.
// * The size type determines whether the size of the ArrayList is static or dynamic. The initial size specifies
// * the initial capacity of the ArrayList. 
// *
// * @param type The size type of the ArrayList. This should be either DYNAMIC or STATIC.
// * @param initialSize The initial capacity of the ArrayList.	  
         void Initialize( byte typeSize, uint16_t initialSize);

// * @brief Adds an item to the ArrayList.
// *
// * This function adds the specified item to the ArrayList. If the size type of the ArrayList is DYNAMIC and the ArrayList is full, 
// * it resizes the ArrayList to accommodate the new item. If the ArrayList is not full, it adds the item to the ArrayList.
// * If the ArrayList is full and its size type is STATIC, it does not add the item.
// * @param item The item to add to the ArrayList.
         bool add( uint32_t item);
		 
// * @brief Inserts an item at a specific index in the ArrayList.
// *
// * This function inserts the specified item at the specified index in the ArrayList. If the index is greater than the count of items in the ArrayList, 
// * it returns false. If the ArrayList is full, it resizes the ArrayList if its size type is DYNAMIC, or returns false if its size type is STATIC.
// * If the index is valid and the ArrayList is not full, or has been resized successfully, it shifts all items from the index to the end of the ArrayList one position to the right, inserts the item at the index, and increments the count of items.
// *
// * @param index The index at which to insert the item.
// * @param item The item to insert.
// * @return true if the item was inserted successfully, false otherwise.
         bool insert(uint16_t index, uint32_t item);

// * @brief Removes an item from the ArrayList.
// *
// * This function removes the specified item from the ArrayList. If the item is not found in the ArrayList, it prints an error message and returns false.
// * If the item is found in the ArrayList, it removes the item from the ArrayList and returns true.
// *
// * @param item The item to remove from the ArrayList.
// * @return true if the item was removed successfully, false otherwise.
         bool removeItem(uint32_t item);

// * @brief Removes an item at a specific index from the ArrayList.
// *
// * This function removes the item at the specified index from the ArrayList. If the index is less than the count of items in the ArrayList, 
// * it shifts all items from the index + 1 to the end of the ArrayList one position to the left, and decrements the count of items.
// *
// * @param index The index of the item to remove.
         bool remove(uint16_t index);

// * @brief Clears all items from the ArrayList.
// *
// * This function clears all items from the ArrayList and sets the count of items to 0.
         void clear();

// * @brief Retrieves the item at a specific index in the ArrayList.
// *
// * This function retrieves the item at the specified index in the ArrayList. If the index is less than the count of items in the ArrayList, 
// * it returns the item at the index. If the index is out of bounds, it returns a default-constructed instance.
// *
// * @param index The index of the item to retrieve.
// * @return The item at the specified index, or a default-constructed instance if the index is out of bounds.
         uint32_t get(uint16_t index);

// * @brief Retrieves the item at a specific index in the ArrayList as a String.
// *
// * This function retrieves the item at the specified index in the ArrayList and converts it to a String. If the index is less than the count of items in the ArrayList,
// * it returns the item at the index as a String. If the index is out of bounds, it returns a default-constructed instance of type T as a String.
// *
// * @param index The index of the item to retrieve.
// * @return The item at the specified index as a String, or a default-constructed instance of type T as a String if the index is out of bounds.
		B4RString* getAsString(uint16_t index);

// * @brief Checks if the ArrayList contains an item.
// *
// * This function checks if the ArrayList contains the specified item. If the item is found in the ArrayList, it returns true.
// * If the item is not found in the ArrayList, it returns false.
// *
// * @param item The item to check for.
// * @return true if the ArrayList contains the item, false otherwise.
         bool contains(uint32_t item);
		 
// * @brief Finds the index of the first occurrence of the specified item in the ArrayList.
// *
// * This function returns the index of the first occurrence of the specified item in the ArrayList, or -1 if the ArrayList does not contain the item.
// * It iterates over the ArrayList from the beginning to the end, comparing each item with the specified item using the == operator.
// * If it finds a match, it returns the index of the match. If it does not find a match, it prints an error message (if debug is true) and returns -1.
// *
// * @param item The item to find in the ArrayList.
// * @return The index of the first occurrence of the item in the ArrayList, or -1 if the ArrayList does not contain the item.
         int16_t indexOf(uint32_t item);

// * @brief Retrieves the capacity of the ArrayList.
// *
// * This function returns the current capacity of the ArrayList, which is the maximum number of items it can hold without resizing.
// *
// * @return The capacity of the ArrayList.
         uint16_t capacity();

// * @brief Retrieves the count of items in the ArrayList.
// *
// * This function returns the current count of items in the ArrayList.
// *
// * @return The count of items in the ArrayList.
         uint16_t size();

// * @brief Checks if the ArrayList is empty.
// *
// * This function checks if the ArrayList is empty. If the ArrayList is empty, it returns true. If the ArrayList is not empty, it returns false.
// *
// * @return true if the ArrayList is empty, false otherwise.
         bool isEmpty();

// * @brief Sets the item at a specific index in the ArrayList.
// *
// * This function updates the item at the specified index in the ArrayList with the provided item.
// * If the index is within bounds, it sets the item and returns true if the operation succeeds.
// * If the index is out of bounds, it returns false.
// *
// * @param index The index at which to set the item.
// * @param item The item to set at the specified index.
// * @return true if the item was successfully set, false if the item was not set or the index is out of bounds.
         bool set( uint16_t index, uint32_t item);

// * @brief Removes a range of items from the ArrayList.
// *
// * This function removes a range of items from the ArrayList, from the specified fromIndex (inclusive) to the specified toIndex (exclusive).
// * If fromIndex is greater than toIndex, or if either index is out of bounds, it prints an error message and returns without removing any items.
// * If the indices are valid, it shifts all items from toIndex to the end of the ArrayList to the left to fill the gaps left by the removed items, and decrements the count of items by the number of removed items.
// *
// * @param fromIndex The start index of the range to remove (inclusive).
// * @param toIndex The end index of the range to remove (exclusive).	
         bool removeRange(uint16_t fromIndex, uint16_t toIndex);

// * @brief Ensures that the ArrayList can hold at least the specified number of items without needing to resize.
// *
// * This function checks if the ArrayList's current capacity is less than the specified minimum capacity.
// * If it is, it resizes the ArrayList to the specified minimum capacity.
// * The function uses the memcpy function to copy the items to the new array, so the type T must be trivially copyable.
// *
// * @param minCapacity The minimum capacity that the ArrayList should be able to hold without resizing.	
	     void ensureCapacity(uint16_t minCapacity);

// * @brief Trims the capacity of the ArrayList to its current size.
// *
// * This function reduces the capacity of the ArrayList to its current size, i.e., the number of items it contains.
// * If the ArrayList is dynamic and its capacity is greater than its size, it creates a new array with a capacity equal to the size, copies the items to the new array, and deletes the old array.
// * If the ArrayList is already trimmed or is fixed size, it prints an error message (if debug is true).
         bool trimToSize();	

// * @brief Adds all items from an array to this ArrayList.
// *
// * This function adds all items from the specified array to this ArrayList. If the size type of this ArrayList is DYNAMIC and 
// * the total count of items in the ArrayList and the array exceeds the capacity of this ArrayList, it resizes this ArrayList to accommodate the new items.
// * If the total count of items in the ArrayList and the array does not exceed the capacity of this ArrayList, it adds the items from the array to this ArrayList.
// * If the total count of items in the ArrayList and the array exceeds the capacity of this ArrayList and its size type is STATIC, it prints an error message and does not add the items.
// *
// * @param other The array/List whose items should be added to this ArrayList.
// * @param length The length of the array/List.
// * @return true if the items were added successfully, false otherwise.		 
	    bool addAll(ArrayULong* other);
		
// * @brief Inserts all items from an array at a specific index in this ArrayList.
// *
// * This function inserts all items from the specified array at the specified index in this ArrayList. 
// * If the index is greater than the count of items in this ArrayList, it returns false. 
// * If the ArrayList is full, it resizes the ArrayList if its size type is DYNAMIC, or returns false if its size type is STATIC.
// * If the index is valid and the ArrayList is not full, or has been resized successfully, it shifts all items from the index to the end of the ArrayList one position to the right, inserts the items from the array at the index, and increments the count of items.
// *
// * @param index The index at which to insert the items.
// * @param other The array whose items should be inserted.
// * @param length The length of the array/List.
// * @return true if the items were inserted successfully, false otherwise.
        bool insertAll(uint16_t index, ArrayULong* other);

// * @brief Converts the ArrayList to an array.
// *
// * This function copies the items from the ArrayList into the specified output array.
// * The output array must be large enough to hold all items in the ArrayList.
// * The function uses the memcpy function to copy the items, so the type T must be trivially copyable.
// *
// * @param outputArray The array into which to copy the items.
// * @return The output array.		
		bool toArray(ArrayULong* outputArray);
		
		bool subtoArray(ArrayULong* outputArray, uint16_t fromIndex, uint16_t toIndex);
		 
// * @brief Sets the size type of the ArrayList.
// *
// * This function sets the size type of the ArrayList. (DYNAMIC, DYNAMIC2, FIXED)
// * 
// * @param type The size type to set.		 
        void setSizeType(byte typeSize);

// * @brief Gets the size type of the ArrayList.
// *
// * This function gets the size type of the ArrayList. (DYNAMIC, DYNAMIC2, FIXED)
// * 
// * @return The size type of the ArrayList.
        byte getSizeType();

//ArrayType		 
	 #define /*Byte LIST_FIXED;*/ B4R_FIXED                             		 0
//ArrayType	 
     #define /*Byte LIST_DYNAMIC;*/ B4R_DYNAMIC2                                 1  		 
    };



   //~shortname:ArrayListDouble
   class B4RArrayListDouble
    {
      private:
         ArrayList<float> AListDo;
      public:
// * @brief Constructs a new ArrayList.
// *
// * This constructor creates a new ArrayList with the specified size type, initial size.
// * The size type determines whether the size of the ArrayList is static or dynamic. The initial size specifies
// * the initial capacity of the ArrayList. 
// *
// * @param type The size type of the ArrayList. This should be either DYNAMIC or STATIC.
// * @param initialSize The initial capacity of the ArrayList.	  
         void Initialize( byte typeSize, uint16_t initialSize);

// * @brief Adds an item to the ArrayList.
// *
// * This function adds the specified item to the ArrayList. If the size type of the ArrayList is DYNAMIC and the ArrayList is full, 
// * it resizes the ArrayList to accommodate the new item. If the ArrayList is not full, it adds the item to the ArrayList.
// * If the ArrayList is full and its size type is STATIC, it does not add the item.
// * @param item The item to add to the ArrayList.
         bool add( float item);
		 
// * @brief Inserts an item at a specific index in the ArrayList.
// *
// * This function inserts the specified item at the specified index in the ArrayList. If the index is greater than the count of items in the ArrayList, 
// * it returns false. If the ArrayList is full, it resizes the ArrayList if its size type is DYNAMIC, or returns false if its size type is STATIC.
// * If the index is valid and the ArrayList is not full, or has been resized successfully, it shifts all items from the index to the end of the ArrayList one position to the right, inserts the item at the index, and increments the count of items.
// *
// * @param index The index at which to insert the item.
// * @param item The item to insert.
// * @return true if the item was inserted successfully, false otherwise.
         bool insert(uint16_t index, float item);

// * @brief Removes an item from the ArrayList.
// *
// * This function removes the specified item from the ArrayList. If the item is not found in the ArrayList, it prints an error message and returns false.
// * If the item is found in the ArrayList, it removes the item from the ArrayList and returns true.
// *
// * @param item The item to remove from the ArrayList.
// * @return true if the item was removed successfully, false otherwise.
         bool removeItem(float item);

// * @brief Removes an item at a specific index from the ArrayList.
// *
// * This function removes the item at the specified index from the ArrayList. If the index is less than the count of items in the ArrayList, 
// * it shifts all items from the index + 1 to the end of the ArrayList one position to the left, and decrements the count of items.
// *
// * @param index The index of the item to remove.
         bool remove(uint16_t index);

// * @brief Clears all items from the ArrayList.
// *
// * This function clears all items from the ArrayList and sets the count of items to 0.
         void clear();

// * @brief Retrieves the item at a specific index in the ArrayList.
// *
// * This function retrieves the item at the specified index in the ArrayList. If the index is less than the count of items in the ArrayList, 
// * it returns the item at the index. If the index is out of bounds, it returns a default-constructed instance.
// *
// * @param index The index of the item to retrieve.
// * @return The item at the specified index, or a default-constructed instance if the index is out of bounds.
         float get(uint16_t index);

// * @brief Retrieves the item at a specific index in the ArrayList as a String.
// *
// * This function retrieves the item at the specified index in the ArrayList and converts it to a String. If the index is less than the count of items in the ArrayList,
// * it returns the item at the index as a String. If the index is out of bounds, it returns a default-constructed instance of type T as a String.
// *
// * @param index The index of the item to retrieve.
// * @return The item at the specified index as a String, or a default-constructed instance of type T as a String if the index is out of bounds.
		B4RString* getAsString(uint16_t index);

// * @brief Checks if the ArrayList contains an item.
// *
// * This function checks if the ArrayList contains the specified item. If the item is found in the ArrayList, it returns true.
// * If the item is not found in the ArrayList, it returns false.
// *
// * @param item The item to check for.
// * @return true if the ArrayList contains the item, false otherwise.
         bool contains(float item);
		 
// * @brief Finds the index of the first occurrence of the specified item in the ArrayList.
// *
// * This function returns the index of the first occurrence of the specified item in the ArrayList, or -1 if the ArrayList does not contain the item.
// * It iterates over the ArrayList from the beginning to the end, comparing each item with the specified item using the == operator.
// * If it finds a match, it returns the index of the match. If it does not find a match, it prints an error message (if debug is true) and returns -1.
// *
// * @param item The item to find in the ArrayList.
// * @return The index of the first occurrence of the item in the ArrayList, or -1 if the ArrayList does not contain the item.
         int16_t indexOf(float item);

// * @brief Retrieves the capacity of the ArrayList.
// *
// * This function returns the current capacity of the ArrayList, which is the maximum number of items it can hold without resizing.
// *
// * @return The capacity of the ArrayList.
         uint16_t capacity();

// * @brief Retrieves the count of items in the ArrayList.
// *
// * This function returns the current count of items in the ArrayList.
// *
// * @return The count of items in the ArrayList.
         uint16_t size();

// * @brief Checks if the ArrayList is empty.
// *
// * This function checks if the ArrayList is empty. If the ArrayList is empty, it returns true. If the ArrayList is not empty, it returns false.
// *
// * @return true if the ArrayList is empty, false otherwise.
         bool isEmpty();

// * @brief Sets the item at a specific index in the ArrayList.
// *
// * This function updates the item at the specified index in the ArrayList with the provided item.
// * If the index is within bounds, it sets the item and returns true if the operation succeeds.
// * If the index is out of bounds, it returns false.
// *
// * @param index The index at which to set the item.
// * @param item The item to set at the specified index.
// * @return true if the item was successfully set, false if the item was not set or the index is out of bounds.
         bool set( uint16_t index, float item);

// * @brief Removes a range of items from the ArrayList.
// *
// * This function removes a range of items from the ArrayList, from the specified fromIndex (inclusive) to the specified toIndex (exclusive).
// * If fromIndex is greater than toIndex, or if either index is out of bounds, it prints an error message and returns without removing any items.
// * If the indices are valid, it shifts all items from toIndex to the end of the ArrayList to the left to fill the gaps left by the removed items, and decrements the count of items by the number of removed items.
// *
// * @param fromIndex The start index of the range to remove (inclusive).
// * @param toIndex The end index of the range to remove (exclusive).	
         bool removeRange(uint16_t fromIndex, uint16_t toIndex);

// * @brief Ensures that the ArrayList can hold at least the specified number of items without needing to resize.
// *
// * This function checks if the ArrayList's current capacity is less than the specified minimum capacity.
// * If it is, it resizes the ArrayList to the specified minimum capacity.
// * The function uses the memcpy function to copy the items to the new array, so the type T must be trivially copyable.
// *
// * @param minCapacity The minimum capacity that the ArrayList should be able to hold without resizing.	
	     void ensureCapacity(uint16_t minCapacity);

// * @brief Trims the capacity of the ArrayList to its current size.
// *
// * This function reduces the capacity of the ArrayList to its current size, i.e., the number of items it contains.
// * If the ArrayList is dynamic and its capacity is greater than its size, it creates a new array with a capacity equal to the size, copies the items to the new array, and deletes the old array.
// * If the ArrayList is already trimmed or is fixed size, it prints an error message (if debug is true).
         bool trimToSize();	

// * @brief Adds all items from an array to this ArrayList.
// *
// * This function adds all items from the specified array to this ArrayList. If the size type of this ArrayList is DYNAMIC and 
// * the total count of items in the ArrayList and the array exceeds the capacity of this ArrayList, it resizes this ArrayList to accommodate the new items.
// * If the total count of items in the ArrayList and the array does not exceed the capacity of this ArrayList, it adds the items from the array to this ArrayList.
// * If the total count of items in the ArrayList and the array exceeds the capacity of this ArrayList and its size type is STATIC, it prints an error message and does not add the items.
// *
// * @param other The array/List whose items should be added to this ArrayList.
// * @param length The length of the array/List.
// * @return true if the items were added successfully, false otherwise.		 
	    bool addAll(ArrayDouble* other);
		
// * @brief Inserts all items from an array at a specific index in this ArrayList.
// *
// * This function inserts all items from the specified array at the specified index in this ArrayList. 
// * If the index is greater than the count of items in this ArrayList, it returns false. 
// * If the ArrayList is full, it resizes the ArrayList if its size type is DYNAMIC, or returns false if its size type is STATIC.
// * If the index is valid and the ArrayList is not full, or has been resized successfully, it shifts all items from the index to the end of the ArrayList one position to the right, inserts the items from the array at the index, and increments the count of items.
// *
// * @param index The index at which to insert the items.
// * @param other The array whose items should be inserted.
// * @param length The length of the array/List.
// * @return true if the items were inserted successfully, false otherwise.
        bool insertAll(uint16_t index, ArrayDouble* other);

// * @brief Converts the ArrayList to an array.
// *
// * This function copies the items from the ArrayList into the specified output array.
// * The output array must be large enough to hold all items in the ArrayList.
// * The function uses the memcpy function to copy the items, so the type T must be trivially copyable.
// *
// * @param outputArray The array into which to copy the items.
// * @return The output array.		
		bool toArray(ArrayDouble* outputArray);
		
		bool subtoArray(ArrayDouble* outputArray, uint16_t fromIndex, uint16_t toIndex);
		 
// * @brief Sets the size type of the ArrayList.
// *
// * This function sets the size type of the ArrayList. (DYNAMIC, DYNAMIC2, FIXED)
// * 
// * @param type The size type to set.		 
        void setSizeType(byte typeSize);

// * @brief Gets the size type of the ArrayList.
// *
// * This function gets the size type of the ArrayList. (DYNAMIC, DYNAMIC2, FIXED)
// * 
// * @return The size type of the ArrayList.
        byte getSizeType();

//ArrayType		 
	 #define /*Byte LIST_FIXED;*/ B4R_FIXED                             		 0
//ArrayType	 
     #define /*Byte LIST_DYNAMIC;*/ B4R_DYNAMIC2                                 1  		 
    };
	
	
   //~shortname:ArrayListString
   class B4RArrayListString
    {
      private:
         ArrayList<String> AListStr;
      public:
// * @brief Constructs a new ArrayList.
// *
// * This constructor creates a new ArrayList with the specified size type, initial size.
// * The size type determines whether the size of the ArrayList is static or dynamic. The initial size specifies
// * the initial capacity of the ArrayList. 
// *
// * @param type The size type of the ArrayList. This should be either DYNAMIC or STATIC.
// * @param initialSize The initial capacity of the ArrayList.	  
         void Initialize( byte typeSize, uint16_t initialSize);

// * @brief Adds an item to the ArrayList.
// *
// * This function adds the specified item to the ArrayList. If the size type of the ArrayList is DYNAMIC and the ArrayList is full, 
// * it resizes the ArrayList to accommodate the new item. If the ArrayList is not full, it adds the item to the ArrayList.
// * If the ArrayList is full and its size type is STATIC, it does not add the item.
// * @param item The item to add to the ArrayList.
         bool add( B4RString* item);
		 
// * @brief Inserts an item at a specific index in the ArrayList.
// *
// * This function inserts the specified item at the specified index in the ArrayList. If the index is greater than the count of items in the ArrayList, 
// * it returns false. If the ArrayList is full, it resizes the ArrayList if its size type is DYNAMIC, or returns false if its size type is STATIC.
// * If the index is valid and the ArrayList is not full, or has been resized successfully, it shifts all items from the index to the end of the ArrayList one position to the right, inserts the item at the index, and increments the count of items.
// *
// * @param index The index at which to insert the item.
// * @param item The item to insert.
// * @return true if the item was inserted successfully, false otherwise.
         bool insert(uint16_t index, B4RString* item);

// * @brief Removes an item from the ArrayList.
// *
// * This function removes the specified item from the ArrayList. If the item is not found in the ArrayList, it prints an error message and returns false.
// * If the item is found in the ArrayList, it removes the item from the ArrayList and returns true.
// *
// * @param item The item to remove from the ArrayList.
// * @return true if the item was removed successfully, false otherwise.
         bool removeItem(B4RString* item);

// * @brief Removes an item at a specific index from the ArrayList.
// *
// * This function removes the item at the specified index from the ArrayList. If the index is less than the count of items in the ArrayList, 
// * it shifts all items from the index + 1 to the end of the ArrayList one position to the left, and decrements the count of items.
// *
// * @param index The index of the item to remove.
         bool remove(uint16_t index);

// * @brief Clears all items from the ArrayList.
// *
// * This function clears all items from the ArrayList and sets the count of items to 0.
         void clear();

// * @brief Retrieves the item at a specific index in the ArrayList.
// *
// * This function retrieves the item at the specified index in the ArrayList. If the index is less than the count of items in the ArrayList, 
// * it returns the item at the index. If the index is out of bounds, it returns a default-constructed instance.
// *
// * @param index The index of the item to retrieve.
// * @return The item at the specified index, or a default-constructed instance if the index is out of bounds.
         B4RString* get(uint16_t index);

// * @brief Checks if the ArrayList contains an item.
// *
// * This function checks if the ArrayList contains the specified item. If the item is found in the ArrayList, it returns true.
// * If the item is not found in the ArrayList, it returns false.
// *
// * @param item The item to check for.
// * @return true if the ArrayList contains the item, false otherwise.
         bool contains(B4RString* item);
		 
// * @brief Finds the index of the first occurrence of the specified item in the ArrayList.
// *
// * This function returns the index of the first occurrence of the specified item in the ArrayList, or -1 if the ArrayList does not contain the item.
// * It iterates over the ArrayList from the beginning to the end, comparing each item with the specified item using the == operator.
// * If it finds a match, it returns the index of the match. If it does not find a match, it prints an error message (if debug is true) and returns -1.
// *
// * @param item The item to find in the ArrayList.
// * @return The index of the first occurrence of the item in the ArrayList, or -1 if the ArrayList does not contain the item.
         int16_t indexOf(B4RString* item);

// * @brief Retrieves the capacity of the ArrayList.
// *
// * This function returns the current capacity of the ArrayList, which is the maximum number of items it can hold without resizing.
// *
// * @return The capacity of the ArrayList.
         uint16_t capacity();

// * @brief Retrieves the count of items in the ArrayList.
// *
// * This function returns the current count of items in the ArrayList.
// *
// * @return The count of items in the ArrayList.
         uint16_t size();

// * @brief Checks if the ArrayList is empty.
// *
// * This function checks if the ArrayList is empty. If the ArrayList is empty, it returns true. If the ArrayList is not empty, it returns false.
// *
// * @return true if the ArrayList is empty, false otherwise.
         bool isEmpty();

// * @brief Sets the item at a specific index in the ArrayList.
// *
// * This function updates the item at the specified index in the ArrayList with the provided item.
// * If the index is within bounds, it sets the item and returns true if the operation succeeds.
// * If the index is out of bounds, it returns false.
// *
// * @param index The index at which to set the item.
// * @param item The item to set at the specified index.
// * @return true if the item was successfully set, false if the item was not set or the index is out of bounds.
         bool set( uint16_t index, B4RString* item);

// * @brief Removes a range of items from the ArrayList.
// *
// * This function removes a range of items from the ArrayList, from the specified fromIndex (inclusive) to the specified toIndex (exclusive).
// * If fromIndex is greater than toIndex, or if either index is out of bounds, it prints an error message and returns without removing any items.
// * If the indices are valid, it shifts all items from toIndex to the end of the ArrayList to the left to fill the gaps left by the removed items, and decrements the count of items by the number of removed items.
// *
// * @param fromIndex The start index of the range to remove (inclusive).
// * @param toIndex The end index of the range to remove (exclusive).	
         bool removeRange(uint16_t fromIndex, uint16_t toIndex);

// * @brief Ensures that the ArrayList can hold at least the specified number of items without needing to resize.
// *
// * This function checks if the ArrayList's current capacity is less than the specified minimum capacity.
// * If it is, it resizes the ArrayList to the specified minimum capacity.
// * The function uses the memcpy function to copy the items to the new array, so the type T must be trivially copyable.
// *
// * @param minCapacity The minimum capacity that the ArrayList should be able to hold without resizing.	
	     void ensureCapacity(uint16_t minCapacity);

// * @brief Trims the capacity of the ArrayList to its current size.
// *
// * This function reduces the capacity of the ArrayList to its current size, i.e., the number of items it contains.
// * If the ArrayList is dynamic and its capacity is greater than its size, it creates a new array with a capacity equal to the size, copies the items to the new array, and deletes the old array.
// * If the ArrayList is already trimmed or is fixed size, it prints an error message (if debug is true).
         bool trimToSize();	
		 
// * @brief add String from item(index2) to String in item(index1).
// *
// * This function dont change ArrayList size.	 
		 void concat(uint16_t index1, uint16_t index2);

// * @brief add B4RString to String in item(index1).
// *
// * This function dont change ArrayList size.	 		 
		 void join(uint16_t index1, B4RString* item);

    void setSizeType(byte typeSize);

    /**
     * @brief Gets the size type of the ArrayList.
     *
     * This function gets the size type of the ArrayList. (DYNAMIC, DYNAMIC2, FIXED)
     * 
     * @return The size type of the ArrayList.
     */
    byte getSizeType();


//ArrayType		 
	 #define /*Byte LIST_FIXED;*/ B4R_FIXED                             		 0
//ArrayType	 
     #define /*Byte LIST_DYNAMIC;*/ B4R_DYNAMIC2                                 1  		 	 
    };
}