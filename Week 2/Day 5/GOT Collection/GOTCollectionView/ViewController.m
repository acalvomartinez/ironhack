//
//  ViewController.m
//  GOTCollectionView
//
//  Created by Ricardo Sánchez Sotres on 12/06/14.
//  Copyright (c) 2014 Ricardo Sanchez. All rights reserved.
//

#import "ViewController.h"

#import "GotModel.h"

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet GotModel *model;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self loadModel];
}

- (void)loadModel {
    [self.model loadModel];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.model.characters count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    return cell;
}


@end
