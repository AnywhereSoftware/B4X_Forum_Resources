#ifndef ARRAYLIST_H
#define ARRAYLIST_H
/**
 * @author Brayden Anderson
 * @date 01/29/2025
 */
#include <Arduino.h>
//#include "../../TypeTraits/src/TypeTraits.h"

//#define IKnowWhatIAmDoing //Uncomment this line if you know what you are doing; USE THE FUNCTIONS UNCOVERED BY THIS DIRECTIVE AT YOUR OWN RISK!!!
//#define SkinnyArray // Uncomment this line to remove more advanced functions to save memory or define it in your code


/**
  *  @attention If you uncomment SkinnyArray, use the below compiler directives to override functions/bring them back into existence
*/
#ifdef SkinnyArray //If SkinnyArray is defined, remove more advanced functions unless overridden

//#define OverrideCopyConstructor //Uncomment this line to override the copy constructor when in SkinnyArray Mode
//#define OverrideAssignmentOperator //Uncomment this line to override the assignment operator when in SkinnyArray Mode
//#define OverrideSort //Uncomment this line to override the sort function when in SkinnyArray Mode
//#define OverrideAddAll //Uncomment this line to override the addAll function when in SkinnyArray Mode
//#define OverrideInsertAll //Uncomment this line to override the insertAll function when in SkinnyArray Mode
//#define OverrideSpecialtyRemove //Uncomment this line to override the remove function when in SkinnyArray Mode
//#define OverrideUtilityFunctions //Uncomment this line to override the utility functions when in SkinnyArray Mode

#endif
#define AL_RESIZE_SUCCESS 0
#define AL_RESIZE_ERROR 1
#define AL_RESIZE_ERROR2 2
#define AL_FIXED_SIZE_ERROR 3
#define AL_BUBBLESORT_FAILURE 4
#define AL_QUICKSORT_FAILURE 5
#define AL_MERGESORT_FAILURE 6
#define AL_SORT_SUCCESS 7
#define AL_ADD_ERROR 8
#define AL_ELEMENT_NOT_FOUND 9
#define AL_OUT_OF_BOUNDS 10
#define AL_INSERT_ERROR 11
#define AL_REMOVE_ERROR 12
#define AL_MAX_CAPACITY_ERROR 13


template <typename T>
class ArrayList {
public:
    enum SizeType { FIXED, DYNAMIC, DYNAMIC2 }; // Size type


#ifndef SkinnyArray //If SkinnyArray is not defined, define the SortAlgorithm enum
    enum SortAlgorithm { BUBBLE_SORT, QUICK_SORT, MERGE_SORT }; // Sorting algorithms
#endif
    //Constructor and Destructor
    
    /**
     * @brief Constructs a new ArrayList.
     *
     * This constructor creates a new ArrayList with the specified size type, initial size, and debug flag.
     * The size type determines whether the size of the ArrayList is static or dynamic. The initial size specifies
     * the initial capacity of the ArrayList. The debug flag determines whether debug messages should be printed.
     *
     * @param type The size type of the ArrayList. This should be either DYNAMIC or STATIC.
     * @param initialSize The initial capacity of the ArrayList.
     * @param debug A flag indicating whether debug messages should be printed.
    */
	
    ArrayList(SizeType type = DYNAMIC2, size_t initialSize = 8)
                : sizeType(type), arrayCapacity(initialSize), count(0) {
        array = new T[arrayCapacity];
        if (!array) {
            Serial.println("[ArrayList] Memory allocation failed");
        } 
        setInitialSize(initialSize);
    }
	

    #ifndef SkinnyArray //If SkinnyArray is not defined, define the COPY Constructor
     /**
    * @brief COPY Constructor
    */
    ArrayList(const ArrayList<T>& list) {
        this->sizeType = list.sizeType;
        this->arrayCapacity = list.arrayCapacity;
        this->count = list.count;
        this->array = new T[this->arrayCapacity];
        for (size_t i = 0; i < list.count; ++i) {
            this->array[i] = list.array[i];
        }
    }
    #endif

    /**
     * @brief Destroys the ArrayList.
     *
     * This destructor deletes the ArrayList and frees the memory allocated for it.
     * If the debug flag is set, it prints a message indicating that the ArrayList is being deleted.
    */
    ~ArrayList() {
        delete[] array;
    }
	 
	void initsize(size_t initialSize) {
        size_t newCapacity = initialSize;
        T* newArray = new T[newCapacity];
        delete[] array;
        array = newArray;
        size_t tempCapacity = newCapacity;
        int oldCapacity = arrayCapacity;
        arrayCapacity = newCapacity;
        if(tempCapacity != arrayCapacity){
           arrayCapacity = oldCapacity; }
    }

   
   /**
     * @brief Adds an item to the ArrayList.
     *
     * This function adds the specified item to the ArrayList. If the size type of the ArrayList is DYNAMIC and the ArrayList is full,
     * it resizes the ArrayList to accommodate the new item. If the ArrayList is not full, it adds the item to the ArrayList.
     * If the ArrayList is full and its size type is STATIC, it prints an error message and does not add the item.
     * (Only if the debug flag is set to true)
     * @param item The item to add to the ArrayList.
    */
    bool add(T item) {
        if(sizeType == FIXED && count >= arrayCapacity){ //If size type is fixed and the count is greater than or equal to the array capacity, return nothing;
            return false;
        }
        bool resizeNeeded = verifyResizeNeeded(count+1);
        // Serial.println(resizeNeeded);// Debugging
        // Calculate the load factor
        if(resizeNeeded){ //If the load factor is greater than or equal to 0.8, resize the array
            resize();
        }
        
        // Resize the array if the load factor is greater than or equal to 0.8
        //MOVED: Logic has been moved to verifyResizeNeededed and resize PIO: Version 1.0.5 ALM: 1.0.2
        /*
        if (sizeType == DYNAMIC && loadFactor >= 0.8) { //uses original resize function. This function is less reliable but faster
            resize();
        } else if(sizeType == DYNAMIC2 && loadFactor >= 0.8) {// uses new resize2 function that is more reliable but slower
            resize2();
        }
        */
        // Add the item to the array
        if (count < arrayCapacity) { //If the count is less than the array capacity add the element. (Verifies that you arent adding an element out of bounds)
            array[count++] = item;
			return true;
        } 
		return false;
    }


    #ifndef SkinnyArray //If SkinnyArray is not defined, define the AddAll function
 
    /**
     * @brief Adds all items from an array to this ArrayList.
     *
     * This function adds all items from the specified array to this ArrayList. If the size type of this ArrayList is DYNAMIC and 
     * the total count of items in the ArrayList and the array exceeds the capacity of this ArrayList, it resizes this ArrayList to accommodate the new items.
     * If the total count of items in the ArrayList and the array does not exceed the capacity of this ArrayList, it adds the items from the array to this ArrayList.
     * If the total count of items in the ArrayList and the array exceeds the capacity of this ArrayList and its size type is STATIC, it prints an error message and does not add the items.
     *
     * @param other The array/List whose items should be added to this ArrayList.
     * @param length The length of the array/List.
     * @return true if the items were added successfully, false otherwise.
    */
    bool addAll(const T* other, size_t length) {
        bool resizeNeeded = verifyResizeNeeded(count+length);
        if(resizeNeeded){
            resize();
        }
        if (count + length <= arrayCapacity) {
            memcpy(array + count, other, length * sizeof(T));
            count += length;
            return true;
        }
        return false;
    }
    #endif

    /**
     * @brief Inserts an item at a specific index in the ArrayList.
     *
     * This function inserts the specified item at the specified index in the ArrayList. If the index is greater than the count of items in the ArrayList,
     * it prints an error message and returns false. If the ArrayList is full, it resizes the ArrayList if its size type is DYNAMIC, or prints an error message and returns false if its size type is STATIC.
     * If the index is valid and the ArrayList is not full, or has been resized successfully, it shifts all items from the index to the end of the ArrayList one position to the right, inserts the item at the index, and increments the count of items.
     *
     * @param index The index at which to insert the item.
     * @param item The item to insert.
     * @return true if the item was inserted successfully, false otherwise.
    */
    bool insert(size_t index, T item) {
        if (index > count) {
            return false;
        }
        bool resizeNeeded = verifyResizeNeeded(count);
        if(resizeNeeded){
            resize();
        }
        for (size_t i = count; i > index; --i) {
            array[i] = array[i - 1];
        }
        array[index] = item;
        ++count;
        return true;
    }

    /**
     * @brief Overloads the assignment operator to copy the contents of another ArrayList to this ArrayList.
     */
    ArrayList<T>& operator=(const ArrayList<T>& list) {
        if (this == &list) {
            return *this; // Self-assignment check
        }
    
        // Free the current array
        delete[] this->array;
    
        // Allocate new memory
        this->arrayCapacity = list.arrayCapacity;
        this->array = new T[this->arrayCapacity];
    
        // Copy metadata
        this->sizeType = list.sizeType;
        this->initialSize = list.initialSize;
        this->count = list.count;
    
        // Copy elements
        for (int i = 0; i < list.count; i++) {
            this->array[i] = list.array[i];
        }
    
        return *this;
    }



    /**
     * @brief Overloads the [] operator to access items in the ArrayList.
     * 
     */
    T& operator [] (size_t index){
        if(index >= count){
            return T();
        }
        return array[index];
    }

    #ifndef SkinnyArray //If SkinnyArray is not defined, define the the InsertAll Funtions
 
    /**
     * @brief Inserts all items from an array/List at a specific index in this ArrayList.
     *
     * This function inserts all items from the specified array/list at the specified index in this ArrayList. If the index is greater than the count of items in this ArrayList,
     * it prints an error message and returns false. If the ArrayList is full, it resizes the ArrayList if its size type is DYNAMIC, or prints an error message and returns false if its size type is STATIC.
     * If the index is valid and the ArrayList is not full, or has been resized successfully, it shifts all items from the index to the end of the ArrayList one position to the right, inserts the items from the array at the index, and increments the count of items.
     *
     * @param index The index at which to insert the items.
     * @param other The array/List whose items should be inserted.
     * @param length The length of the array/List.
     * @return true if the items were inserted successfully, false otherwise.
    */
    bool insertAll(size_t index, const T* other, size_t length) {
        if (index > count) {
            return false;
        }
        bool resizeNeeded = verifyResizeNeeded(count + length);
        if(resizeNeeded){
            resize();
        }
        
        for (size_t i = count + length - 1; i >= index + length; --i) {
            array[i] = array[i - length];
        }
        memcpy(array + index, other, length * sizeof(T));
        count += length;
        return true;
    }
    #endif

    /**
     * @brief Removes an item from the ArrayList.
     *
     * This function removes the specified item from the ArrayList. If the item is not found in the ArrayList, it prints an error message and returns false.
     * If the item is found in the ArrayList, it removes the item from the ArrayList and returns true.
     *
     * @param item The item to remove from the ArrayList.
     * @return true if the item was removed successfully, false otherwise.
    */
    bool removeItem(T item) {
        int index = indexOf(item);
        if (index >= 0) {
            remove(index);
            return true;
        }else{
            return false;
        }
    }
    
    /**
     * @brief Removes an item at a specific index from the ArrayList.
     *
     * This function removes the item at the specified index from the ArrayList. If the index is less than the count of items in the ArrayList,
     * it shifts all items from the index + 1 to the end of the ArrayList one position to the left, and decrements the count of items.
     *
     * @param index The index of the item to remove.
    */
    bool remove(size_t index) {
        if (index < count) {
            for (size_t i = index; i < count - 1; ++i) {
                array[i] = array[i + 1];
            }
            --count;
			return true;
        }
		return false;
    }

    #ifndef SkinnyArray //If SkinnyArray is not defined, define the SpecialtyRemove function
    /**
     * @brief Removes all items from the ArrayList that satisfy a predicate.
     *
     * This function removes all items from the ArrayList that satisfy the specified predicate. The predicate is a function that takes an item of type T and returns a boolean.
     * If the predicate returns true for an item, that item is removed from the ArrayList. The function shifts all items that do not satisfy the predicate to the left to fill the gaps left by the removed items.
     * The function can use the Predicates library, which can be found at: https://github.com/braydenanderson2014/C-Arduino-Libraries/tree/main/lib
     *
     * @param predicate The predicate to test the items against.
     * @return true if any items were removed, false otherwise.
    */
    bool removeIf(bool (*predicate)(T)) {
        size_t removed = 0;
        for (size_t i = 0; i < count; ++i) {
            if (predicate(array[i])) {
                ++removed;
            } else {
                array[i - removed] = array[i];
            }
        }
        if (removed > 0) {
            count -= removed;
            return true;
        }
        return false;
    }

    /**
     * @brief Removes a range of items from the ArrayList.
     *
     * This function removes a range of items from the ArrayList, from the specified fromIndex (inclusive) to the specified toIndex (exclusive).
     * If fromIndex is greater than toIndex, or if either index is out of bounds, it prints an error message and returns without removing any items.
     * If the indices are valid, it shifts all items from toIndex to the end of the ArrayList to the left to fill the gaps left by the removed items, and decrements the count of items by the number of removed items.
     *
     * @param fromIndex The start index of the range to remove (inclusive).
     * @param toIndex The end index of the range to remove (exclusive).
    */
    bool removeRange(size_t fromIndex, size_t toIndex) {
        if (fromIndex > toIndex) {
            return false;
        }
        if (fromIndex < 0 || toIndex > count) {
            return false;
        }
        size_t removed = toIndex - fromIndex +1; //to remove last one: toIndex included
        for (size_t i = fromIndex; i < count - removed; ++i) {
            array[i] = array[i + removed];
        }
        count -= removed;
		return true;
    }

    /**
     * @brief Retains only the items in this ArrayList that are contained in the specified ArrayList.
     *
     * This function removes from this ArrayList all of its items that are not contained in the specified ArrayList.
     * After this call, this ArrayList will contain only the items that are also contained in the other ArrayList.
     *
     * @param other The ArrayList containing the items to be retained in this ArrayList.
     * @return true if this ArrayList changed as a result of the call, false otherwise.
    */
    bool retainAll(const ArrayList<T>& other) {
        size_t removed = 0;
        for (size_t i = 0; i < count; ++i) {
            if (!other.contains(array[i])) {
                ++removed;
            } else {
                array[i - removed] = array[i];
            }
        }
        if (removed > 0) {
            count -= removed;
            return true;
        }
        return false;
    }

    #endif
    /**
     * @brief Clears all items from the ArrayList.
     *
     * This function clears all items from the ArrayList and sets the count of items to 0.
    */
    void clear() {
        delete[] array;
        array = new T[arrayCapacity];
        count = 0;
    }

    //Query and Access
    
    /**
     * @brief Retrieves the item at a specific index in the ArrayList.
     *
     * This function retrieves the item at the specified index in the ArrayList. If the index is less than the count of items in the ArrayList,
     * it returns the item at the index. If the index is out of bounds, it returns a default-constructed instance of type T.
     *
     * @param index The index of the item to retrieve.
     * @return The item at the specified index, or a default-constructed instance of type T if the index is out of bounds.
    */
    T get(size_t index) const {
        if (index < count) {
            return array[index];
        }
        return T();// Return default value if index is out of bounds
    }

    /**
     * @brief Retrieves the item at a specific index in the ArrayList as a String.
     *
     * This function retrieves the item at the specified index in the ArrayList and converts it to a String. If the index is less than the count of items in the ArrayList,
     * it returns the item at the index as a String. If the index is out of bounds, it returns a default-constructed instance of type T as a String.
     *
     * @param index The index of the item to retrieve.
     * @return The item at the specified index as a String, or a default-constructed instance of type T as a String if the index is out of bounds.
    */
    String getAsString(size_t index) const {
        if (index < count) {
            return toString(array[index]);
        }
        return toString(T());// Return default value if index is out of bounds
    }

    /**
     * @brief Converts a value of type T to a String.
     *
     * This function converts the specified value of type T to a String using the String constructor.
     * The type T must be a type that the String constructor can accept.
     *
     * @param value The value to convert to a String.
     * @return The String representation of the value.
    */
    String toString(const T& value) {
        return String(value);
    }

    /**
     * @brief Checks if the ArrayList contains an item.
     *
     * This function checks if the ArrayList contains the specified item. If the item is found in the ArrayList, it returns true.
     * If the item is not found in the ArrayList, it returns false.
     *
     * @param item The item to check for.
     * @return true if the ArrayList contains the item, false otherwise.
    */
    bool contains(T item) const {
        for (size_t i = 0; i < count; ++i) {
            if (array[i] == item) {
                return true;
            }
        }
        return false;
    }
    
    /**
    * @brief Finds the index of the first occurrence of the specified item in the ArrayList.
    *
    * This function returns the index of the first occurrence of the specified item in the ArrayList, or -1 if the ArrayList does not contain the item.
    * It iterates over the ArrayList from the beginning to the end, comparing each item with the specified item using the == operator.
    * If it finds a match, it returns the index of the match. If it does not find a match, it prints an error message (if debug is true) and returns -1.
    *
    * @param item The item to find in the ArrayList.
    * @return The index of the first occurrence of the item in the ArrayList, or -1 if the ArrayList does not contain the item.
    */
    size_t indexOf(T item) const {
        for (size_t i = 0; i < count; ++i) {
            if (array[i] == item) {
                return i;
            }
        }
        return static_cast<size_t>(-1); // Indicate not found
    } 

    /**
     * @brief Retrieves the capacity of the ArrayList.
     *
     * This function returns the current capacity of the ArrayList, which is the maximum number of items it can hold without resizing.
     *
     * @return The capacity of the ArrayList.
    */
    size_t capacity() const {
        return arrayCapacity;
    }

    /**
     * @brief Retrieves the count of items in the ArrayList.
     *
     * This function returns the current count of items in the ArrayList.
     *
     * @return The count of items in the ArrayList.
    */
    size_t size() const {
        return count;
    }

    /**
     * @brief Checks if the ArrayList is empty.
     *
     * This function checks if the ArrayList is empty. If the ArrayList is empty, it returns true. If the ArrayList is not empty, it returns false.
     *
     * @return true if the ArrayList is empty, false otherwise.
    */
    bool isEmpty() const {
        return count == 0;
    }

    /**
     * @brief Sets the item at a specific index in the ArrayList.
     *
     * This function updates the item at the specified index in the ArrayList with the provided item.
     * If the index is within bounds, it sets the item and returns true if the operation succeeds.
     * If the index is out of bounds, it returns false.
     *
     * @param index The index at which to set the item.
     * @param item The item to set at the specified index.
     * @return true if the item was successfully set, false if the item was not set or the index is out of bounds.
     */
    bool set(size_t index, T item) {
        bool resizeNeeded = verifyResizeNeeded(index + 1);
        if(resizeNeeded){
            resize();
        }
        if (index < count) {
            array[index] = item;
            return array[index] == item;
        }
        
        return false;
    }

    #ifndef SkinnyArray //If SkinnyArray is not defined 

    /**
     * @brief Replaces each item in the ArrayList with the result of applying an operator function to that item.
     *
     * This function applies the specified operator function to each item in the ArrayList, and replaces the item with the result of the function.
     * The operator function is a function that takes an item of type T and returns a new item of type T.
     * The function uses the Operators library, which can be found at: https://github.com/braydenanderson2014/C-Arduino-Libraries/tree/main/lib
     *
     * @note You can utilize any Operator function from the Operators library, or create your own.
     * @param operatorFunction The operator function to apply to each item.
    */
    void replaceAll(T (*operatorFunction)(T)) {
        for (size_t i = 0; i < count; ++i) {
            array[i] = operatorFunction(array[i]);
        }
    }


    //Utility Functions
    /**
     * @brief Performs an action on each item in the ArrayList.
     *
     * This function applies the specified consumer function to each item in the ArrayList.
     * The consumer function is a function that takes an item of type T and performs an action on it.
     * The function does not return a result.
     * The function can use the Operators library, if needed, which can be found at: https://github.com/braydenanderson2014/C-Arduino-Libraries/tree/main/lib
     *
     * @param consumer The consumer function to apply to each item.
    */
    void forEach(void (*consumer)(T)) const {
        for (size_t i = 0; i < count; ++i) {
            consumer(array[i]);
        }
    }

    /**
     * @brief Converts the ArrayList to an array.
     *
     * This function copies the items from the ArrayList into the specified output array.
     * The output array must be large enough to hold all items in the ArrayList.
     * The function uses the memcpy function to copy the items, so the type T must be trivially copyable.
     *
     * @param outputArray The array into which to copy the items.
     * @return The output array.
    */
    T* toArray(T* outputArray) const {
        memcpy(outputArray, array, count * sizeof(T));
        return outputArray;
    }
	T* subtoArray(T* outputArray, size_t fromIndex, size_t toIndex) const {
        if (fromIndex > toIndex) {return nullptr;}
        if (fromIndex < 0 || toIndex > count) {return nullptr;}
        int j = 0;
        for (size_t i = fromIndex; i <= toIndex; ++i) {
            outputArray[j]=array[i];
		++j;}
        return outputArray;
    }

    /**
     * @brief Creates a sublist of the ArrayList.
     *
     * This function creates a new ArrayList that contains the items in the original ArrayList from the specified fromIndex, inclusive, to the specified toIndex, exclusive.
     * If fromIndex is greater than toIndex, or if either index is out of bounds, the function returns nullptr.
     *
     * @param fromIndex The start index of the sublist, inclusive.
     * @param toIndex The end index of the sublist, exclusive.
     * @return A new ArrayList that contains the items in the sublist, or nullptr if the indices are invalid.
    */
    ArrayList<T>* sublist(size_t fromIndex, size_t toIndex) const {
        if (fromIndex > toIndex) {
            return nullptr;
        }
        if (fromIndex < 0 || toIndex > count) {
            return nullptr;
        }
        ArrayList<T>* newList = new ArrayList<T>(sizeType, toIndex - fromIndex);
        for (size_t i = fromIndex; i < toIndex; ++i) {
            newList->add(array[i]);
        }
        return newList;
    }

    /**
     * @brief Ensures that the ArrayList can hold at least the specified number of items without needing to resize.
     *
     * This function checks if the ArrayList's current capacity is less than the specified minimum capacity.
     * If it is, it resizes the ArrayList to the specified minimum capacity.
     * The function uses the memcpy function to copy the items to the new array, so the type T must be trivially copyable.
     *
     * @param minCapacity The minimum capacity that the ArrayList should be able to hold without resizing.
    */
    void ensureCapacity(size_t minCapacity) {
        if (minCapacity > arrayCapacity) {
            T* newArray = new T[minCapacity];
            memcpy(newArray, array, count * sizeof(T));
            delete[] array;
            array = newArray;
            arrayCapacity = minCapacity;
        }
    }

    /**
     * @brief Trims the capacity of the ArrayList to its current size.
     *
     * This function reduces the capacity of the ArrayList to its current size, i.e., the number of items it contains.
     * If the ArrayList is dynamic and its capacity is greater than its size, it creates a new array with a capacity equal to the size, copies the items to the new array, and deletes the old array.
     * If the ArrayList is already trimmed or is fixed size, it prints an error message (if debug is true).
    */
    bool trimToSize() {
        if (sizeType == DYNAMIC && count < arrayCapacity) {
            T* newArray = new T[max(count,(uint)1)];
            memcpy(newArray, array, count * sizeof(T));
            delete[] array;
            array = newArray;
            arrayCapacity = count+1;
			return true;
        } else if(sizeType == DYNAMIC2 && count < arrayCapacity){
            T* newArray = new T[max(count,(uint)1)];
            memcpy(newArray, array, count * sizeof(T));
            delete[] array;
            array = newArray;
			arrayCapacity = count+1;
			return true;
        }
		return false;
    }

    #endif

    #ifndef SkinnyArray //If SkinnyArray is not defined, define the SpecialtySearch function
    /**
     * @brief Sets the sorting algorithm to use for sorting the ArrayList.
     *
     * This function sets the sorting algorithm to use for sorting the ArrayList.
     * The sorting algorithm is specified by the SortAlgorithm enum value.
     *
     * @param algorithm The sorting algorithm to use.
    */
    void setSortAlgorithm(SortAlgorithm algorithm = MERGE_SORT){
        sortAlgorithm = algorithm;
    }

    /**
     * @brief Gets the sorting algorithm used for sorting the ArrayList.
     *
     * This function gets the sorting algorithm used for sorting the ArrayList.
     * The sorting algorithm is specified by the SortAlgorithm enum value.
     *
     * @return The sorting algorithm used for sorting the ArrayList.
    */
    SortAlgorithm getSortAlgorithm(){
        return sortAlgorithm;
    }

    /**
     * @brief Sorts the ArrayList.
     * 
     * This function sorts the ArrayList using the specified comparator function
     * Sorting Algorithm is determined by the sortAlgorithm variable (use the sort function to set the sorting algorithm)
    */
    void sort(bool (*comparator)(T, T)) {
        switch (sortAlgorithm) {
            case BUBBLE_SORT:
                bubbleSort(comparator);
                break;
            case QUICK_SORT:
                quickSort(comparator, 0, count - 1);
                break;
            default:
                mergeSort(*this, 0, count - 1);
            break;
        }
    }

    /**
     * @brief Sorts the ArrayList.
     *
     * This function sorts the ArrayList using the specified comparator function and sorting algorithm.
     * The comparator function is a function that takes two items of type T and returns true if the first item is less than the second item, or false otherwise.
     * The sorting algorithm is an enum value that specifies the sorting algorithm to use. The available sorting algorithms are BUBBLE_SORT and QUICK_SORT.
     * The function uses the bubble sort algorithm by default.
     * The function can use the Predicates library, which can be found at:
    */ 
    void sort(bool (*comparator)(T, T), SortAlgorithm algorithm) { 
        switch (algorithm) { 
            case BUBBLE_SORT: 
                bubbleSort(comparator); 
            break; 
            case QUICK_SORT: 
                quickSort(comparator, 0, count - 1); 
            break; // Add cases for additional sorting algorithms 
            default:
                mergeSort(*this, 0, count - 1);
            break;
        } 
    }

    /**
     * @brief Sorts the ArrayList using the bubble sort algorithm.
     *
     * This function sorts the items in the ArrayList using the bubble sort algorithm.
     * The order of the items is determined by the specified comparator function.
     * The comparator function should take two items of type T and return true if the first item should come after the second item in the sorted ArrayList, and false otherwise.
     *
     * @param comparator The comparator function that determines the order of the items.
    */
    void bubbleSort(bool (*comparator)(T, T)) {
        for (size_t i = 0; i < count - 1; ++i) {
            for (size_t j = 0; j < count - i - 1; ++j) {
                if (comparator(array[j], array[j + 1])) {
                    T temp = array[j];
                    array[j] = array[j + 1];
                    array[j + 1] = temp;
                }
            }
        }
    }

    /**
     * @brief Sorts the ArrayList using the quick sort algorithm.
     *
     * This function sorts the items in the ArrayList using the quick sort algorithm.
     * The order of the items is determined by the specified comparator function.
     * The comparator function should take two items of type T and return true if the first item should come after the second item in the sorted ArrayList, and false otherwise.
     *
     * @param comparator The comparator function that determines the order of the items.
    */
    void quickSort(bool (*comparator)(T, T)) {
        quickSortHelper(comparator, 0, count - 1);
    }


    #endif
    /**
     * @brief Returns a pointer to the first item in the ArrayList.
     *
     * This function returns a pointer to the first item in the ArrayList.
     * This can be used to iterate over the ArrayList using pointer arithmetic.
     *
     * @return A pointer to the first item in the ArrayList.
    */
    T* begin() const { 
        return &array[0]; 
    }
    
    /**
     * @brief Returns a pointer to the item after the last item in the ArrayList.
     *
     * This function returns a pointer to the item after the last item in the ArrayList.
     * This can be used to iterate over the ArrayList using pointer arithmetic.
     *
     * @return A pointer to the item after the last item in the ArrayList.
    */
    T* end() const { 
        return &array[count]; 
    }

    #ifndef SkinnyArray //If SkinnyArray is not defined define the following functions

    /**
     * Recursively sorts the elements of an ArrayList using the Merge Sort algorithm.
     * This function splits the list into two halves, calls itself for the two halves,
     * and then merges the two sorted halves. The function uses the merge() function
     * for merging two halves. The recursive sorting continues until the sub-arrays
     * have only one element each, which are inherently sorted.
     * 
     * @param list Reference to an ArrayList of template type T to be sorted.
     * @param l The starting index of the sub-array to be sorted.
     * @param r The ending index of the sub-array to be sorted.
     * @template T The data type of the elements in the ArrayList.
    */
    void mergeSort(ArrayList<T>& list, int l, int r) {
        if (l < r) {
            int m = l + (r - l) / 2;
            mergeSort(list, l, m);
            mergeSort(list, m + 1, r);
            merge(list, l, m, r);
        }
    }

    /**
     * @brief Sets the size type of the ArrayList.
     *
     * This function sets the size type of the ArrayList. (DYNAMIC, DYNAMIC2, FIXED)
     * 
     * @param type The size type to set.
     */
    void setSizeType(SizeType type){
        sizeType = type;
    }


    /**
     * @brief Gets the size type of the ArrayList.
     *
     * This function gets the size type of the ArrayList. (DYNAMIC, DYNAMIC2, FIXED)
     * 
     * @return The size type of the ArrayList.
     */
    SizeType getSizeType(){
        return sizeType;
    }

    /**
     * @brief Gets the initial size of the ArrayList.
     *
     * This function gets the initial size of the ArrayList.
     * 
     * @return The initial size of the ArrayList.
     */
    size_t getInitialSize(){
        return initialSize;
    }

    /**
     * @brief Sets the initial size of the ArrayList.
     *
     * This function sets the initial size of the ArrayList.
     * 
     * @param size The initial size to set.
     */
    void setInitialSize(size_t size){
        initialSize = size;
    }

   #endif

 private:
    T* array;
    size_t arrayCapacity;
    size_t count;
    size_t initialSize;
    #ifndef SkinnyArray //If SkinnyArray is not defined, define following variables
    SizeType sizeType;
    SortAlgorithm sortAlgorithm;
    #elif defined(OverrideSort) //If OverrideSort is defined, define following variables
    SortAlgorithm sortAlgorithm;
    #elif defined(OverrideUtilityFunctions) //If OverrideUtility is defined, define following variables
    SizeType sizeType;
    #endif
    /**
     * @brief Resizes the ArrayList.
     *
     * This function resizes the ArrayList to 1.5 times its current capacity.
     * It creates a new array with the new capacity, copies the items to the new array, and deletes the old array.
     * If the new capacity is greater than the maximum size_t value, it prints an error message (if debug is true) and does not resize the ArrayList.
     * @attention The function name has been changed to resize1() from resize() PIO: Version 1.0.5 ALM: 1.0.2
     * 
     * @details This function uses a different algorithm then resize2() to resize the ArrayList. This function is faster than resize2() but is less reliable.
     * also, it resizes to 2 times it current capacity
     * @related resize2()
    */
    void resize1() {
        size_t newCapacity = arrayCapacity * 2;
        T* newArray = new T[newCapacity];
        memcpy(newArray, array, count * sizeof(T));
        delete[] array;
        array = newArray;
        size_t tempCapacity = newCapacity;
        int oldCapacity = arrayCapacity;
        arrayCapacity = newCapacity;
        if(tempCapacity != arrayCapacity){
            arrayCapacity = oldCapacity;
        }
    }

    /**
     * @brief Resizes the ArrayList.
     *
     * This function resizes the ArrayList to 1.5 times its current capacity.
     * It creates a new array with the new capacity, copies the items to the new array, and deletes the old array.
     * If the new capacity is greater than the maximum size_t value, it prints an error message (if debug is true) and does not resize the ArrayList.
     * @details This uses a different algorithm then resize1() to resize the ArrayList. ADDED PIO: Version 1.0.4 ALM: 1.0.1 
     * This function is slower then resize1() but is more reliable. Also resizes to 1.5 times its current capacity
     * 
     * @related resize1()
     * @note This function has been refractored to ensure proper functioning.
     */
    void resize2() {
        size_t newCapacity = arrayCapacity + (arrayCapacity / 2);
        T* newArray = new T[newCapacity];
        for(size_t i = 0; i < count; i++){
            newArray[i] = array[i];
        }
        delete[] array;
        array = newArray;
        size_t tempCapacity = newCapacity;
        int oldCapacity = arrayCapacity;
        arrayCapacity = newCapacity;
        if(tempCapacity != arrayCapacity){
            arrayCapacity = oldCapacity;
        }
    }
	    
	
	/**
     * @brief Verifies if a resize is needed.
     *
     * This function verifies if a resize is needed based on the number of spaces needed.
     * If the size type is FIXED, the function returns false.
     * If the count plus the number of spaces needed is greater than the array capacity, or the load factor is greater than 0.75, the function returns true.
     * Otherwise, the function returns false.
     *
     * @param spacesNeeded The number of spaces needed in the ArrayList.
     * @return true if a resize is needed, false otherwise.
     * 
     * @note This function has been refractered to ensure proper functionality.
    */
    bool verifyResizeNeeded(size_t spacesNeeded) {
        return sizeType != FIXED && (count + spacesNeeded > arrayCapacity);
    }


    /**
     * @brief Resizes the ArrayList.
     * This function calls the necessary resize functions based on the size type.
     * If the size type is DYNAMIC, it calls resize1().
     * If the size type is DYNAMIC2, it calls resize2().
     * If the size type is FIXED, it does nothing. returns void
     */
    void resize(){
        if(sizeType == FIXED){
            return;
        }
        if(sizeType == DYNAMIC){
            resize1();
        } else if(sizeType == DYNAMIC2){
            resize2();
        } 
    }

    #ifndef SkinnyArray //If SkinnyArray is not defined, define following functions

    /**
     * @brief Sorts the ArrayList using the quick sort algorithm.
     *
     * This function sorts the items in the ArrayList using the quick sort algorithm.
     * The order of the items is determined by the specified comparator function.
     * The comparator function should take two items of type T and return true if the first item should come after the second item in the sorted ArrayList, and false otherwise.
     *
     * @param comparator The comparator function that determines the order of the items.
     * @param low The lowest index of the sublist to sort.
     * @param high The highest index of the sublist to sort.
    */
    int partition(bool (*comparator)(T, T), int low, int high) { 
        T pivot = array[high]; 
        int i = (low - 1); 
        for (int j = low; j <= high - 1; j++) { 
            if (comparator(array[j], pivot)) { 
                i++; 
                swap(&array[i], &array[j]); 
            } 
        } 
        swap(&array[i + 1], &array[high]); 
        return (i + 1); 
    } 

    /**
     * @brief Sorts the ArrayList using the quick sort algorithm.
     *
     * This function sorts the items in the ArrayList using the quick sort algorithm.
     * The order of the items is determined by the specified comparator function.
     * The comparator function should take two items of type T and return true if the first item should come after the second item in the sorted ArrayList, and false otherwise.
     *
     * @param comparator The comparator function that determines the order of the items.
     * @param low The lowest index of the sublist to sort.
     * @param high The highest index of the sublist to sort.
    */
    void quickSortHelper(bool (*comparator)(T, T), int low, int high) {
        if (low < high) { 
            int pi = partition(comparator, low, high); 
            quickSortHelper(comparator, low, pi - 1); 
            quickSortHelper(comparator, pi + 1, high);
        } 
    }
 
    /**
     * Merges two halves of an ArrayList that have been sorted independently.
     * The function takes three indices, l (left index), m (middle index), and r (right index).
     * It assumes that the sub-arrays ArrayList[l..m] and ArrayList[m+1..r] are sorted,
     * and merges them into a single sorted sub-array ArrayList[l..r].
     * 
     * @param list Reference to an ArrayList of template type T that is being sorted.
     * @param l The starting index of the first sub-array.
     * @param m The ending index of the first sub-array, which also serves as the middle point.
     * @param r The ending index of the second sub-array.
    */
    void merge(ArrayList<T>& list, int l, int m, int r) {
        int i, j, k;
        int n1 = m - l + 1;
        int n2 = r - m;

        // Create temp arrays
        T* L = new T[n1];
        T* R = new T[n2];

        // Copy data to temp arrays L[] and R[]
        for (i = 0; i < n1; i++)
            L[i] = list[l + i];
        for (j = 0; j < n2; j++)
            R[j] = list[m + 1 + j];

        // Merge the temp arrays back into list[l..r]
        i = 0; // Initial index of first subarray
        j = 0; // Initial index of second subarray
        k = l; // Initial index of merged subarray
        while (i < n1 && j < n2) {
            if (L[i] <= R[j]) {
                list[k] = L[i];
                i++;
            } else {
                list[k] = R[j];
                j++;
            }
            k++;
        }

        // Copy the remaining elements of L[], if there are any
        while (i < n1) {
            list[k] = L[i];
            i++;
            k++;
        }

        // Copy the remaining elements of R[], if there are any
        while (j < n2) {
            list[k] = R[j];
            j++;
            k++;
        }

        delete[] L;
        delete[] R;
    }


    /**
     * @brief Swaps two items in the ArrayList.
     *
     * This function swaps the items at the specified indices in the ArrayList.
     *
     * @param a The index of the first item to swap.
     * @param b The index of the second item to swap.
    */
    void swap(T* a, T* b) { 
        T t = *a; 
        *a = *b; 
        *b = t; 
    } 
    #elif defined (OverrideSort) //If OverrideSort is defined, define following functions
    
    /**
     * @brief Sorts the ArrayList using the quick sort algorithm.
     *
     * This function sorts the items in the ArrayList using the quick sort algorithm.
     * The order of the items is determined by the specified comparator function.
     * The comparator function should take two items of type T and return true if the first item should come after the second item in the sorted ArrayList, and false otherwise.
     *
     * @param comparator The comparator function that determines the order of the items.
     * @param low The lowest index of the sublist to sort.
     * @param high The highest index of the sublist to sort.
    */
    int partition(bool (*comparator)(T, T), int low, int high) { 
        T pivot = array[high]; 
        int i = (low - 1); 
        for (int j = low; j <= high - 1; j++) { 
            if (comparator(array[j], pivot)) { 
                i++; 
                swap(&array[i], &array[j]); 
            } 
        } 
        swap(&array[i + 1], &array[high]); 
        return (i + 1); 
    } 

    /**
     * @brief Sorts the ArrayList using the quick sort algorithm.
     *
     * This function sorts the items in the ArrayList using the quick sort algorithm.
     * The order of the items is determined by the specified comparator function.
     * The comparator function should take two items of type T and return true if the first item should come after the second item in the sorted ArrayList, and false otherwise.
     *
     * @param comparator The comparator function that determines the order of the items.
     * @param low The lowest index of the sublist to sort.
     * @param high The highest index of the sublist to sort.
    */
    void quickSortHelper(bool (*comparator)(T, T), int low, int high) {
        if (low < high) { 
            int pi = partition(comparator, low, high); 
            quickSortHelper(comparator, low, pi - 1); 
            quickSortHelper(comparator, pi + 1, high);
        } 
    }
 
    /**
     * Merges two halves of an ArrayList that have been sorted independently.
     * The function takes three indices, l (left index), m (middle index), and r (right index).
     * It assumes that the sub-arrays ArrayList[l..m] and ArrayList[m+1..r] are sorted,
     * and merges them into a single sorted sub-array ArrayList[l..r].
     * 
     * @param list Reference to an ArrayList of template type T that is being sorted.
     * @param l The starting index of the first sub-array.
     * @param m The ending index of the first sub-array, which also serves as the middle point.
     * @param r The ending index of the second sub-array.
    */
    void merge(ArrayList<T>& list, int l, int m, int r) {
        int i, j, k;
        int n1 = m - l + 1;
        int n2 = r - m;

        // Create temp arrays
        T* L = new T[n1];
        T* R = new T[n2];

        // Copy data to temp arrays L[] and R[]
        for (i = 0; i < n1; i++)
            L[i] = list[l + i];
        for (j = 0; j < n2; j++)
            R[j] = list[m + 1 + j];

        // Merge the temp arrays back into list[l..r]
        i = 0; // Initial index of first subarray
        j = 0; // Initial index of second subarray
        k = l; // Initial index of merged subarray
        while (i < n1 && j < n2) {
            if (L[i] <= R[j]) {
                list[k] = L[i];
                i++;
            } else {
                list[k] = R[j];
                j++;
            }
            k++;
        }

        // Copy the remaining elements of L[], if there are any
        while (i < n1) {
            list[k] = L[i];
            i++;
            k++;
        }

        // Copy the remaining elements of R[], if there are any
        while (j < n2) {
            list[k] = R[j];
            j++;
            k++;
        }

        delete[] L;
        delete[] R;
    }


    /**
     * @brief Swaps two items in the ArrayList.
     *
     * This function swaps the items at the specified indices in the ArrayList.
     *
     * @param a The index of the first item to swap.
     * @param b The index of the second item to swap.
    */
    void swap(T* a, T* b) { 
        T t = *a; 
        *a = *b; 
        *b = t; 
    } 
    #endif
};
#endif // ARRAYLIST_H