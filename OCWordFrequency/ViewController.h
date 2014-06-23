//
//  ViewController.h
//  OCWordFrequency
//
//  Created by Tim Stephenson on 6/20/14.
//  Copyright (c) 2014 Tim Stephenson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WordFrequency.h"

@interface ViewController : UIViewController

@property IBOutlet UITextView *textView;
@property IBOutlet UITextView *commonWordsTextView;
@property WordFrequency *wordFrequency;
@property NSArray *mostFrequentWords;

@end
