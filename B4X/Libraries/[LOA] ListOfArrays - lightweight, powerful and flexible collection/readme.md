### [LOA] ListOfArrays - lightweight, powerful and flexible collection by Erel
### 03/10/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/170543/)

ListOfArrays (LOA) is a simple list where each item is an array of objects, and each array represents a row. As LOA stores tabular data, all rows have the same length.  
LOA is lightweight and a list can be converted to a LOA and vice versa, with (almost) no overhead.  
It is loosely inspired by Python DataFrames.  
  
It packs all kinds of useful features, including:  

- Stores arbitrary object types, including UI elements and class instances.
- Lightweight conversion between List and ListOfArrays with almost no overhead.
- Useful for datasets ranging from a few rows to hundreds of thousands of rows.
- Optional header row, allowing columns to be accessed by name or ordinal.
- Fast row, column, and cell access.
- Add, insert, replace, and delete rows and columns.
- Extract, reorder, duplicate, merge, and reshape columns and rows in multiple ways.
- Sorting by a column.
- GroupBy support for splitting rows by column values.
- Row index creation with duplicate-handling options.
- Row lookup helpers for finding rows by column value.
- Conversion to and from string arrays, mainly useful for CSV.
- Shallow and deep cloning.
- Custom iterator designed for filtering and collecting matching row indices.
- Useful string representation.
- Cross platform.

  
Current version is considered a beta version.  
  
Updates:  
v0.91 - API changes in LOASet. New methods: OrRowsSelections, AndRowsSelections and GetRowIndicesByValue  
Examples were also updated.  
  
This thread is locked to keep it concise. Please start a new thread for questions or feedback.