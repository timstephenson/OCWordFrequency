//
//  ViewController.m
//  OCWordFrequency
//
//  Created by Tim Stephenson on 6/20/14.
//  Copyright (c) 2014 Tim Stephenson. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize textView, commonWordsTextView, wordFrequency, mostFrequentWords;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    wordFrequency =  [[WordFrequency alloc] init];
    mostFrequentWords = [wordFrequency fasterSorteddWordFrequency: [textView text] limit: 20];
    NSMutableArray *sentences = [[NSMutableArray alloc]initWithCapacity:0];
    [mostFrequentWords enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [sentences addObject: [NSString stringWithFormat:@"%d. '%@' appears: %@ times.", [mostFrequentWords indexOfObject:obj] + 1, [obj valueForKey:@"word"], [obj valueForKey:@"count"]]];
    }];
    commonWordsTextView.text = [sentences componentsJoinedByString:@"\n"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

@end
