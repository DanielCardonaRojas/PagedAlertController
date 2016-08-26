//
//  RootViewController.m
//  PagedAlertController
//
//  Created by Daniel Cardona Rojas on 8/23/16.
//  Copyright © 2016 Daniel Cardona Rojas. All rights reserved.
//

#import "RootViewController.h"
#import "PageContentViewController.h"

@interface RootViewController ()
@property (strong, nonatomic) IBOutlet UIPageControl *customPageControl;
@property (strong, atomic) PagedAlertViewController* pagedAlert;
@property (strong, atomic) PageContentViewController* pageContentViewController;

@end

@implementation RootViewController

-(void)viewDidLoad{
    [super viewDidLoad];

}


- (IBAction)openPagedViewController:(id)sender {
   
    self.pagedAlert =[[PagedAlertViewController alloc]init];
    [self.pagedAlert setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    [self.pagedAlert setDelegate:self];
    [self.pagedAlert setDataSource:self];
//    [pagedAlert setBulletColor:[UIColor yellowColor]];
//    [pagedAlert setPageControlBackgroundColor:[UIColor redColor]];
//    [pagedAlert setPageControl:self.customPageControl];
    [self presentViewController:self.pagedAlert animated:YES completion:nil];
    
    
}

#pragma mark - ContentPageDelegate

-(void)didTapNexPageButtonWithSubmissionInfo:(NSDictionary*)info{
    //If Info test succeeds
    
    //Advance to next page
    [self.pagedAlert moveToNextPage];
    
    //Stop alertpaged presentation or freeze at current page?
    
}


-(void)didTapPrevPageButtonWithSubmissionInfo:(NSDictionary*)info{
    //If Info test succeeds
    
    //Advance to next page
    [self.pagedAlert moveToPreviousPage];
    
    //Stop alertpaged presentation or freeze at current page?
    
}

#pragma mark - PagedAlertDataSource
- (UIViewController *)viewControllerForPage:(NSUInteger)index{
    NSString* pageNumber = [[NSNumber numberWithInteger:index] stringValue];
    NSString* pageTitle = [NSString stringWithFormat:@"Page Number %@", pageNumber];
    
    //TODO: Reuse, avoid instantiating every single time.
    _pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentViewController"];
    
    [_pageContentViewController.alertPageTitleLabel setText: pageTitle];
    [_pageContentViewController setDelegate:self];
    [_pageContentViewController.prevButton setTag:index];

    
    
    return _pageContentViewController;
}

-(UIView *)viewForAlertPage:(NSUInteger)index{
    UITextField* textField = [[UITextField alloc] init];
    
    return textField;
}



-(NSUInteger)numberOfPagesForPagedAlertController:(UIViewController *)pagedController{
    return 3;
}

-(BOOL)usesWrappAroundIndexing{
    return YES;
}

-(BOOL)showsPageBullets{
    return YES;
}



#pragma mark - PagedAlertDelegate





@end
