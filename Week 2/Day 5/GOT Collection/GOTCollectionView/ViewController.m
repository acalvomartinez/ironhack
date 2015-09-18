//
//  ViewController.m
//  GOTCollectionView
//
//  Created by Ricardo Sánchez Sotres on 12/06/14.
//  Copyright (c) 2014 Ricardo Sanchez. All rights reserved.
//

#import "ViewController.h"

#import "CustomCollectionViewCell.h"

#import "HeaderCollectionView.h"

#import "ZoomInLayout.h"
#import "CoverFlowLayout.h"

#import "GotModel.h"
#import "House.h"
#import "Character.h"

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) UICollectionViewFlowLayout *verticalLayout;
@property (strong, nonatomic) UICollectionViewFlowLayout *horizontalLayout;
@property (strong, nonatomic) UICollectionViewLayout *customLayout;
@property (strong, nonatomic) ZoomInLayout *zoomLayout;
@property (strong, nonatomic) CoverFlowLayout *coverFlowLayout;

@property (strong, nonatomic) IBOutlet GotModel *model;
@property (strong, nonatomic) NSMutableSet *selectedItems;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self setupCollectionView];
    [self loadModel];
    [self registerNibs];
}

- (void)setupCollectionView {
    self.selectedItems = [NSMutableSet new];
    self.collectionView.collectionViewLayout = self.verticalLayout;
    self.collectionView.allowsMultipleSelection = YES;
    
    self.zoomLayout = [[ZoomInLayout alloc] init];
    self.coverFlowLayout = [[CoverFlowLayout alloc] init];
    
}

- (void)loadModel {
    [self.model loadModel];
}

- (void)registerNibs {
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CustomCollectionViewCell class]) bundle:[NSBundle mainBundle]]
          forCellWithReuseIdentifier:@"collectionCell"];
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([HeaderCollectionView class]) bundle:[NSBundle mainBundle]]
          forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                 withReuseIdentifier:@"headerCell"];
}

#pragma mark - Actions

- (IBAction)layoutSegmentedControlValueChanged:(UISegmentedControl *)segmentedControl {
    
    switch (segmentedControl.selectedSegmentIndex) {
        case 0:
            [self.collectionView setCollectionViewLayout:self.verticalLayout animated:NO];
            break;
        case 1:
            [self.collectionView setCollectionViewLayout:self.horizontalLayout animated:NO];
            break;
        case 2:
            [self.collectionView setCollectionViewLayout:self.zoomLayout animated:NO];
            break;
        case 3:
            [self.collectionView setCollectionViewLayout:self.coverFlowLayout animated:NO];
            break;
        default:
            break;
    }
}

- (IBAction)trashButtonPressed:(UIBarButtonItem *)sender {
    [self.collectionView performBatchUpdates:^{
        [self.collectionView deleteItemsAtIndexPaths:[self.selectedItems allObjects]];
        [self.model removeCharacters:self.selectedItems];
        
        [self.selectedItems removeAllObjects];
    } completion:nil];
}


#pragma mark - CollectionView Datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    House *house = [self.model.houses objectAtIndex:section];
    return [house.characters count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.model.houses count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    House *house = [self.model.houses objectAtIndex:indexPath.section];
    
    Character *character = [house.characters objectAtIndex:indexPath.row];
    
    return [self drawCustomCellForCell:cell withCharacter:character];
}

- (UICollectionViewCell *)drawCustomCellForCell:(CustomCollectionViewCell *)cell withCharacter:(Character *)character {
    
    CustomCollectionViewCell *customCell = (CustomCollectionViewCell *)cell;
    NSString *imageName = [NSString stringWithFormat:@"%@.jpg", character.image];
    customCell.imageView.image = [UIImage imageNamed:imageName];
    
    return customCell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    HeaderCollectionView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerCell" forIndexPath:indexPath];
    
    House *house = [self.model.houses objectAtIndex:indexPath.section];
    
    headerView.nameLabel.text = [house.name uppercaseString];
    
    return headerView;
}

#pragma mark - CollectionView Delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.selectedItems addObject:indexPath];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.selectedItems removeObject:indexPath];
}

#pragma mark - Initializers

- (UICollectionViewFlowLayout *)horizontalLayout {
    if (!_horizontalLayout) {
        _horizontalLayout = [UICollectionViewFlowLayout new];
        _horizontalLayout.itemSize = CGSizeMake(150, 250);
        _horizontalLayout.sectionInset = UIEdgeInsetsMake(30, 30, 30, 30);
        _horizontalLayout.headerReferenceSize = CGSizeMake(300, 100);
        _horizontalLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _horizontalLayout;
}

- (UICollectionViewFlowLayout *)verticalLayout {
    if (!_verticalLayout) {
        _verticalLayout = [UICollectionViewFlowLayout new];
        _verticalLayout.itemSize = CGSizeMake(150, 150);
        _verticalLayout.sectionInset = UIEdgeInsetsMake(30, 30, 30, 30);
        _verticalLayout.headerReferenceSize = CGSizeMake(100, 100);
        _verticalLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    return _verticalLayout;
}


@end
