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


