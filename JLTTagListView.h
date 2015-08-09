//
//  JLTTagView.h
//  
//
//  Created by Joel Trew on 26/06/2015.
//
//

#import <UIKit/UIKit.h>

@interface JLTTagListView : UIView <UITextFieldDelegate ,UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

/* A muatble array of tags, these should be strings*/
@property (nonatomic, strong) NSMutableArray *tags;

/* A base color for the tags */
@property (nonatomic, strong) UIColor *baseColor;


- (id)initWithFrame:(CGRect)frame tags:(NSMutableArray *)tags;
- (id)initWithFrame:(CGRect)frame tags:(NSMutableArray *)tags baseColor:(UIColor *)baseColor;


@end

