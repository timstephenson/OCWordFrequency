# Coding Challenge

Write a function that takes two parameters:
(1) a String representing the contents of a text document
(2) an integer providing the number of items to return

Implement the function such that it returns a list of Strings ordered by word frequency, the most frequently occurring word first. 
Use your best judgment to decide how words are separated.
Implement this function as you would for a production / commercial system

You may use any standard data structures.
You may use Objective-C as your programming language.

Performance Constraints:
Your solution must run in O(n) time where n is the number of characters in the document.
Please provide reasoning on how the solution obeys the O(n) constraint.


### Two Implementations

There are two implementations of the sortedWordFrequency method.

Because I am excited about Swift, I've done the assignment twice. The fist time, using swift. I then implemented the same methods again using Objective-c. 

WordFrequency is the Swift version of the challenge.
OCWordFrequency is the Objective-C version.

Both methods take two parameters:
(1) a String representing the contents of a text document
(2) an integer providing the number of items to return

Both methods return a sorted array of dictionary objecst that contains the Strings ordered by word frequency, 
the most frequently occurring word first.

The first, sortedWordFrequency uses an enumerator to iterate over the string and add words
to a NSCounted set.

The second, fasterSortedWordFrequency splits the words into an array using NSMutableCharacterSet 
as separators, and then adds the array to the NSCounted set all at once, eliminating a high level enumeration.

While the second approach is faster, words wrapped in single quotes get added with the quotes,
and phrases with single quotes may create words with a leading or trailing single quote. I'm sure this
could be over come given a little extra time. In many cases this may be acceptable, so I'm leaving 
both methods in the class for additional exploration.

You can run the application to see it display the top 20 words from the textView. There is also a suite of tests that verify functionality.

I've tried to meet the linear time constraint by using data structures built specifically for this type of task, and limiting iterations over the data. I've also prepared tests to measure the time it take to complete the text as the string gets larger. Here's some data for the two methods. All of my measurement was done using Swift. 


Method                      | Time for:  | 191,250 Chrs | 382,500 Chrs | 765,000 Chrs | 1,530,000 Chrs | 3,060,000 Chrs
----------------------------| ---------- | ------------ | ------------ | ------------ | -------------- | ----------------
sortedWordFrequency         |            | 1.002        | 1.99         | 3.914        | 8.02           | 15.985
fasterSortedWordFrequency   |            | 0.38         | 0.756        | 1.459        | 3.013          | 5.991

Please let me know if there is anything else that I can do.

Best

Tim

