//
//  TabbarItem.m
//  TheHomeDepot
//
//  Created by The Home Depot on 7/22/10.
//  Copyright 2010 The Home Depot, Inc. All rights reserved.
//



#import "TabbarItem.h"


@implementation TabbarItem

@synthesize mTabbarButton,mViewController,isViewAdded,mNormalIcon,mSelectedIcon,mTabbarBG,tabTitle, currentState;
/**
 @brief Initializes the view with the frame rect
 */
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
		
		mTabbarButton =[UIButton buttonWithType:UIButtonTypeCustom];
		mTabbarButton.frame =frame;
		[self addSubview:mTabbarButton];
		
		
    }
    return self;
}
//set the bg for the tabbar items
-(void)setTabBarBG:(NSString *)aBG
{
	mTabbarBG = [[UIImage imageNamed:aBG] retain];
	[mTabbarButton setBackgroundImage:mTabbarBG forState:UIControlStateNormal];	
}
//set the icon image for the tab bar item
-(void)setIcon:(NSString *)aNormalIcon selectesIcon:(NSString *)aSelectedIcon
{
	mNormalIcon = [[UIImage imageNamed:aNormalIcon] retain];
	mSelectedIcon = [[UIImage imageNamed:aSelectedIcon] retain];
    [mTabbarButton setImage:mNormalIcon forState:UIControlStateNormal];
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
}
//to set the title of tabbar items
-(void)Settitle:(NSString *)aTitle
{
	tabTitle = aTitle;
}
//set the frame of the tab bar items
-(void)setframe:(CGRect)aRect
{
	[mTabbarButton setFrame:aRect];
}
-(void)setTag:(int)aTag
{
	[mTabbarButton setTag:aTag];
}
//set the viewcontroller for the tab  bar
-(void)setUiviewController:(UIViewController *)aController
{
	mViewController = aController;
}
//to get the tab bar button
-(UIButton *)getButton
{
	return mTabbarButton;
}

- (void)updateState:(TabBarButtonState)buttonState
{
	self.currentState = buttonState;
	switch (buttonState) {
		case TabBarButtonStateNormal:
		{
			[self.mTabbarButton setImage:self.mSelectedIcon forState:UIControlStateNormal];
			[self.mTabbarButton setImage:self.mSelectedIcon forState:UIControlStateHighlighted];
		}
			break;
		case TabBarButtonStateHighlighted:
		{
			[self.mTabbarButton setImage:self.mNormalIcon forState:UIControlStateNormal];
			[self.mTabbarButton setBackgroundImage:nil forState:UIControlStateNormal];
			[self.mTabbarButton setBackgroundImage:nil forState:UIControlStateHighlighted];
			
		}
			break;

		default:
			break;
	}
	
}

- (void)dealloc {
    [super dealloc];
}



@end
