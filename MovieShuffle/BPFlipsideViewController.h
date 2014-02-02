//
//  BPFlipsideViewController.h
//  MovieShuffle
//
//  Created by Justin C. Beck on 2/1/14.
//  Copyright (c) 2014 BeckProduct. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BPFlipsideViewController;

@protocol BPFlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(BPFlipsideViewController *)controller;
@end

@interface BPFlipsideViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addButton;

@property (weak, nonatomic) id <BPFlipsideViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end
