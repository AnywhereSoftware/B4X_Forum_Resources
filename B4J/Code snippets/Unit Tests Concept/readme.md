### Unit Tests Concept by Mashiane
### 10/14/2026
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/172273/)

Hi gang!  
  
I wanted to check if my classes delivered on what they promised. This is just a simple example to test.  

- **Initialize** sets up the list used to collect failures.
- **RunAll** resets the counters, runs eight groups of tests, and returns a Map with the assertion count, failure count, failure details, and summary.
- **RunCase** calls a test method by name using CallSub. It catches unexpected exceptions so one broken test doesn’t stop the remaining groups.
- **TestDialects, TestSelectAndConditions, TestReadHelpers, TestWrites, TestStateManagement, TestQueryErrors, TestSchemaCreate, and TestSchemaOperations** exercise the query and schema builders.
- **AssertEqual, AssertTrue, AssertContains, AssertFalseContains, and AssertNoError** check results; **RecordFailure** stores any failure.
- Helpers such as ResultListItem, ResultListSize, EmptyMap, and StringList make the test cases easier to write.

One limitation: AssertEqual compares values after converting them to strings, so it isn’t suitable for precise type-aware or nested Map/List comparisons. The runner also logs failures rather than exposing a rich report or setting a standard test-process exit status.  
  
#SharingTheGoodness