//
//  SingleViewBasedAppViewController.h
//  printly_iOS
//
//  Created by Muhammad Asjad on 10/6/13.
//  Copyright (c) 2013 Muhammad Asjad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"
@interface SingleViewBasedAppViewController : UIViewController

@property (nonatomic,strong) Product *productObj_info;


-(IBAction)img_squares:(id)sender;
-(IBAction)img_mini:(id)sender;
-(IBAction)img_classic:(id)sender;
@end
