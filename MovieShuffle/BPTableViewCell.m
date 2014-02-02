//
//  BPTableViewCell.m
//  MovieShuffle
//
//  Created by Justin C. Beck on 2/1/14.
//  Copyright (c) 2014 BeckProduct. All rights reserved.
//

#import "BPTableViewCell.h"

@implementation BPTableViewCell

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
