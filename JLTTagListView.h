//
//  JLTTagView.h
//  
//
//  Created by Joel Trew on 26/06/2015.
//
//

#import <UIKit/UIKit.h>

@interface JLTTagListView : UIView <UITextFieldDelegate ,UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *tags;
@property (nonatomic, strong) UIColor *baseColor;


- (id)initWithFrame:(CGRect)frame tags:(NSMutableArray *)tags;
- (id)initWithFrame:(CGRect)frame tags:(NSMutableArray *)tags baseColor:(UIColor *)baseColor;


@end

