//
//  CoverFlowLayout.m
//  GOTCollectionView
//
//  Created by Toni on 18/09/15.
//  Copyright (c) 2015 Ricardo Sanchez. All rights reserved.
//

#import "CoverFlowLayout.h"

@implementation CoverFlowLayout

- (instancetype)init {
    if (self == [super init]) {
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.itemSize = CGSizeMake(400, 400);
        self.sectionInset = UIEdgeInsetsMake(10, 10, 0, 0);
        self.minimumLineSpacing = -50.0;
    }
    return self;
}

- (void)setCellAttributes:(UICollectionViewLayoutAttributes *)attributes
           forVisibleRect:(CGRect)visibleRect
{
    CGFloat distance = CGRectGetMidX(visibleRect) - attributes.center.x;
    CGFloat normalizedDistance = distance /
    (self.collectionView.frame.size.width/2.0);
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1/(4.6777 * self.itemSize.width);
    attributes.transform3D = CATransform3DRotate(transform,
                                                 normalizedDistance*M_PI/2.0, 0, 1, 0);
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *attributtes = [super layoutAttributesForElementsInRect:rect];
    
    CGRect visibleRect;
    visibleRect.origin = self.collectionView.contentOffset;
    visibleRect.size = self.collectionView.bounds.size;
    
    for (UICollectionViewLayoutAttributes *attribute in attributtes) {
        if (CGRectIntersectsRect(attribute.frame, visibleRect)) {
            [self setCellAttributes:attribute forVisibleRect:visibleRect];
        }
    }
    
    return attributtes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributtes = [super layoutAttributesForItemAtIndexPath:indexPath];
    
    CGRect visibleRect;
    visibleRect.origin = self.collectionView.contentOffset;
    visibleRect.size = self.collectionView.bounds.size;
    
    [self setCellAttributes:attributtes forVisibleRect:visibleRect];
    
    return attributtes;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

@end
