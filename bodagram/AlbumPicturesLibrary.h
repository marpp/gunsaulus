//
//  AlbumPicturesLibrary.h
//  bodagram
//
//  Created by Alberto de Pablo Rodriguez on 10/13/12.
//  Copyright (c) 2012 Alberto de Pablo Rodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface AlbumPicturesLibrary : UIView

@property (nonatomic, retain) NSMutableArray *images;
@property (nonatomic, retain) NSMutableArray *thumbs;
@property (nonatomic, retain) UIImage *selectedImage;


@end
