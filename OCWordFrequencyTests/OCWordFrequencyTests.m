//
//  OCWordFrequencyTests.m
//  OCWordFrequencyTests
//
//  Created by Tim Stephenson on 6/20/14.
//  Copyright (c) 2014 Tim Stephenson. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WordFrequency.h"

@interface OCWordFrequencyTests : XCTestCase

@property (nonatomic, strong) NSString *sampleText;
@property (nonatomic, strong) WordFrequency *words;

@end

@implementation OCWordFrequencyTests

@synthesize sampleText, words;

- (void)setUp
{
    [super setUp];
    self.sampleText = @"One string, two string, three\n\nstring more. That's three. ... ,,, ;;;";
    self.words = [[WordFrequency alloc] init];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}




// Describe - (NSCountedSet *)countedSetFromString:(NSString *)text
- (void)testCountedSetFromStringReturnsSet
{
    NSCountedSet *set = [words countedSetFromString: self.sampleText];
    XCTAssertTrue([set count] == 6, @"The set should have 6 objects in it");
}

- (void)testCountedSetFromStringContainsWordsWithApostrophes
{
    NSCountedSet *set = [words countedSetFromString: self.sampleText];
    XCTAssertTrue([set countForObject:@"that's"] == 1, @"There should be one instance of the word: that's. It should not be split");
}

-(void)testCountedSetFromStringRemovesQuotesAroundString
{
    NSCountedSet *set = [words countedSetFromString: @" Did you eat your 'spinach'?   "];
    XCTAssertTrue([set countForObject:@"spinach"] == 1, @"Words wrapped in quotes should exist without quotes.");

}

// Describe .sortedListWithLimit(unsortedWords: NSMutableArray, limit: Int) -> NSArray
-(void)testSortedListWithLimitShouldReturnLimitNumberOfItems {
    NSMutableArray *testArray = [[NSMutableArray alloc] initWithObjects:@{ @"word": @"zebra", @"count": @3 }, @{ @"word": @"test", @"count": @5} , @{ @"word": @"swift", @"count": @5 }, nil] ;

    NSArray *sortedWords = [words sortedListWithLimit:testArray limit:1];
    XCTAssertTrue([sortedWords count] == 1, @"There should be only one element in the array.");
}

-(void)testSortedListWithLimitShouldReturnAllItemsWhenLimitIsLarger {
    NSMutableArray *testArray = [[NSMutableArray alloc] initWithObjects:@{ @"word": @"zebra", @"count": @3 }, @{ @"word": @"test", @"count": @5} , @{ @"word": @"swift", @"count": @5 }, nil];
    NSArray *sortedWords = [words sortedListWithLimit:testArray limit:100];
    XCTAssertTrue([sortedWords count] == 3, @"There should 3 elements in the array.");
}

-(void)testSortedListWithLimitShouldReturnMostFrequentFirst {
    NSMutableArray *testArray = [[NSMutableArray alloc] initWithObjects:@{ @"word": @"zebra", @"count": @3 }, @{ @"word": @"test", @"count": @5 } , @{ @"word": @"swift", @"count": @2 }, nil];
    NSArray *sortedWords = [words sortedListWithLimit:testArray limit:100];
    XCTAssertTrue([sortedWords objectAtIndex:0] == [testArray objectAtIndex:1], @"Should return the word test with a count of 5 as the first object.");
}

// Describe .sortedWordFrequency(text: NSString, limit: Int) -> NSArray
-(void)testSortedWordFrequencyReturnsOnlyLimitNumberOfWords {
    NSArray *sortedWords = [words sortedWordFrequency:sampleText limit:1];
    XCTAssertTrue([sortedWords count] == 1, "Should only return the most frequenly used word.");
}

-(void)testSortedWordFrequencyReturnsAllWhenLimitIsLargerThanText {
    NSArray *sortedWords = [words sortedWordFrequency:sampleText limit:100];
    XCTAssertTrue([sortedWords count] == 6, "Should return all of the words.");
}

-(void)testSortedWordFrequencyReturnsMostCommonWordFirst {
    NSArray *sortedWords = [words sortedWordFrequency:sampleText limit:1];
    XCTAssertTrue([[[sortedWords objectAtIndex:0] valueForKey:@"word"] isEqualToString:@"string"], "Should return the word string as as the first object.");
}

-(void)testSortedWordFrequencyReturnsLimitOfWordsWithLessFrequentLast {
    NSArray *sortedWords = [words sortedWordFrequency:sampleText limit:2];
    XCTAssertTrue([sortedWords count] == 2, "Should contain the top 2 most fequently used words.");
    XCTAssertTrue([[[sortedWords objectAtIndex:1] valueForKey:@"word"] isEqualToString:@"three"], "Should return the word three as as the last object.");
}

// Describe .arrayOfWordsFromString(text: NSString) -> NSArray
-(void)testArrayOfWordsFromStringReturnsOnlyWords {
    NSArray *wordArray = [words arrayOfWordsFromString: sampleText];
    XCTAssertTrue([wordArray count] == 9, "There should be 9 words in the array.");
}

-(void)testArrayOfWordsFromStringReturnsWordsWithApostrophes {
    NSArray *wordArray = [words arrayOfWordsFromString: @"   You're on your way. It's true!   "];
    XCTAssertTrue([wordArray containsObject: @"you're"], "Words with apostrophes should still exist. But should be lowercase.");
}

//// A side affect of keeping apostrophes is that words and phrases wrapped single quotes will be with the quote.
//// To do: If this is undesirable, implement less naive approach that also handles plural and other edge cases.
-(void)testArrayOfWordsFromStringReturnsWordsWrappedInSingleQuotes {
    NSArray *wordArray = [words arrayOfWordsFromString: @" Did you eat your 'spinach'?   "];
    XCTAssertTrue([wordArray containsObject: @"'spinach'"], "Words wrapped in quotes should still exist. But should be lowercase.");
}

// Describe .fasterSorteddWordFrequency(text: NSString, limit: Int) -> NSArray

-(void)testOrderedWordFrequencyReturnsOnlyLimitNumberOfWords {
    NSArray *sortedWords = [words fasterSorteddWordFrequency: sampleText limit: 1];
    XCTAssertTrue([sortedWords count] == 1, "Should only return the most frequenly used word.");
}

-(void)testOrderedWordFrequencyReturnsAllWhenLimitIsLargerThanText {
    NSArray *sortedWords = [words fasterSorteddWordFrequency: sampleText limit: 100];
    XCTAssertTrue([sortedWords count] == 6, "Should return all of the words.");
}

-(void)testOrderedWordFrequencyReturnsMostCommonWordFirst {
    NSArray *sortedWords = [words fasterSorteddWordFrequency: sampleText limit: 1];
    XCTAssertTrue([[[sortedWords objectAtIndex:0] valueForKey:@"word"] isEqualToString:@"string"], "Should return the word string as as the first object.");
}

-(void)testOrderedWordFrequencyReturnsLimitOfWordsWithLessFrequentLast {
    NSArray *sortedWords = [words fasterSorteddWordFrequency: sampleText limit: 2];
    XCTAssertTrue([sortedWords count] == 2, "Should contain the top 2 most fequently used words.");
    XCTAssertTrue([[[sortedWords objectAtIndex:1] valueForKey:@"word"] isEqualToString:@"three"], "Should return the word three as as the last object.");
}


@end
