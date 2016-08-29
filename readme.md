#PagedAlertController

PagedAlertController presents a user defined view (300x200 by default) in a alert style modal, adding pages and bullets.

By itself in only adds navigating functionality, validation and content design is user defined.

# Usage

- Import files in Reusable components of xcode file group
- Create two view controller in story board assign to one them the PagedAlertController class.
- In the remaining view controller import PagedAlertController.h and implement protocols PagedAlertDelegate and PagedAlertDataSource.
- Make shure from the presenting viewcontroller or segue that the presentation style of the PagedAlertController is 'over current context'.


# Detailed Description of Protocols


```shell objective-c
@protocol PagedAlertDelegate <NSObject>

@optional
-(void)didTurnToPageAtIndex:(NSUInteger)pageIndex;
-(void)willStartPagedAlertController:(UIViewController*) pagedController;
-(BOOL)pagedAlert:(UIView*)view shouldFlipToNextPageFromPage:(NSUInteger)integer submissionInfo: (NSDictionary*)info;
-(BOOL)pagedAlert: (UIView*)view shouldFlipToPreviousPageFromPage:(NSUInteger)integer submissionInfo: (NSDictionary*)info;


-(void)willDismissPagedAlertController;
-(void)didDismissPagedAlertController;

@end

@protocol PagedAlertDataSource <NSObject>

-(NSUInteger)numberOfPagesForPagedAlertController: (UIViewController*) pagedController;
- (UIView *)viewForAlertPage:(NSUInteger)index;
-(NSString*)titleForPageAtIndex:(NSUInteger)index;


@optional
//Change these to properties?

-(BOOL)usesWrappAroundIndexing;
-(BOOL)showsPageBullets;


@end
```




# TODO

Disable swipe gesture of the UIPageController
Create a cocoapod once polished

Redifine or implement correctly 
-(BOOL)pagedAlert:(UIView*)view shouldFlipToNextPageFromPage:(NSUInteger)index submissionInfo: (NSDictionary*)info;
-(BOOL)pagedAlert:(UIView*)view shouldFlipToPreviousPageFromPage:(NSUInteger)index submissionInfo: (NSDictionary*)info;



