//
//  ViewController.m
//  DoIt
//
//  Created by Fletcher Rhoads on 1/13/14.
//  Copyright (c) 2014 Fletcher Rhoads. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>{
    
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
    [myTableView setEditing:YES animated:YES];
}
- (IBAction)onAddButtonPressed:(id)sender
{
    [items addObject:myTextField.text];
    NSLog(@"%@", items);
    [myTableView reloadData];
    myTextField.text = @"";
    [myTextField resignFirstResponder];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editButtonPressed) {
        return YES;
    } else {
        return NO;
    }
    
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    
}

- (NSIndexPath *)tableView:(UITableView *)tableView
targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath
       toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
    
    return proposedDestinationIndexPath;
}

- (IBAction)onSwipeRight:(UIGestureRecognizer*)swipe {
    CGPoint swipeLocation = [swipe locationInView:myTableView];
    NSIndexPath *swipedIndexPath = [myTableView indexPathForRowAtPoint:swipeLocation];
    UITableViewCell *swipedCell = [myTableView cellForRowAtIndexPath:swipedIndexPath];
    
    NSArray *colors = @[[UIColor blackColor], [UIColor greenColor], [UIColor yellowColor], [UIColor redColor], [UIColor blackColor]];
    
    for (int i = 0; i < colors.count; i++) {
        if (colors[i] == swipedCell.textLabel.textColor){
            swipedCell.textLabel.textColor = colors[i+1];
            i = colors.count;
        }
        
    }
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
