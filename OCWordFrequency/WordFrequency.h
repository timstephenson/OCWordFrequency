//
//  WordFrequency.h
//  OCWordFrequency
//
//  Created by Tim Stephenson on 6/20/14.
//  Copyright (c) 2014 Tim Stephenson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WordFrequency : NSObject

@property (strong, nonatomic) NSSortDescriptor *sortDescriptor;

- (NSArray *)sortedWordFrequency:(NSString *)text  limit:(int)limit;
- (NSCountedSet *)countedSetFromString:(NSString *)text;
- (NSArray *)sortedListWithLimit:(NSMutableArray *)unsortedWords  limit:(int)limit;
- (NSArray *)fasterSorteddWordFrequency:(NSString *)text limit:(int)limit;
- (NSArray *)arrayOfWordsFromString: (NSString *)text;

@end
