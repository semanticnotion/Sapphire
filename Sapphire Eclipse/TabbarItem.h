//
//  TabbarItem.h
//  TheHomeDepot
//
//  Created by The Home Depot on 7/22/10.
//  Copyright 2010 The Home Depot, Inc. All rights reserved.
//



#import <Foundation/Foundation.h>

typedef enum
{
	TabBarButtonStateNormal,
	TabBarButtonStateHighlighted
}TabBarButtonState;
@interface TabbarItem : UIView {
	
	UIViewController *mViewController;
	
	UIView *mTabbarView;
	
	UIButton *mTabbarButton;
	
	NSString *tabTitle;
	
	UIImage *mNormalIcon;
	
	UIImage *mSelectedIcon;
	
	UIImage *mTabbarBG;
	
	BOOL isViewAdded;
	
	TabBarButtonState currentState;
}
///button for the tabbar item
@property(nonatomic,retain)UIButton *mTabbarButton;
///view controller for the tabbar item
@property(nonatomic,retain)UIViewController *mViewController;
///defines the normal icon for tabbar item
@property(nonatomic,retain)UIImage *mNormalIcon;
///defines the selected icon for tabbar item
@property(nonatomic,retain)UIImage *mSelectedIcon;
//background image for the tabbar item
@property(nonatomic,retain)UIImage *mTabbarBG;
//tab item title
@property(nonatomic,retain)NSString *tabTitle;

//defines whether tab view is added or not
@property(nonatomic)BOOL isViewAdded;
@property(nonatomic)TabBarButtonState currentState;

-(void)setTabBarBG:(NSString *)aBG;
-(void)setIcon:(NSString *)aNormalIcon selectesIcon:(NSString *)aSelectedIcon;
-(void)Settitle:(NSString *)aTitle;
-(void)setframe:(CGRect)aRect;
-(void)setTag:(int)aTag;
-(void)setUiviewController:(UIViewController *)aController;
-(void)updateState:(TabBarButtonState)buttonState;
-(UIButton *)getButton;


@end
