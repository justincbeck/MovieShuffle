//
//  BPFlipsideViewController.m
//  MovieShuffle
//
//  Created by Justin C. Beck on 2/1/14.
//  Copyright (c) 2014 BeckProduct. All rights reserved.
//

#import "BPFlipsideViewController.h"

#import "BPTableViewCell.h"

@interface BPFlipsideViewController ()
{
    NSMutableArray *_moviesArray;
    int editingIndex;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation BPFlipsideViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        _moviesArray = [NSMutableArray array];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSData *undata = [[NSUserDefaults standardUserDefaults] objectForKey:@"movies"];
    NSMutableArray *movies = [NSKeyedUnarchiver unarchiveObjectWithData:undata];
    
    if (movies == nil)
    {
        _moviesArray = [NSMutableArray array];
    }
    else
    {
        _moviesArray = movies;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    NSMutableArray *discardArray = [NSMutableArray array];
    
    for (NSString *movieName in _moviesArray)
    {
        if ([movieName isEqualToString:@""])
        {
            [discardArray addObject:@""];
        }
    }
    
    [_moviesArray removeObjectsInArray:discardArray];
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:_moviesArray];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"movies"];
}

- (IBAction)addNewRow:(id)sender
{
    [_tableView setEditing:NO animated:YES];
    [_moviesArray insertObject:@"" atIndex:0];
    
    [_tableView beginUpdates];
    [_tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    [_tableView endUpdates];
    
    BPTableViewCell *cell = (BPTableViewCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [[cell movieName] becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}

#pragma mark UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView setEditing:YES animated:YES];
}

#pragma mark UITableViewDatasource methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SimpleTableIdentifier = @"cell";
    
    BPTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];

    if (cell == nil)
    {
        cell = [[BPTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SimpleTableIdentifier];
    }
    
    [[cell movieName] setText:[_moviesArray objectAtIndex:[indexPath row]]];
    [[cell movieName] setDelegate:self];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_moviesArray count];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [_moviesArray removeObjectAtIndex:[indexPath row]];
        
        [_tableView beginUpdates];
        [_tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [_tableView endUpdates];
    }
}

#pragma mark UITextFieldDelegate methods

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    for (NSString *movieTitle in _moviesArray)
    {
        if ([movieTitle isEqualToString:[textField text]])
        {
            editingIndex = [_moviesArray indexOfObject:movieTitle];
            break;
        }
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [_moviesArray replaceObjectAtIndex:editingIndex withObject:[textField text]];
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
