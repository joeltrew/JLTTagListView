//
//  JLTTagViewCell.h
//  ReceiptSaver
//
//  Created by Joel Trew on 25/06/2015.
//  Copyright (c) 2015 Joel Trew. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JLTTagViewCell : UICollectionViewCell

@property (nonatomic,strong) UITextField *tagName;
@property (nonatomic, strong) UIButton *deleteButton;

@end
