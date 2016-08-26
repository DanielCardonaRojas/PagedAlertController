//
//  ViewController.m
//  PagedAlertController
//
//  Created by Daniel Cardona Rojas on 8/22/16.
//  Copyright © 2016 Daniel Cardona Rojas. All rights reserved.
//

#import "PagedAlertViewController.h"
#import "PageContentViewController.h"
#import "PagedAlertView.h"



@interface PagedAlertViewController () <UIPageViewControllerDataSource,UIPageViewControllerDelegate, PagedAlertDelegate, PagedAlertDataSource>

//PageViewController Properties
@property (strong, nonatomic) UIPageViewController *pageViewController;

@property (nonatomic) NSInteger index;

@end

@implementation PagedAlertViewController



#pragma mark - Start AlertPagedController

-(void)startPagedAlert{
    [self addChildViewController:self.pageViewController];
//    [self.view addSubview:self.pageViewController.view];
    [self.view insertSubview:self.pageViewController.view atIndex:0];
    
    [self.pageViewController didMoveToParentViewController:self];
}

-(void)stopPagedAlert{
    [self.pageViewController removeFromParentViewController];
    [self.pageViewController.view removeFromSuperview];
    
}


#pragma mark - PageViewController Helpers
- (UIViewController *)viewControllerAtIndex:(NSInteger)index
{
    NSUInteger pageCount = [self numberOfPagesForPageViewController];
    BOOL usesWrapping = NO;
    if([self.delegate respondsToSelector:@selector(usesWrappAroundIndexing)]){
        usesWrapping = [self.dataSource usesWrappAroundIndexing];
    }
    
    if (pageCount == 0) {
        return nil;
    }
    
    if (!usesWrapping && (index < 0 || index >= pageCount)) {
        return nil;

    }
    
    if (usesWrapping) {
        NSUInteger numPages = [self numberOfPagesForPageViewController];
        index = index < 0 ? index + numPages : index;
        index %= numPages;
    }
    
    
    // Create a new view controller and pass suitable data.
    UIViewController* pageContent = [self.dataSource viewControllerForPage:index];
    self.index = index;
    
    return pageContent;
    
}

- (UIViewController *)contentPageControllerAtIndex:(NSInteger)index{
    
    NSUInteger pageCount = [self numberOfPagesForPageViewController];
    BOOL usesWrapping = NO;
    if([self.delegate respondsToSelector:@selector(usesWrappAroundIndexing)]){
        usesWrapping = [self.dataSource usesWrappAroundIndexing];
    }
    
    if (pageCount == 0) {
        return nil;
    }
    
    if (!usesWrapping && (index < 0 || index >= pageCount)) {
        return nil;
    }
    
    if (usesWrapping) {
        NSUInteger numPages = [self numberOfPagesForPageViewController];
        index = index < 0 ? index + numPages : index;
        index %= numPages;
    }
    
    
    // Create a new view controller page.
    UIViewController* pageContentController = [[UIViewController alloc]init];
    [pageContentController.view setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
    
    
    
    //Get inner content for alert view page and configure button actions, title etc.
    CGFloat width = self.view.frame.size.width;
   
    CGRect alertFrame = CGRectMake(width/2, 130, 300, 300);
    
    PagedAlertView* alertView = [[PagedAlertView alloc]initWithFrame:alertFrame];
    alertView.center = self.view.center;
    
    //Configure title
    
    if([self.dataSource respondsToSelector:@selector(titleForPageAtIndex:)]){
        NSString* title = [self.dataSource titleForPageAtIndex:index];
        [alertView.titleLabel setText:title];
        
    }
    
    
    [alertView.nextButton addTarget:self action:@selector(tappedNextButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [alertView.previousButton addTarget:self action:@selector(tappedPreviousButton:) forControlEvents:UIControlEventTouchUpInside];
    
    //TODO: Add user supplied content cell to alert page
    UIView* contentView = [self.dataSource viewForAlertPage:index];
    
    [alertView.innerContentView addSubview:contentView];

    [pageContentController.view addSubview:alertView];
    self.index = index;
    [self.pageControl setCurrentPage: self.index];
    
    return pageContentController;
}

#pragma mark - View lifecicle

- (void)viewDidLoad
{
    [super viewDidLoad];
    //Init variables
    self.index = 0;
    [self setAllowsSwipe:YES];
    //Create a page a view controller
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    
    //Default to self TODO: Check this works and doesnt affect real delegate controller
    [self.pageViewController setDataSource:self];
    [self.pageViewController setDelegate:self];
    
  
    // Create page view controller
//    UIViewController *startingViewController = [self viewControllerAtIndex:self.index];
    UIViewController *startingViewController = [self contentPageControllerAtIndex:self.index];
    
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    
    // Add a Page Control Indicator
    if([self.dataSource respondsToSelector:@selector(showsPageBullets)]){
        if ([self.dataSource showsPageBullets]) {
            [self.pageControl setNumberOfPages:[self numberOfPagesForPageViewController]];
            [self.pageControl setBackgroundColor:self.pageControlBackgroundColor];
            [self.pageControl setCurrentPageIndicatorTintColor:self.bulletColor];
            [self.view addSubview:self.pageControl];
            [self.pageControl setHidden:NO];
            
        }
        
    }else {
        [self.pageControl setHidden:YES];
    }
    [self.pageControl setCurrentPage:self.index];
    
    //Modify View appearance
    UIColor* transparentColor = [UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0];
    
    [self.pageViewController.view setBackgroundColor:transparentColor];

    
    [self startPagedAlert];
    
}

#pragma mark - PageController Actions 
-(void)moveToNextPage{
//    [self viewControllerAtIndex:self.index + 1];
    UIViewController* nextPage = [self contentPageControllerAtIndex:self.index + 1];
    [self.pageViewController setViewControllers:@[nextPage] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
}

-(void)moveToPreviousPage{
//    [self viewControllerAtIndex:self.index - 1];
    UIViewController* prevPage = [self contentPageControllerAtIndex:self.index - 1];
    [self.pageViewController setViewControllers:@[prevPage] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
}

-(void)moveToPageAtIndex:(NSUInteger)idx{
    
//    [self viewControllerAtIndex:idx];
    
}

#pragma mark - Lazy Instantiation. If no pageControl is hooked up then create a default one
-(UIPageControl *)pageControl{
    if (!_pageControl) {
        CGRect frame = CGRectMake(self.view.frame.size.width*0.25, self.view.frame.size.height*0.8, self.view.frame.size.width*0.5, self.view.frame.size.height*0.05);
        
        _pageControl = [[UIPageControl alloc]initWithFrame:frame];        
        [_pageControl setCurrentPage:0];
    }
    
    return _pageControl;
}

-(id<PagedAlertDataSource>)dataSource{
    if(!_dataSource){
        _dataSource = self;
    }
    return _dataSource;
}

-(id<PagedAlertDelegate>)delegate{
    if(!_delegate){
        _delegate = self;
    }
    return _delegate;
}

-(UIColor*)bulletColor{
    if(!_bulletColor){
        _bulletColor = [UIColor whiteColor];
    }
    return _bulletColor;
}



-(UIColor*)pageControlBackgroundColor{
    if(!_pageControlBackgroundColor){
        _pageControlBackgroundColor = [UIColor clearColor];
    }
    return _pageControlBackgroundColor;
}

#pragma mark - UIPageViewController Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    if (self.allowsSwipe) {
        self.index -= 1;
    }
    NSLog(@"viewcontroller before viewcontroller");
    
//    UIViewController* page = [self viewControllerAtIndex:self.index];
    UIViewController* page = [self contentPageControllerAtIndex:self.index];
    return page;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    if(self.allowsSwipe){
        self.index += 1;
    }
    NSLog(@"viewcontroller after viewcontroller");
//    UIViewController* page = [self viewControllerAtIndex:self.index];
    UIViewController* page = [self contentPageControllerAtIndex:self.index];
    return page;
}


#pragma mark - UIPageViewControllerDelegate
-(void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed{
    
    if (!completed) {
        return;
    }
    
    
    [self.pageControl setCurrentPage:self.index];
    
    if([self.delegate respondsToSelector:@selector(didTurnToPageAtIndex:)]){
        [self.delegate didTurnToPageAtIndex:self.index];
    }
    
}


-(NSUInteger)numberOfPagesForPageViewController{
    return [self.dataSource numberOfPagesForPagedAlertController:self];
}


#pragma mark - IBActions

//TODO: Notify delegate when buttons get tapped passing index

-(IBAction)tappedNextButton:(id)sender{
    
    if([self.delegate respondsToSelector:@selector(didTapNextPageButttonWithSubmissionInfo:)]){
        [self.delegate didTapNextPageButttonWithSubmissionInfo:nil];
    }
    
}

-(IBAction)tappedPreviousButton:(id)sender{
    
    if([self.delegate respondsToSelector:@selector(didTapPreviousPageButttonWithSubmissionInfo:)]){
        [self.delegate didTapPreviousPageButttonWithSubmissionInfo:nil];
    }
    
}


/*=================== DEFAULT/EXAMPLE IMPLEMENTATION DATASOURCE AND DELEGATE ============================= */


- (IBAction)openPagedViewController:(id)sender {
    
    [self startPagedAlert];
    
    
}

#pragma mark - PagedAlertDataSource
- (UIViewController *)viewControllerForPage:(NSUInteger)index{
    PageContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentViewController"];
    [pageContentViewController.view setBackgroundColor:[UIColor clearColor]];
    [pageContentViewController.alertPageTitleLabel setText:@"ContentView"];    
    
    return pageContentViewController;
}

//View cell for alert page
-(UIView *)viewForAlertPage:(NSUInteger)index{
    CGRect frame = CGRectMake(0, 0, 50, 20);
    CGRect frame2 = CGRectMake(0, 20, 100, 60);
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 200)];
    
    
    UILabel* label = [[UILabel alloc]initWithFrame:frame];
    
    [label setText:@"hola"];
    
    UITextField* textView = [[UITextField alloc]initWithFrame:frame2];
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

-(void)didTapNextPageButttonWithSubmissionInfo:(NSDictionary *)info{
    //If Info test succeeds
    NSLog(@"tapped next button alertview delegate",nil);
    //Advance to next page
    [self moveToNextPage];
    //Stop alertpaged presentation or freeze at current page?
    
}


-(void)didTapPreviousPageButttonWithSubmissionInfo:(NSDictionary *)info{
    //If Info test succeeds
    NSLog(@"tapped prev button alertview delegate",nil);
    //Advance to next page
    [self moveToPreviousPage];
    //Stop alertpaged presentation or freeze at current page?
    
}








@end
