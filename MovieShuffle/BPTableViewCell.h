//
//  BPTableViewCell.h
//  MovieShuffle
//
//  Created by Justin C. Beck on 2/1/14.
//  Copyright (c) 2014 BeckProduct. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BPTableViewCell : UITableViewCell <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *movieName;

@end
