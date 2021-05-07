//
//  ViewController_loginViewController.h
//  printly_iOS
//
//  Created by Muhammad Asjad on 10/6/13.
//  Copyright (c) 2013 Muhammad Asjad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "Product.h"


@interface ViewController_loginViewController : UIViewController

@property (nonatomic,strong) Product *productObj_login;

//-(IBAction)login:(id)sender;

@property (nonatomic,  retain) IBOutlet UITextField * signup_usernameField;

@property (nonatomic,  retain) IBOutlet UITextField *signup_passwordField;

@property (nonatomic,  retain) IBOutlet UITextField *signup_emailField;



-(IBAction)sign_up:(id)sender;

//-------------------------

@property (nonatomic,  retain) IBOutlet UITextField *signin_passwordField;

@property (nonatomic,  retain) IBOutlet UITextField *signin_usernameField;

- (IBAction)sign_in:(id)sender;


- (IBAction)cancel:(id)sender;

//-------------------------


//TODO: to be deleted
-(NSDictionary *) make_APICallwithURL:(NSString *)url withBody:(NSData *)body;

@end
