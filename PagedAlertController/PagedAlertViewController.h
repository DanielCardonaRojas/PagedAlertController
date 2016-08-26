//
//  ViewController.h
//  PagedAlertController
//
//  Created by Daniel Cardona Rojas on 8/22/16.
//  Copyright © 2016 Daniel Cardona Rojas. All rights reserved.
//
/*
 
 
 */

#import <UIKit/UIKit.h>
#import "PageContentViewController.h"
/*
 This Viewcontroller provides a Alert like mixed with a uipage controller.With a transparent
 background. All View have a next and previous button a title and an area for a custom view to be 
 displayed. 
 
 Bullets can be displayed or not.
 
 TODO:
 
 choose between viewControllerForPage or viewForAlertPage methods
 the advatnage of implementing the later is that only views need to be passed.
 
 
*/
//TODO: Subclass UIViewController and change respective protocol method parameters
@protocol PagedAlertDelegate <NSObject>

@optional
-(void)didTurnToPageAtIndex:(NSUInteger)pageIndex;
-(void)willStartPagedAlertController:(UIViewController*) pagedController;
-(void)didTapNextPageButttonWithSubmissionInfo:(NSDictionary*)info;
-(void)didTapPreviousPageButttonWithSubmissionInfo:(NSDictionary*)info;


@end

@protocol PagedAlertDataSource <NSObject>

-(NSUInteger)numberOfPagesForPagedAlertController: (UIViewController*) pagedController;
//Has to be a viewcontroller with a property pageIndex or try to get rid of the page index
//- (PageContentViewController *)viewControllerForPage:(NSUInteger)index;

- (UIViewController *)viewControllerForPage:(NSUInteger)index;
-(NSString*)titleForPageAtIndex:(NSUInteger)index;




@optional
- (UIView *)viewForAlertPage:(NSUInteger)index;

-(BOOL)usesWrappAroundIndexing;
-(BOOL)showsPageBullets;







@end




@interface PagedAlertViewController : UIViewController

-(void)startPagedAlert;
-(void)stopPagedAlert;
-(void)moveToPageAtIndex:(NSUInteger)idx;
-(void)moveToNextPage;
-(void)moveToPreviousPage;

@property (strong,nonatomic) UIColor* bulletColor;
@property (strong,nonatomic) UIColor* pageControlBackgroundColor;
@property (strong,nonatomic) UIPageControl* pageControl;
@property BOOL allowsSwipe;

@property (weak,nonatomic) id<PagedAlertDelegate> delegate;
@property (weak,nonatomic) id<PagedAlertDataSource> dataSource;

@end
