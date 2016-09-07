//
//  DifusionViewController.m
//  PagedAlertController
//
//  Created by Daniel Cardona Rojas on 9/7/16.
//  Copyright © 2016 Daniel Cardona Rojas. All rights reserved.
//

#import "DifusionViewController.h"
#import "SocialPageView.h"

@interface DifusionViewController ()

@end

@implementation DifusionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
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

#pragma mark - PagedAlertDataSource

//View cell for alert page
-(UIView *)viewForAlertPage:(NSUInteger)index{
    
    
    SocialPageView* social = (SocialPageView*)[[[NSBundle mainBundle] loadNibNamed:@"SocialPageView" owner:self options:nil] firstObject];
    
        
    [social.facebookButton addTarget:self action:@selector(didTapFacebookButton:) forControlEvents:UIControlEventTouchUpInside];
    [social.twitterButton addTarget:self action:@selector(didTapTwitterButton:) forControlEvents:UIControlEventTouchUpInside];
    [social.whatsappButton addTarget:self action:@selector(didTapWhatsappButton:) forControlEvents:UIControlEventTouchUpInside];
    
    
    if(index == 0){
        [social.messageLabel setText:@"Queremos saber que te ha parecido Filapp"];
        [social.facebookButton setHidden:YES];
        [social.twitterButton setHidden:YES];
        [social.whatsappButton setHidden:YES];
    }
    
    if(index == 1){
        [social.messageLabel setText:@"Regalale Filapp a tus seres queridos"];
    }
    return  social;

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
    return 2;
}

-(NSString *)titleForPageAtIndex:(NSUInteger)index{
    NSString* title = [NSString stringWithFormat:@"Pagina %lu",(unsigned long)index];
    
    switch (index) {
        case 0:
            title = @"Danos tu opinion";
            break;
        case 1:
            title = @"Cuentale a otros";
            break;
            
        default:
            break;
    }
    
    return title;
}

-(NSArray *)pagedAlertControllerButtonTitles{
    
    NSArray* array = @[@"No me gusto",@"Si me gusto",@"Anterior",@"Finalizar"];
    
    return array;
}
-(BOOL)showsPageBullets{
    return YES;
}

-(BOOL)usesWrappAroundIndexing{
    return NO;
}

-(BOOL)allowsSwipe{
    return NO;
}




#pragma mark - PagedAlertDelegate

-(void)didDismissPagedAlertControllerAtIndex:(NSUInteger)index{
    
}

-(BOOL)pagedAlert:(UIView *)view shouldFlipToPreviousPageFromPage:(NSUInteger)integer{
    
    NSLog(@"tapped prev button alertview test controller delegate",nil);
    return YES;
}

-(BOOL)pagedAlert:(UIView *)view shouldFlipToNextPageFromPage:(NSUInteger)integer{
    NSLog(@"tapped next button alertview teste controller delegate",nil);
    
    return YES;
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
