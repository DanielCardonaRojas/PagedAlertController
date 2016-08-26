//
//  PageContentViewController.h
//  PagedAlertController
//
//  Created by Daniel Cardona Rojas on 8/22/16.
//  Copyright © 2016 Daniel Cardona Rojas. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ContentPageDelegate <NSObject>

@optional
-(void)didTapNextPageButttonWithSubmissionInfo:(NSDictionary*)info;
-(void)didTapPreviousPageButttonWithSubmissionInfo:(NSDictionary*)info;

@end


@interface PageContentViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (weak, nonatomic) IBOutlet UILabel *alertPageTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *alertPageTopMessageLabel;
@property NSUInteger pageIndex;
@property (weak, nonatomic) IBOutlet UIButton *prevButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (strong,nonatomic) id<ContentPageDelegate> delegate;


@end
