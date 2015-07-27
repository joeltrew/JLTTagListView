//
//  JLTTagViewCell.m
//  ReceiptSaver
//
//  Created by Joel Trew on 25/06/2015.
//  Copyright (c) 2015 Joel Trew. All rights reserved.
//

#import "JLTTagViewCell.h"

@implementation JLTTagViewCell

#define tSCGreen [UIColor colorWithRed:0.596 green:0.941 blue:0.043 alpha:1.000]

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tagName = [[UITextField alloc]init];
        self.deleteButton = [[UIButton alloc]init];
        

    }
    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    self.tagName.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    CGRect paddedFrame = CGRectInset(self.bounds, 10, 0);
    self.tagName.frame = paddedFrame;
    self.tagName.textColor = [UIColor whiteColor];
    self.tagName.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.tagName.layer.shadowOffset = CGSizeMake(0.6f, 0.6f);
    self.tagName.layer.shadowOpacity = 0.4f;
    self.tagName.layer.shadowRadius = 0.2f;
    self.tagName.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    
    [self.deleteButton setTitle:@"x" forState:UIControlStateNormal];
    
    self.deleteButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.deleteButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:14];
    [self.deleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.deleteButton.frame = CGRectMake(self.tagName.bounds.size.width + 5, 10, 12, 12);

    
    self.contentView.layer.borderWidth = 1.0;
    self.contentView.layer.borderColor = [UIColor colorWithWhite:0 alpha:0.1].CGColor;
    self.contentView.layer.cornerRadius = 8.0;

    
    [self.contentView addSubview:self.tagName];
    [self.contentView addSubview:self.deleteButton];

}

@end
