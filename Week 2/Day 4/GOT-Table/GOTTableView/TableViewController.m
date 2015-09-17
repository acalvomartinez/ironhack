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

@interface TableViewController ()

@property (nonatomic, strong) GotModel *model;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadModel];
    //self.navigationController.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.rightBarButtonItem=self.editButtonItem;
}

- (void)loadModel {
    self.model = [[GotModel alloc] init];
    [self.model cargaModelo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
   
    Casa *house = [self.model.casas objectAtIndex:indexPath.section];
    
    Personaje *character = [house.personajes objectAtIndex:indexPath.row];
    UIImage *image =[UIImage imageNamed:character.imagen];

    cell.imageCharacterView.image = image;
    cell.backgroundImageView.image = image;
    cell.nameLabel.text = character.nombre;
    cell.backgroundImageView.clipsToBounds = YES;
    cell.contentView.clipsToBounds = YES;
    
    return cell;
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

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


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


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"detailSegue"]) {
        DetailViewController *detail = (DetailViewController *)segue.destinationViewController;
        
        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
        
        Casa *house = [self.model.casas objectAtIndex:indexPath.section];
        
        detail.character = [house.personajes objectAtIndex:indexPath.row];
    }
}


@end
