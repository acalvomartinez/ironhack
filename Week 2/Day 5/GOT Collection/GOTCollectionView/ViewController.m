//
//  ViewController.m
//  GOTCollectionView
//
//  Created by Ricardo Sánchez Sotres on 12/06/14.
//  Copyright (c) 2014 Ricardo Sanchez. All rights reserved.
//

#import "ViewController.h"

#import "CustomCollectionViewCell.h"

#import "GotModel.h"
#import "House.h"
#import "Character.h"

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;
@property (strong, nonatomic) IBOutlet GotModel *model;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self setupCollectionViewLayout];
    [self loadModel];
    [self registerNibs];
}

- (void)setupCollectionViewLayout {
    self.layout.headerReferenceSize = CGSizeMake(100,100);
}

- (void)loadModel {
    [self.model loadModel];
}

- (void)registerNibs {
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CustomCollectionViewCell class]) bundle:[NSBundle mainBundle]]
          forCellWithReuseIdentifier:@"collectionCell"];
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


@end
