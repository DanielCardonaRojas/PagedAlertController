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
/* -------------------------- DELEGATE ------------------------- */
@protocol PagedAlertDelegate <NSObject>

@optional
-(void)pagedAlert: (UIView*)view didTurnToPageAtIndex:(NSUInteger)pageIndex;
-(void)willStartPagedAlertController:(UIViewController*) pagedController;
-(BOOL)pagedAlert:(UIView*)view shouldFlipToNextPageFromPage:(NSUInteger)integer;
-(BOOL)pagedAlert: (UIView*)view shouldFlipToPreviousPageFromPage:(NSUInteger)integer;


//TODO: especify page index where this happens
-(void)willDismissPagedAlertControllerAtIndex:(NSUInteger)index;
-(void)didDismissPagedAlertControllerAtIndex:(NSUInteger)index;


-(BOOL)shouldReversePreviousButtonLayout:(NSUInteger)index;
-(BOOL)shouldReverseNextButtonLayout:(NSUInteger)index;

@end

/* -------------------------- DATA SOURCE ------------------------- */
@protocol PagedAlertDataSource <NSObject>

-(NSUInteger)numberOfPagesForPagedAlertController: (UIViewController*) pagedController;

//TODO: generalize so the PagedAertView can have a varying size viewForAlertPage:(NSInteger)index contentDimension:(CGRect) frame;
- (UIView *)viewForAlertPage:(NSUInteger)index;

-(NSString*)titleForPageAtIndex:(NSUInteger)index;


-(BOOL)allowsSwipe;


@optional
//Change these to properties?

// Not usigin wrap around indexing means the PagedViewController will be dismissed if tapping the previous button on first page
//or the next button on final page.
-(BOOL)usesWrappAroundIndexing;
-(BOOL)showsPageBullets;
//Used to validate input
-(UIView*)updateViewOnPageFlipForwardRejection:(UIView*)view pageIndex:(NSUInteger)index;
-(UIView*)updateViewOnPageFlipBackwardRejection:(UIView*)view pageIndex:(NSUInteger)index;
-(UIColor*)titleColorForPageAtIndex:(NSUInteger)index;
//An array of strings indicating the button titles for each page (should have equal length to number of pages)
-(NSArray*)pagedAlertControllerButtonTitles;
-(NSArray*)pagedAlertControllerButtonIcons;

@end

/* -------------------------- INTERFACE ------------------------- */
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

- Create a cocoapod once polished
- Make UITapGestureRecognizer dismiss the PagedAlertController when tapped on outer area.
- Remove UIPageViewController bounce
- Define constraints on PageAlertView xib
- Generalize content view data source method so a PagedAlertController of any size may be constructed.
- Add other visual options like chosing a blurred background etc.
- FIX: BUtton user interaction area gets reduced when an icon is added to the button.
- FIX: Views added throught storyboard dont get centered in container (innerContentView e.g page 6) but views added programatically do. 


