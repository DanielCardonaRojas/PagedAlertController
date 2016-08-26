//
//  PageContentViewController.m
//  PagedAlertController
//
//  Created by Daniel Cardona Rojas on 8/22/16.
//  Copyright © 2016 Daniel Cardona Rojas. All rights reserved.
//

#import "PageContentViewController.h"

@interface PageContentViewController ()

@end

@implementation PageContentViewController




#pragma mark - Custom Initializers

#pragma mark - View Lifecycle
-(void)viewDidLoad{
    [super viewDidLoad];
//    [self.prevButton addTarget:self action:@selector(tappedPrevButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.prevButton addTarget:self action:@selector(tappedPrevButton:) forControlEvents:UIControlEventTouchUpInside];
//    [self.nextButton addTarget:self action:@selector(tappedNextButton:) forControlEvents:UIControlEventTouchUpInside];
    
}



-(IBAction)tappedNextButton:(id)sender{
    UIButton* button = (UIButton*)sender;
    
    NSLog(@"tapped prev button in paged %@", [NSNumber numberWithInteger:button.tag]);
    
}
-(IBAction)tappedPrevButton:(id)sender{
    
    UIButton* button = (UIButton*)sender;
    NSLog(@"tapped prev button in paged %@", [NSNumber numberWithInteger:button.tag]);
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}





@end
