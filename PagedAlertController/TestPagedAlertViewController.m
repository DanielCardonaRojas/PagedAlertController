//
//  TestPagedAlertViewController.m
//  PagedAlertController
//
//  Created by Daniel Cardona Rojas on 8/29/16.
//  Copyright © 2016 Daniel Cardona Rojas. All rights reserved.
//

#import "TestPagedAlertViewController.h"
#import "SocialPageView.h"

@interface TestPagedAlertViewController ()
@property (strong, nonatomic) IBOutlet UIView *alertContentView;
@property (weak, nonatomic) IBOutlet UILabel *alertContentLabel;
@property BOOL shouldAdvancePage;

@end

@implementation TestPagedAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.alertContentView setHidden:YES];
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

- (IBAction)pagedAlertFacebookTapped:(id)sender {
    
    NSLog(@"tapped facebook button");
}

/*=================== DEFAULT/EXAMPLE IMPLEMENTATION DATASOURCE AND DELEGATE ============================= */


- (IBAction)openPagedViewController:(id)sender {
    
//    [self startPagedAlert];
    
    
}

#pragma mark - PagedAlertDataSource

//View cell for alert page
-(UIView *)viewForAlertPage:(NSUInteger)index{
    
    [self.alertContentView setHidden:YES];
    CGRect frame = CGRectMake(25, 0, 250, 80);
    CGRect frame2 = CGRectMake(70, 100, 150, 40);
    CGRect frame3 = CGRectMake(70, 140, 150, 40);
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 200)];
    
    
    UILabel* label = [[UILabel alloc]initWithFrame:frame];
    UILabel* validationLabel = [[UILabel alloc]initWithFrame:frame3];
    [validationLabel setTag:3];
    [validationLabel setHidden:NO];
    [label setClipsToBounds:NO];
    [label setNumberOfLines:4];
    NSString* innerText = @"";

    
    switch (index) {
        case 0:
            innerText = @"Put any custom view in this 300x200 area through the datasource protocol method viewForAlertPage";
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
        
        case 6:
            innerText = @"Add view programmatically or configuring the view in the presenting view controller.";
            break;
            
        default:
            break;
    }
    
    
    [label setText:innerText];
    
    
    
    UITextField* textView = [[UITextField alloc]initWithFrame:frame2];
    [textView setDelegate:self];
    [textView setPlaceholder:@"Type anything"];
    [textView setTextColor:[UIColor blueColor]];
    [textView setClipsToBounds:YES];
    [textView setBackgroundColor:[UIColor redColor]];
    
    [view addSubview:label];
    [view addSubview:textView];
    [view addSubview:validationLabel];
    [view setBackgroundColor:[UIColor lightGrayColor]];
    
    if (index == 6) {
        
        SocialPageView* social = (SocialPageView*)[[[NSBundle mainBundle] loadNibNamed:@"SocialPageView" owner:self options:nil] firstObject];
        
        [social.facebookButton addTarget:self action:@selector(didTapFacebookButton:) forControlEvents:UIControlEventTouchUpInside];
        [social.twitterButton addTarget:self action:@selector(didTapTwitterButton:) forControlEvents:UIControlEventTouchUpInside];
        [social.whatsappButton addTarget:self action:@selector(didTapWhatsappButton:) forControlEvents:UIControlEventTouchUpInside];
        return  social;
        
    }
    
    return view;
}

-(UIView *)updateViewOnPageFlipForwardRejection:(UIView *)view pageIndex:(NSUInteger)index{
    
    for (UIView *i in view.subviews){
        if([i isKindOfClass:[UILabel class]]){
            UILabel *newLbl = (UILabel *)i;
            if(newLbl.tag == 3){
                [newLbl setText:@"Wrong input"];
            }
        }
    }
    
    return view;
}

-(NSUInteger)numberOfPagesForPagedAlertController:(UIViewController *)pagedController{
    return 7;
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

-(BOOL)allowsSwipe{
    return NO;
}




#pragma mark - PagedAlertDelegate

-(BOOL)pagedAlert:(UIView *)view shouldFlipToPreviousPageFromPage:(NSUInteger)integer{
    
    NSLog(@"tapped prev button alertview test controller delegate",nil);
    return YES;
}

-(BOOL)pagedAlert:(UIView *)view shouldFlipToNextPageFromPage:(NSUInteger)integer{
    NSLog(@"tapped next button alertview teste controller delegate",nil);
    
    self.shouldAdvancePage = YES;
    return self.shouldAdvancePage;
}

-(void)pagedAlert:(UIView *)view didTurnToPageAtIndex:(NSUInteger)pageIndex{
    //
    if([view isKindOfClass:[SocialPageView class]]){
        NSLog(@"did turn to social page");
        
    }
}

#pragma mark - UITextFieldDelegate


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString* fullText = [textField.text stringByAppendingString:string];
    NSLog(@"textfield input: %@", fullText);
    
    
    return YES;
}

#pragma mark - Target Selectors
-(void) didTapFacebookButton:(id)sender{
    NSLog(@"tapped facebook button");
    
    
}

-(void)didTapTwitterButton:(id)sender{
    NSLog(@"tapped twitter button");
    
}

-(void)didTapWhatsappButton:(id)sender{
    
    NSLog(@"tapped whatsapp button");
}

@end
