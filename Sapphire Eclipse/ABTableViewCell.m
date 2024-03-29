// Copyright (c) 2008 Loren Brichter
// 
// Permission is hereby granted, free of charge, to any person
// obtaining a copy of this software and associated documentation
// files (the "Software"), to deal in the Software without
// restriction, including without limitation the rights to use,
// copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the
// Software is furnished to do so, subject to the following
// conditions:
// 
// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
// OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
// HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
// WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
// OTHER DEALINGS IN THE SOFTWARE.
//
//  ABTableViewCell.m
//
//  Created by Loren Brichter
//  Copyright 2008 Loren Brichter. All rights reserved.
//

#import "ABTableViewCell.h"

@interface ABTableViewCellView : UIView
@end

@implementation ABTableViewCellView

- (void)drawRect:(CGRect)r
{
	UIView *view = [self superview];
	[(ABTableViewCell *)[view superview] drawContentView:r];
}

@end



@implementation ABTableViewCell

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier])
	{
		self.backgroundColor = [UIColor whiteColor];
	contentView = [[ABTableViewCellView alloc] initWithFrame:CGRectZero];
		contentView.backgroundColor = [UIColor clearColor];
		contentView.opaque = YES;
		
		// changed
		[self.contentView addSubview:contentView];
		[contentView release];
	}
	return self;
}

- (void)dealloc
{
	[super dealloc];
}

- (void)setFrame:(CGRect)f
{
	[super setFrame:f];
	CGRect b = [self bounds];
	b.size.height -= 1; // leave room for the seperator line
	[contentView setFrame:b];
}

- (void)setNeedsDisplay
{
	[super setNeedsDisplay];
	[contentView setNeedsDisplay];
}

/**
 @brief handle cell selection here
 @params selected : selected or unselected
 animated  : to animate the selection or not
 */
- (void)setSelected:(BOOL)selected animated:(BOOL)animated 
{
	if(selected) 
		selectedImageView.hidden = NO;
	else 
		selectedImageView.hidden = YES;
	[self setNeedsDisplay];
    // Configure the view for the selected state
}
- (void)drawContentView:(CGRect)r
{
	// subclasses should implement this
}


@end
