//
//  BPMainViewController.m
//  MovieShuffle
//
//  Created by Justin C. Beck on 2/1/14.
//  Copyright (c) 2014 BeckProduct. All rights reserved.
//

#import "BPMainViewController.h"

@interface BPMainViewController ()

@end

@implementation BPMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(BPFlipsideViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        [[segue destinationViewController] setDelegate:self];
    }
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake)
    {
        NSData *undata = [[NSUserDefaults standardUserDefaults] objectForKey:@"movies"];
        NSMutableArray *movies = [NSKeyedUnarchiver unarchiveObjectWithData:undata];
        
        int index = arc4random_uniform([movies count]);
        NSString *movieName = [movies objectAtIndex:index];
        
        [self showAlert:movieName];
    } 
}

-(void)showAlert:(NSString *)movieName
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"You Chose:" message:[NSString stringWithFormat:@"%@", movieName] delegate:nil cancelButtonTitle:@"Awesome" otherButtonTitles:nil];
    
    [alertView show];
}

@end
