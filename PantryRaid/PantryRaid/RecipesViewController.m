//
//  RecipesViewController.m
//  PantryRaid
//
//  Created by Brenna Pavlinchak on 10/12/16.
//  Copyright © 2016 Brenna Pavlinchak. All rights reserved.
//

#import "RecipesViewController.h"
#import "HomeViewController.h"
#import "PantryViewController.h"
#import "StoreFinderViewController.h"
#import "BarcodeScannerViewController.h"
#import "RecipesViewCell.h"

@interface RecipesViewController ()

@end

@implementation RecipesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{

    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - Accessors


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Notification Observer


#pragma mark - MeetupManagerDelegate


#pragma mark - Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _groups.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecipesViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    Group *group = _groups[indexPath.row];
    [cell.nameLabel setText:group.name];
    [cell.locationLabel setText:[NSString stringWithFormat:@"%@, %@", group.city, group.country]];
    
    return cell;
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */



- (void)didReceiveGroups:(NSArray *)groups
{
    _groups = groups;
    [self->tableView reloadData];
}

- (void)fetchingGroupsFailedWithError:(NSError *)error
{
    NSLog(@"Error %@; %@", error, [error localizedDescription]);
}

@end
