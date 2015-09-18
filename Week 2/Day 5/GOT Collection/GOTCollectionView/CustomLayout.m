//
//  CustomLayout.m
//  GOTCollectionView
//
//  Created by Toni on 18/09/15.
//  Copyright (c) 2015 Ricardo Sanchez. All rights reserved.
//

#import "CustomLayout.h"

@implementation CustomLayout


//- (void)prepareLayout {
//    
//}
//
//- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
//    
//}
//
//- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
//    
//}
//
//- (UICollectionViewLayoutAttributes *)calculaAttributesAtIndexPath:(NSIndexPath *)indexPath
//{
//    UICollectionViewLayoutAttributes* attribs = [UICollectionViewLayoutAttributes
//                                                 layoutAttributesForCellWithIndexPath:indexPath];
//    NSInteger row = indexPath.section / self.numberOfColumns;
//    NSInteger column = indexPath.section % self.numberOfColumns;
//    CGFloat separacionX = self.collectionView.bounds.size.width -
//    self.itemInsets.left -
//    self.itemInsets.right -
//    (self.numberOfColumns * self.itemSize.width);
//    if (self.numberOfColumns > 1) separacionX = separacionX / (self.numberOfColumns
//                                                               - 1);
//    CGFloat x = floorf(self.itemInsets.left + (self.itemSize.width + separacionX) *
//                       column);
//    CGFloat y = floor(self.itemInsets.top +
//                      (self.itemSize.height + self.interItemSpacingY) * row);
//    attribs.frame = CGRectMake(x, y, self.itemSize.width, self.itemSize.height);
//    attribs.transform3D =
//    CATransform3DMakeRotation(((float)rand()/RAND_MAX)*M_PI/2.0-M_PI/4.0, 0, 0, 1);
//    return attribs;
//}

@end
