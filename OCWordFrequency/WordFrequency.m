//
//  WordFrequency.m
//  OCWordFrequency
//
//  Created by Tim Stephenson on 6/20/14.
//  Copyright (c) 2014 Tim Stephenson. All rights reserved.
//

#import "WordFrequency.h"

@implementation WordFrequency

@synthesize sortDescriptor;

- (NSArray *)sortedWordFrequency:(NSString *)text limit:(int)limit {
    NSMutableArray *unsortedWords = [[NSMutableArray alloc] initWithCapacity:0];
    NSCountedSet *countedWords = [self countedSetFromString:text];
    
    [countedWords enumerateObjectsUsingBlock:^(id object, BOOL *stop) {
        [unsortedWords addObject:@{@"word": object,
                               @"count": @([countedWords countForObject:object])}];
    }];
    return [self sortedListWithLimit:unsortedWords limit:limit];
}

- (NSCountedSet *)countedSetFromString:(NSString *)text {
    
    NSCountedSet *countedSetOfWords = [NSCountedSet new];
    
    [text enumerateSubstringsInRange:NSMakeRange(0, [text length])
                               options:NSStringEnumerationByWords | NSStringEnumerationLocalized
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop){
                                
                                // Add each substring to the counted set object
                                [countedSetOfWords addObject:[ substring lowercaseString] ];
                            }];
    return countedSetOfWords;
}

// Expects two argumennts
// 1. an array of dictionary objects
// 2. An intger to limit the number of items returned.
// The array is sorted according to the sortDescriptor.
// If the resulting arrya is longer than the limit, a range of the array is returned.
- (NSArray *)sortedListWithLimit:(NSMutableArray *)unsortedWords  limit:(int)limit {
    NSArray *wordsSubset;
    
    self.sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"count" ascending:NO];
    NSArray *descriptorArray = [NSArray arrayWithObject:self.sortDescriptor];
    
    wordsSubset = [unsortedWords sortedArrayUsingDescriptors: descriptorArray];
    
    if (wordsSubset.count < limit) {
        return wordsSubset;
    } else {
        return [wordsSubset subarrayWithRange: NSMakeRange(0, limit)];
    }
}

/*
 This approach uses a character set to split the string into an array.
 Reducing enumeration should improve performance.
 */

-(NSArray *)fasterSorteddWordFrequency:(NSString *)text limit:(int)limit {
    
    NSCountedSet *countedSetOfWords;
    NSMutableArray *unsortedWords = [[NSMutableArray alloc] initWithCapacity: 0];
    
    countedSetOfWords = [[NSCountedSet alloc] initWithArray: [self arrayOfWordsFromString: text]];
    
    [countedSetOfWords enumerateObjectsUsingBlock:^(id object, BOOL *stop) {
        [unsortedWords addObject:@{@"word": object,
                               @"count": @([countedSetOfWords countForObject:object])}];
    }];
    
    return [self sortedListWithLimit:unsortedWords limit:limit];
}

/*
 Takes one argument, text as an NSString and
 builds an array removing whitespace and punctuation, except for single quotes.
 */
- (NSArray *)arrayOfWordsFromString: (NSString *)text {
    
    NSMutableCharacterSet *separators = [NSMutableCharacterSet alphanumericCharacterSet];
    [separators formUnionWithCharacterSet: [NSCharacterSet characterSetWithCharactersInString: @"'"]];
    
    // Split the text into an array using the characterset separators.
    // Remove empty strings from the array
    NSArray *words = [[text lowercaseString] componentsSeparatedByCharactersInSet: [separators invertedSet]];
    return [words filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self <> ''"]];
}



@end
