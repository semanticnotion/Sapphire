//
//  TabBarView.m
//  TheHomeDepot
//
//  Created by The Home Depot on 7/22/10.
//  Copyright 2010 The Home Depot, Inc. All rights reserved.
//



#import "TabBarView.h"
#import "TabbarItem.h"
#import "TheHomeDepotAppDelegate.h"
#import "Tag.h"
#import "AnalyticsManager.h"
#import "CommerceBrowserViewController.h"

@implementation TabBarView

@synthesize baseView;
@synthesize mTabbarItemsArray;
@synthesize mTabBarScrollView;
@synthesize tabBarViewl;
@synthesize currentViewController;
@synthesize currentTabItemTitle;

/**
 @brief Initializes the view with the frame rect
 */
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {

        // Initialization code
		tabBarViewl = [[UIView alloc]initWithFrame:CGRectMake(0, 1, 320, 480)];
		[self addSubview:tabBarViewl];
		baseView = [[UIView alloc] initWithFrame:CGRectMake(0, 432, 320, 49)];

		mTabBarScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 49)];
		[mTabBarScrollView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg-nav.png"]]];
		UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 49)];
		toolbar.barStyle = UIBarStyleBlack;
		//[baseView addSubview:toolbar];
		[toolbar release];
		 
		[baseView addSubview:mTabBarScrollView];
		
		mTabBarScrollView.delegate = self;
		
		aRightArrowView =[ [UIView alloc] initWithFrame:CGRectMake(300, 0, 20, 49)];
		aLeftArrowView =[ [UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 49)];
		
		UIButton *leftArrowButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[leftArrowButton setFrame:CGRectMake(0,0, 20, 49)];
		[leftArrowButton addTarget:self action:@selector(leftArrowButtonPressed) forControlEvents:UIControlEventTouchUpInside];
		
		UIButton *rightArrowButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[rightArrowButton setFrame:CGRectMake(0,0, 20, 49)];
		[rightArrowButton addTarget:self action:@selector(rightArrowButtonPressed) forControlEvents:UIControlEventTouchUpInside];
	
		mLeftArrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow-left-navtab.png"]];
		mRightArrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow-right-navtab.png"]];
		
		[aRightArrowView addSubview:mRightArrowImageView];
		[aLeftArrowView addSubview:mLeftArrowImageView];
		[aRightArrowView addSubview:rightArrowButton];
		[aLeftArrowView addSubview:leftArrowButton];
		
		
		[aLeftArrowView setHidden:YES];
		
		[baseView addSubview:aLeftArrowView];
		[baseView addSubview:aRightArrowView];
		[aRightArrowView release];
		[aLeftArrowView release];
		
		mTabBarScrollView.showsHorizontalScrollIndicator = FALSE;
		mTabBarScrollView.showsVerticalScrollIndicator = FALSE;
		mTabBarScrollView.scrollEnabled = YES;
		mTabBarScrollView.bounces = TRUE;
		
		[self addSubview:baseView];
		mTabbarItemsArray = [[NSMutableArray alloc] init];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
}

/**
 @brief right arrow button action. Scrolls to the right end of the tab bar.
 */
-(void)rightArrowButtonPressed{
	[mTabBarScrollView scrollRectToVisible:CGRectMake(mTabBarScrollView.frame.size.width, 0, mTabBarScrollView.contentSize.width, mTabBarScrollView.contentSize.height) animated:YES];
}

/**
 @brief left arrow button action. Scrolls to the left end of the tab bar.
 */
-(void)leftArrowButtonPressed{
	[mTabBarScrollView scrollRectToVisible:CGRectMake(0, 0, mTabBarScrollView.frame.size.width, mTabBarScrollView.frame.size.height) animated:YES];
}

//called wen the tabbar item pressed
-(void)btnPressed:(UIButton *)sender
{
	UIButton *temp = (UIButton *)sender;
	//TheHomeDepotAppDelegate * appDelegate = (TheHomeDepotAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	
	NSTimeInterval currentTouch = [[NSDate date] timeIntervalSince1970];
	
//	else if (temp.tag == kCartTab||temp.tag == kMyAccountTab) {	//cart or my acc
//		[[SessionManager sharedManager].cBVCMyAccount reloadPage];
//	}

	if(((TabbarItem *)[mTabbarItemsArray objectAtIndex:temp.tag]).isViewAdded == FALSE)
	{
	

			[tabBarViewl addSubview:((TabbarItem *)[mTabbarItemsArray objectAtIndex:temp.tag]).mViewController.view];
			((TabbarItem *)[mTabbarItemsArray objectAtIndex:temp.tag]).isViewAdded = TRUE;
	}
	
	UIViewController *item = ((TabbarItem *)[mTabbarItemsArray objectAtIndex:temp.tag]).mViewController;
	[tabBarViewl bringSubviewToFront:item.view];
	
	
	// @TODO we shouldn't have to call this manually?
	[item viewWillAppear:YES];
	[item viewDidAppear:YES];
	NSString *sectionName = ((TabbarItem *)[mTabbarItemsArray objectAtIndex:temp.tag]).tabTitle ;
	currentTabItemTitle = sectionName;
	
    // @TODO Why does this pop all the way to the front?? Disabled for now, since if we search via the Home Page and then switch tabs, our search results is popped!!
	currentViewController = ((TabbarItem *)[mTabbarItemsArray objectAtIndex:temp.tag]).mViewController;
	if (temp.tag == kHomeTab) {	//home
		//[(UINavigationController *)currentViewController popToRootViewControllerAnimated:NO];
	}
	
	lastButtonPressed = temp.tag;

	if (temp.tag == lastButtonPressed) //@TODO: This will always evaluate to true ?
	{
		double difference = currentTouch - lastTouch;
//		DebugLog(@"%f", currentTouch);
//		DebugLog(@"%f", lastTouch);
//		DebugLog(@"%f", difference);
		if(difference < 0.2) {
			[(UINavigationController *)currentViewController popToRootViewControllerAnimated:TRUE];
		}
		lastTouch = currentTouch;
	}
	[self updateButtonState:temp.tag];
	
}

///update the state of the tabbar button
-(void)updateButtonState:(int)aIndex
{
	@try
	{
		for (int i=0; i<[mTabbarItemsArray count]; i++)
		{
			TabbarItem *aTabbarItem = ((TabbarItem *)[mTabbarItemsArray objectAtIndex:i]);
			if(i==aIndex)
			{
				[aTabbarItem updateState:TabBarButtonStateNormal]; 
			}
			else
			{
				[aTabbarItem updateState:TabBarButtonStateHighlighted]; 
			}
		  }
	}
	@catch (NSException *e) 
	{
		DebugLog(@"Exception while updating the tab bar button state reason:%@",e.reason);
	}
}

/**
 @defines to return the view controller depends on index
 @todo Is this needed?
 */
-(UIViewController *)getViewControllerAtIndex:(int)aIndex
{
	return ((TabbarItem *)[mTabbarItemsArray objectAtIndex:aIndex]).mViewController;
}

//adds scroll view to the tab bar view
-(void)addtoScrollView:(int)aIndex
{
	[mTabBarScrollView addSubview:[mTabbarItemsArray objectAtIndex:aIndex]];//TODO shouldnt we do bounds checking of some sort here
}
//adds tabbar item to the array
-(void)addTabBaritems:(TabbarItem *)aTabbarItem
{
	static int mNOOF_TabbarItems=0;
	
	[mTabBarScrollView setContentSize:CGSizeMake(aTabbarItem.frame.size.width*(mNOOF_TabbarItems)+60, aTabbarItem.frame.size.height)];
	[aTabbarItem setFrame:CGRectMake(mNOOF_TabbarItems*aTabbarItem.frame.size.width, 0, aTabbarItem.frame.size.width, aTabbarItem.frame.size.height)];
	[aTabbarItem setTag:mNOOF_TabbarItems];
	
	[aTabbarItem.mTabbarButton addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
	
	[mTabbarItemsArray addObject:aTabbarItem];
	
	aTabbarItem.backgroundColor = [UIColor clearColor];
	[mTabBarScrollView addSubview:aTabbarItem];
	
	 mNOOF_TabbarItems++;
	//set the default view wen first tabbar item is added
	if([mTabbarItemsArray count] == 1)
	{
		[self btnPressed:((TabbarItem *)[mTabbarItemsArray objectAtIndex:0]).mTabbarButton];		
	}
	
}

/**
 @brief selects the tab bar
 */
-(void)selectTabBar:(int)aIndex
{
	if (aIndex == kCartTab)  //we are viewing the cart page
	{
		if (![[SessionManager sharedManager].cBVC hasFinishedLoading]) 
		{
			[SessionManager sharedManager].cBVC.shouldShowLoadingView = YES;
		}
	}
	else if (aIndex == kMyAccountTab)  //we are viewing the cart page
	{
		if (![[SessionManager sharedManager].cBVCMyAccount hasFinishedLoading]) 
		{
			[SessionManager sharedManager].cBVCMyAccount.shouldShowLoadingView = YES;
		}
	}
	
	TabbarItem *aTabbarItem = [mTabbarItemsArray objectAtIndex:aIndex];
	[self btnPressed:aTabbarItem.mTabbarButton];
}

///Scroll view delegates
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	if(mTabBarScrollView.contentOffset.x > 17.0f)
	{
		[aLeftArrowView setHidden:NO];
	}
	else
	{
		[aLeftArrowView setHidden:YES];
	}
	
	if(mTabBarScrollView.contentOffset.x < 250.0f)
	{
		[aRightArrowView setHidden:NO];
	}
	else
	{
		[aRightArrowView setHidden:YES];
	}
	
}

- (void)dealloc {
    [super dealloc];
}


@end
