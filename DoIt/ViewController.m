//
//  ViewController.m
//  DoIt
//
//  Created by Fletcher Rhoads on 1/13/14.
//  Copyright (c) 2014 Fletcher Rhoads. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>{
    
    __weak IBOutlet UITableView *myTableView;
    __weak IBOutlet UITextField *myTextField;
    __weak IBOutlet UIButton *myEditButton;
    
    BOOL editButtonPressed;
    NSMutableArray *items;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    items = @[@"One", @"Two", @"Three"].mutableCopy;
    editButtonPressed = YES;
}
- (IBAction)onAddButtonPressed:(id)sender
{
    [items addObject:myTextField.text];
    NSLog(@"%@", items);
    [myTableView reloadData];
    myTextField.text = @"";
    [myTextField resignFirstResponder];
}

- (IBAction)onSwipeRight:(id)sender {
    NSArray *colors = @[[UIColor greenColor], [UIColor yellowColor], [UIColor redColor], [UIColor blackColor]];
    
    
}

- (IBAction)onEditButtonPressed:(id)editButton
{
    if (editButtonPressed == YES) {
        [myEditButton setTitle:@"Done" forState:UIControlStateNormal];
        editButtonPressed = NO;
    } else {
        [myEditButton setTitle:@"Edit" forState:UIControlStateNormal];
        editButtonPressed = YES;
    }
    
}

-(BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [items removeObjectAtIndex:indexPath.row];
        [myTableView reloadData];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    
    if (editButtonPressed == NO) {
        [items removeObjectAtIndex:indexPath.row];
        [myTableView reloadData];
    } else {
        cell.textLabel.textColor = [UIColor greenColor];
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myReuseIdentifier"];
    cell.textLabel.text = [items objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor blackColor];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return items.count;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
