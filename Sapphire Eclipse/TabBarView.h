//
//  TabBarView.h
//  TheHomeDepot
//
//  Created by The Home Depot on 7/22/10.
//  Copyright 2010 The Home Depot, Inc. All rights reserved.
//



#import <UIKit/UIKit.h>

@class TabbarItem;

@interface TabBarView : UIView <UIScrollViewDelegate> {
	UIView *baseView;
	NSMutableArray *mTabbarItemsArray;
	UIScrollView *mTabBarScrollView;
	UIView *tabBarViewl;
	UIViewController *currentViewController;
	NSString *currentTabItemTitle;
	
	int mNOFItems;
	float mTabbar_X;
	float mTabbar_Y;
	UIImageView *mRightArrowImageView;
	UIImageView *mLeftArrowImageView;
	NSTimeInterval lastTouch;
	int lastButtonPressed;
	UIView *aRightArrowView;
	UIView *aLeftArrowView;
	
}
@property (nonatomic, retain) UIView *baseView;
//array to store tabbar items
@property (nonatomic, retain) NSMutableArray *mTabbarItemsArray;
//scroll view for buttons
@property (nonatomic, retain) UIScrollView *mTabBarScrollView;
//this is the view for the tabbar
@property (nonatomic, retain) UIView *tabBarViewl;
//this is selected view controller
@property (nonatomic,retain) UIViewController *currentViewController;
//current Tab item title
@property (nonatomic,retain) NSString *currentTabItemTitle;

- (void) addtoScrollView:(int)aIndex;
///tab bar action
- (void) btnPressed:(UIButton *)sender;
///to update the button state like normal,selected,highlighted
- (void) updateButtonState:(int)aIndex;
///to add tab bar items to the tab bar
- (void) addTabBaritems:(TabbarItem *)aTabbarItem;
//-(void)doubleCLickCheck;

/**
 @defines to return the view controller depends on index
 */
- (UIViewController *) getViewControllerAtIndex:(int)aIndex;
- (void) selectTabBar:(int)aIndex;


@end
