//
//  AlbumPicturesLibrary.m
//  bodagram
//
//  Created by Alberto de Pablo Rodriguez on 10/13/12.
//  Copyright (c) 2012 Alberto de Pablo Rodriguez. All rights reserved.
//

#import "AlbumPicturesLibrary.h"

@implementation AlbumPicturesLibrary

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)viewDidLoad {
    
    
    
	UIScrollView *view = [[UIScrollView alloc]
                          initWithFrame:[[UIScreen mainScreen] bounds]];
    
	int row = 0;
	int column = 0;
	for(int i = 0; i < thumbs.count; ++i) {
        
		UIImage *thumb = [thumbs objectAtIndex:i];
		UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
		button.frame = CGRectMake(column*100+24, row*80+10, 64, 64);
		[button setImage:thumb forState:UIControlStateNormal];
		[button addTarget:self
				   action:@selector(buttonClicked:)
		 forControlEvents:UIControlEventTouchUpInside];
		button.tag = i;
		[view addSubview:button];
        
		if (column == 2) {
			column = 0;
			row++;
		} else {
			column++;
		}
        
	}
    
	[view setContentSize:CGSizeMake(320, (row+1) * 80 + 10)];
	self.view = view;
	[view release];	
	[super viewDidLoad];
}

@end
