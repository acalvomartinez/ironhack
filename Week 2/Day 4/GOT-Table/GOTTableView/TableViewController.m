//
//  TableViewController.m
//  GOTTableView
//
//  Created by Toni on 17/09/15.
//  Copyright (c) 2015 Ricardo Sanchez. All rights reserved.
//

#import "TableViewController.h"
#import "CustomTableViewCell.h"
#import "GotModel.h"
#import "Casa.h"
#import "Personaje.h"

#import "DetailViewController.h"

@interface TableViewController () <DetailViewControllerDelgate>

@property (nonatomic, strong) GotModel *model;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadModel];
    [self setupNavbar];
}

- (void)setupNavbar {
    self.navigationItem.rightBarButtonItem=self.editButtonItem;
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    self.title = @"Game of Thrones";
}

- (void)loadModel {
    self.model = [[GotModel alloc] init];
    [self.model cargaModelo];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [self.model.casas count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    Casa *house = [self.model.casas objectAtIndex:section];
    return [house.personajes count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    Casa *house = [self.model.casas objectAtIndex:section];
    
    return house.nombre;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
   
    Casa *house = [self.model.casas objectAtIndex:indexPath.section];
    
    Personaje *character = [house.personajes objectAtIndex:indexPath.row];
    
    return [self drawCellForCell:cell withPersonaje:character];
}

- (UITableViewCell *)drawCellForCell:(UITableViewCell *)cell withPersonaje:(Personaje *)character {
    CustomTableViewCell *customCell = (CustomTableViewCell *)cell;
    
    UIImage *image =[UIImage imageNamed:character.imagen];
    
    customCell.imageCharacterView.image = image;
    customCell.backgroundImageView.image = image;
    customCell.nameLabel.text = character.nombre;
    customCell.backgroundImageView.clipsToBounds = YES;
    customCell.contentView.clipsToBounds = YES;
    
    //NSLog(@"%@, %.2f",NSStringFromCGRect(customCell.frame), self.tableView.contentOffset.y);
    
    return customCell;
    
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    Casa *house = [self.model.casas objectAtIndex:section];
    
    UIImage *image = [UIImage imageNamed:house.imagen];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    imageView.contentMode= UIViewContentModeScaleAspectFill;
    return imageView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 98;
}

-(NSString *) tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"KILL!";
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [self.model removeCharacterAtIndexPath:indexPath];
        
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];

        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    [self.model moveCharacterAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
    [self.tableView reloadData];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"detailSegue"]) {
        DetailViewController *detail = (DetailViewController *)segue.destinationViewController;
        detail.delegate = self;
        
        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
        
        Casa *house = [self.model.casas objectAtIndex:indexPath.section];
        
        detail.character = [house.personajes objectAtIndex:indexPath.row];
    }
}

#pragma mark - DetailViewController delegate

- (void) didPressedKillButton:(Personaje *)personaje
{
    [self.model removeCharacter:personaje];
    [self.tableView reloadData];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    for (CustomTableViewCell* cell in self.tableView.visibleCells) {
        float distancia = cell.frame.origin.y-scrollView.contentOffset.y;
        //NSLog(@"%.2f %.2f",distancia, self.view.bounds.size.height);
        [cell setOffset:distancia/self.view.bounds.size.height];
    }
}


@end
