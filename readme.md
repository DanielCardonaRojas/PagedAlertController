#PagedAlertController

PagedAlertController presents a user defined view (300x200 by default) in a alert style modal, adding pages and bullets.

By itself in only adds navigating functionality, validation and content design is user defined.

# Usage

- Import files in Reusable components of xcode file group
- Create two view controller in story board assign to one them the PagedAlertController class.
- In the remaining view controller import PagedAlertController.h and implement protocols PagedAlertDelegate and PagedAlertDataSource.
- Make shure from the presenting viewcontroller or segue that the presentation style of the PagedAlertController is 'over current context'.


# Detailed Description of Protocols


``` objective-c
@protocol PagedAlertDelegate <NSObject>

@optional
-(void)pagedAlert: (UIView*)view didTurnToPageAtIndex:(NSUInteger)pageIndex;
-(void)willStartPagedAlertController:(UIViewController*) pagedController;
-(BOOL)pagedAlert:(UIView*)view shouldFlipToNextPageFromPage:(NSUInteger)integer;
-(BOOL)pagedAlert: (UIView*)view shouldFlipToPreviousPageFromPage:(NSUInteger)integer;


//TODO: especify page index where this happens
-(void)willDismissPagedAlertControllerAtIndex:(NSUInteger)index;
-(void)didDismissPagedAlertControllerAtIndex:(NSUInteger)index;

@end

@protocol PagedAlertDataSource <NSObject>

-(NSUInteger)numberOfPagesForPagedAlertController: (UIViewController*) pagedController;
- (UIView *)viewForAlertPage:(NSUInteger)index;

-(NSString*)titleForPageAtIndex:(NSUInteger)index;


-(BOOL)allowsSwipe;


@optional
//Change these to properties?

// not usigin wrap around indexing means the PagedViewController will be dismissed if tapping the previous button on first page
//or the next button on final page.
-(BOOL)usesWrappAroundIndexing;
-(BOOL)showsPageBullets;
//Used to validate input
-(UIView*)updateViewOnPageFlipForwardRejection:(UIView*)view pageIndex:(NSUInteger)index;
-(UIView*)updateViewOnPageFlipBackwardRejection:(UIView*)view pageIndex:(NSUInteger)index;
//An array of strings indicating the button titles for each page (should have equal length to number of pages)
-(NSArray*)pagedAlertControllerButtonTitles;

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


@property (weak,nonatomic) id<PagedAlertDelegate> delegate;
@property (weak,nonatomic) id<PagedAlertDataSource> dataSource;

@end

```

# TODO

- Disable swipe gesture of the UIPageController
- Create a cocoapod once polished

- Redifine or implement correctly 

```objective-c
-(BOOL)pagedAlert:(UIView*)view shouldFlipToNextPageFromPage:(NSUInteger)index submissionInfo: (NSDictionary*)info;
-(BOOL)pagedAlert:(UIView*)view shouldFlipToPreviousPageFromPage:(NSUInteger)index submissionInfo: (NSDictionary*)info;
```

- Make UITapGestureRecognizer dismiss the PagedAlertController when tapped on outer area.
- Remove UIPageViewController bounce
- Define constraints on PageAlertView xib

- FIX: Views added throught storyboard dont get centered in container (innerContentView e.g page 6) but views added programatically do. 


