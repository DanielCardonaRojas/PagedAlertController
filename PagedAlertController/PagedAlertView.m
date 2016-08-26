//
//  PagedAlertView.m
//  PagedAlertController
//
//  Created by Daniel Cardona Rojas on 8/25/16.
//  Copyright © 2016 Daniel Cardona Rojas. All rights reserved.
//

#import "PagedAlertView.h"

@interface PagedAlertView ()
@property (weak,nonatomic) UIView* innerview;



@end

@implementation PagedAlertView



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //Initialization code
//        [self.innerContentView addSubview: self.innerContent];
        [self setup];
        
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)setup{
    self.innerview = [self loadFromNib];
    self.innerview.frame = self.bounds;
    self.innerview.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.innerview.layer setCornerRadius:20.0f];
    
    [self addSubview:_innerview];
    
    
}
-(UIView*)loadFromNib{
    NSBundle* bundle = [NSBundle bundleForClass:[self class]];
    UINib* nib = [UINib nibWithNibName:@"PagedAlertView" bundle:bundle];
    UIView* view = [[nib instantiateWithOwner:self options:nil] firstObject];
    return view;
}

@end
