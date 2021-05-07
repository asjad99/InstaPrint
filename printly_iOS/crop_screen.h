//
//  crop_screen.h
//  printly_iOS
//
//  Created by Muhammad Asjad on 11/16/13.
//  Copyright (c) 2013 Muhammad Asjad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFCropInterface.h"
#import "Product.h"


@protocol senddataProtocol <NSObject>

-(void)sendDataToA:(BOOL)myBool; //I am thinking my data is NSArray , you can use another object for store your information.

@end

@interface crop_screen : UIViewController

@property(nonatomic,assign)id delegate;
@property (nonatomic,strong) Product *productObj_info;
@property (nonatomic, strong) IBOutlet UIImageView *displayImage;

//used for data transfer
@property (nonatomic, retain) UIImage *image;
@property(nonatomic, assign) int tag_value;
@property (nonatomic, strong) BFCropInterface *cropper;

- (IBAction)cropPressed:(id)sender;
- (IBAction)cancel:(id)sender;

@end
