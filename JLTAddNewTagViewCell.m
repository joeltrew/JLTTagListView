//
//  JLTAddNewTagViewCell.m
//  ReceiptSaver
//
//  Created by Joel Trew on 27/06/2015.
//  Copyright (c) 2015 Joel Trew. All rights reserved.
//

#import "JLTAddNewTagViewCell.h"

@implementation JLTAddNewTagViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.placeHolder = [[UITextField alloc]init];

    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.placeHolder.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    CGRect paddedFrame = CGRectInset(self.bounds, 10, 0);
    self.placeHolder.placeholder = @"Add Tag";
    self.placeHolder.frame = paddedFrame;
    self.placeHolder.textColor = [UIColor blackColor];
    self.placeHolder.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.placeHolder.layer.shadowOffset = CGSizeMake(0.6f, 0.6f);
    self.placeHolder.layer.shadowOpacity = 0.4f;
    self.placeHolder.layer.shadowRadius = 0.2f;
    self.placeHolder.font = [UIFont fontWithName:@"HelveticaNeue" size:14];

    [self.contentView addSubview:self.placeHolder];

    
}


@end
