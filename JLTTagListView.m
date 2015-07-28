//
//  JLTTagView.m
//  
//
//  Created by Joel Trew on 26/06/2015.
//
//

#import "JLTTagListView.h"
#import "JLTTagViewCell.h"
#import "JLTAddNewTagViewCell.h"
#import "UICollectionViewLeftAlignedLayout.h"


@implementation JLTTagListView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        UICollectionViewLeftAlignedLayout *layout = [[UICollectionViewLeftAlignedLayout alloc] init];
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 200, 200) collectionViewLayout:layout];
        self.collectionView.collectionViewLayout = layout;
        self.collectionView.backgroundColor = [UIColor clearColor];
        [self.collectionView setDataSource:self];
        [self.collectionView setDelegate:self];
        [self.collectionView registerClass:[JLTAddNewTagViewCell class] forCellWithReuseIdentifier:@"cellIdentifierAdd"];
        [self.collectionView registerClass:[JLTTagViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];

        self.collectionView.alwaysBounceVertical = YES;
        
        [self addSubview:self.collectionView];
        
    
    }
    return self;
}


- (id)initWithFrame:(CGRect)frame tags:(NSMutableArray *)tags
{
    self = [self initWithFrame:frame];
    if (self) {
        self.tags = tags;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame tags:(NSMutableArray *)tags baseColor:(UIColor *)baseColor
{
    self = [self initWithFrame:frame];
    if (self) {
        self.tags = tags;
        self.baseColor = baseColor;
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.collectionView.frame = self.bounds;
    
}

#pragma mark - Collection View Delegate Methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    //one extra for the add new tag cell :)
    return self.tags.count+1;
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView
{
    return 1;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //check for the last cell, make it a JLTAddNewTagViewCell
    if (indexPath.row == self.tags.count) {
        
        JLTAddNewTagViewCell *cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifierAdd" forIndexPath:indexPath];
        cell.placeHolder.delegate = self;
        cell.placeHolder.tag = 100;
        [cell.placeHolder becomeFirstResponder];
        
        if (self.baseColor) {
            cell.placeHolder.tintColor = self.baseColor;
        }
        
        UITextField *textField = (UITextField *)[cell viewWithTag:100];
        [textField performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:0.0];
        
        return cell;
    }
    

   
    JLTTagViewCell *cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    
    cell.tagName.text = self.tags[indexPath.row];
    [cell.tagName addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    cell.tagName.tag = indexPath.row;
    [cell.deleteButton addTarget:self action:@selector(pressedDelete:) forControlEvents:UIControlEventTouchUpInside];
    cell.deleteButton.tag = indexPath.row;
    
    if (self.baseColor) {
        
        NSArray *colours = [self createArrayOfColoursFromBaseColor:self.baseColor];
        cell.contentView.layer.backgroundColor = [colours[indexPath.row % colours.count]CGColor];
    } else {
        cell.contentView.layer.backgroundColor = [[UIColor lightGrayColor]CGColor];
    }
        cell.contentView.layer.borderColor = [UIColor colorWithWhite:0 alpha:0.1].CGColor;
    cell.tagName.delegate = self;
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.tags.count) {
        return CGSizeMake(100, 30);
    }
    NSString *labelString = [self.tags objectAtIndex:indexPath.row];
    CGRect cellWidth = [labelString boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil];
    
    CGSize cellWidthWithPadding = CGSizeMake(cellWidth.size.width+30, 30);
    return cellWidthWithPadding;
}


- (void)textFieldDidChange:(UITextField *)textField{
    [self.tags replaceObjectAtIndex:textField.tag withObject:textField.text];
    [self.collectionView.collectionViewLayout invalidateLayout];
    
}


- (void)pressedDelete:(UIButton *)button
{
    [self.tags removeObjectAtIndex:button.tag];
    [self.collectionView deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:button.tag inSection:0]]];
    [self.collectionView reloadItemsAtIndexPaths:[self.collectionView indexPathsForVisibleItems]];
    [self.collectionView reloadData];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //if the user returns on an add new cell then..
    if (textField.tag == 100) {
        NSString *textFieldText = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

        if (![textFieldText length] == 0) {
            [self.tags addObject:textField.text];
            [self.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.tags.count inSection:0]]];
            [self.collectionView reloadItemsAtIndexPaths:[self.collectionView indexPathsForVisibleItems]];
            textField.text = @"";

            
        } else {
            textField.text = @"";
            [textField resignFirstResponder];
        }
    }
    
    return YES;
}

- (NSArray *)createArrayOfColoursFromBaseColor:(UIColor *)baseColor
{
    NSMutableArray *colors = [[NSMutableArray alloc]init];
    CGFloat hue, sat, bri, alp;
    [baseColor getHue:&hue saturation:&sat brightness:&bri alpha:&alp];
    UIColor *color = [UIColor colorWithHue:hue saturation:sat brightness:1 alpha:alp];
    
    for (float i = 0; i < 5; i++) {
        if ([color getHue:&hue saturation:&sat brightness:&bri alpha:&alp]) {
            UIColor *newColor = [UIColor colorWithHue:hue saturation:sat brightness:bri-0.06 alpha:alp];
            color = newColor;
            [colors addObject:newColor];
            
        }
    }
    NSArray *colorsArray = [colors copy];
    return colorsArray;
}


@end
