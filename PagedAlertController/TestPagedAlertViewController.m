//
//  TestPagedAlertViewController.m
//  PagedAlertController
//
//  Created by Daniel Cardona Rojas on 8/29/16.
//  Copyright © 2016 Daniel Cardona Rojas. All rights reserved.
//

#import "TestPagedAlertViewController.h"

@interface TestPagedAlertViewController ()

@end

@implementation TestPagedAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//     Get the new view controller using [segue destinationViewController].
//     Pass the selected object to the new view controller.
    PagedAlertViewController* pagedAlert = (PagedAlertViewController*)[segue destinationViewController];
    
    [pagedAlert setDelegate:self];
    [pagedAlert setDataSource:self];
}


- (IBAction)showPagedAlert:(id)sender {
    
    [self performSegueWithIdentifier:@"toPagedAlert" sender:self];
    
    
    
}


/*=================== DEFAULT/EXAMPLE IMPLEMENTATION DATASOURCE AND DELEGATE ============================= */


- (IBAction)openPagedViewController:(id)sender {
    
//    [self startPagedAlert];
    
    
}

#pragma mark - PagedAlertDataSource
//- (UIViewController *)viewControllerForPage:(NSUInteger)index{
//    PageContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentViewController"];
//    [pageContentViewController.view setBackgroundColor:[UIColor clearColor]];
//    [pageContentViewController.alertPageTitleLabel setText:@"ContentView"];
//    
//    return pageContentViewController;
//}

//View cell for alert page
-(UIView *)viewForAlertPage:(NSUInteger)index{
    CGRect frame = CGRectMake(25, 0, 250, 80);
    CGRect frame2 = CGRectMake(70, 100, 150, 40);
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 200)];
    
    
    UILabel* label = [[UILabel alloc]initWithFrame:frame];
    [label setClipsToBounds:NO];
    [label setNumberOfLines:3];
    NSString* innerText;
    
    switch (index) {
        case 0:
            innerText = @"Put any custom view in this area through the datasource protocol method viewForAlertPage";
            break;
        case 1:
            innerText = @"Change Title for each alert page through datasource method titleForPageAtIndex";
            break;
        case 2:
            innerText = @"Determine if should advance or not with delegate method (used to validate input)";
            break;
        case 3:
            innerText = @"Set number of pages in pagedAlert with datasource numberOfPagesForPagedAlertController";
            break;
        case 4:
            innerText = @"Can enable ciclyc navigation";
            break;
        case 5:
            innerText = @"Navigate through swipes or buttons";
            break;
            
        default:
            break;
    }
    
    
    [label setText:innerText];
    
    
    UITextField* textView = [[UITextField alloc]initWithFrame:frame2];
    [textView setDelegate:self];
    [textView setText:@"test"];
    [textView setTextColor:[UIColor blueColor]];
    [textView setClipsToBounds:YES];
    [textView setBackgroundColor:[UIColor redColor]];
    
    [view addSubview:label];
    [view addSubview:textView];
    [view setBackgroundColor:[UIColor yellowColor]];
    
    
    return view;
}

-(NSUInteger)numberOfPagesForPagedAlertController:(UIViewController *)pagedController{
    return 5;
}

-(NSString *)titleForPageAtIndex:(NSUInteger)index{
    NSString* title =  [NSString stringWithFormat:@"Pagina %lu",(unsigned long)index];
    
    return title;
}
-(BOOL)showsPageBullets{
    return YES;
}

-(BOOL)usesWrappAroundIndexing{
    return YES;
}



#pragma mark - PagedAlertDelegate

-(BOOL)pagedAlert:(UIView *)view shouldFlipToPreviousPageFromPage:(NSUInteger)integer submissionInfo:(NSDictionary *)info{
    NSLog(@"tapped prev button alertview test controller delegate",nil);
    return YES;
}

-(BOOL)pagedAlert:(UIView *)view shouldFlipToNextPageFromPage:(NSUInteger)integer submissionInfo:(NSDictionary *)info{
    NSLog(@"tapped next button alertview teste controller delegate",nil);
    
    return YES;
}

#pragma mark - UITextFieldDelegate


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSLog(@"textfield input: %@", string);
    return YES;
}

@end
