//
//  OrderViewController.m
//  printly_iOS
//
//  Created by Muhammad Asjad on 5/19/14.
//  Copyright (c) 2014 Muhammad Asjad. All rights reserved.
//

#import "OrderViewController.h"
#import <Parse/Parse.h>
#import "Reachability.h"
@interface OrderViewController ()

//used for checking internet connection
@property (nonatomic) Reachability *internetReachability;
@property (nonatomic) BOOL isNetworkReachable;


@end

@implementation OrderViewController

@synthesize imagesArray;
@synthesize productObj_info;

@synthesize product_size;
@synthesize imageView;

@synthesize product_type;
@synthesize product_QTY;
@synthesize price;
@synthesize total_price;

@synthesize address1;
@synthesize address2;
@synthesize city;
@synthesize country;
@synthesize email;
@synthesize phone;




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{

    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
  
    //---------   setup product image and size label ---------
    self.imageView.backgroundColor = [UIColor blackColor];
    self.imageView.clipsToBounds = YES;
    UIImage *img = self.productObj_info.product_image;
    [imageView setImage:img];
    imageView.frame = CGRectMake(imageView.frame.origin.x, imageView.frame.origin.y,
                                 img.size.width, img.size.height);
	
    self.product_size.text = self.productObj_info.product_printSize;

    //------ setup product QTY,type and price label. -----------
   
    self.product_type.text =self.productObj_info.product_title;
    
    self.product_QTY.text = [NSString stringWithFormat:@"%lu",(unsigned long)[self.imagesArray count]];
    
    self.productObj_info.product_price = @"1";
    
    self.total_price.text = [NSString stringWithFormat:@"%lu",[self.productObj_info.product_price integerValue ] * [self.imagesArray count]];
    
    /*
     Observe the kNetworkReachabilityChangedNotification. When that notification is posted, the method reachabilityChanged will be called.
     */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    
    self.internetReachability = [Reachability reachabilityForInternetConnection];
	[self.internetReachability startNotifier];
    
    //set the flag to true initially
    self.isNetworkReachable = YES;
}

-(void)dismissKeyboard {
    
    [address1 resignFirstResponder];
    [address2 resignFirstResponder];
    [city resignFirstResponder];
    [country resignFirstResponder];
    [email resignFirstResponder];
    [phone resignFirstResponder];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) reachabilityChanged:(NSNotification *)note
{
    
	Reachability* curReach = [note object];
	NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
	//[self updateInterfaceWithReachability:curReach];
    
    NetworkStatus netStatus = [curReach currentReachabilityStatus];
    
    if (netStatus == NotReachable){
        self.isNetworkReachable = NO;
    }
    else{
        self.isNetworkReachable = YES;
    }
}

- (IBAction)save_order:(id)sender{
    
    NSString *count =[NSString stringWithFormat:@"%lu",(unsigned long)[self.imagesArray count]];
    
    NSString *price =[NSString stringWithFormat:@"%lu",[self.productObj_info.product_price integerValue ] * [self.imagesArray count]];
    
    NSMutableDictionary * order_product_info = [NSMutableDictionary dictionary];
    
    [order_product_info setObject:self.productObj_info.product_title forKey:@"product_type"];
    [order_product_info setObject:count forKey:@"total_prints"];
    [order_product_info setObject:price forKey:@"price"];
    [order_product_info setObject:self.productObj_info.product_printSize forKey:@"print_size"];
    
    //----------------  save shipping details  ---------------
    NSMutableString *address = [NSMutableString stringWithFormat: @"%@,%@", self.address1.text,self.address2.text];
    
    NSMutableDictionary * shipping_info = [NSMutableDictionary dictionary];
    
    [shipping_info setObject:address forKey:@"address"];
    [shipping_info setObject:city.text forKey:@"city"];
    [shipping_info setObject:country.text forKey:@"country"];
    [shipping_info setObject:email.text forKey:@"email"];
    [shipping_info setObject:phone.text forKey:@"phone"];
    
    
    NSMutableDictionary *order_info = [NSMutableDictionary dictionaryWithObjectsAndKeys:shipping_info,@"shipping_info",order_product_info,@"order_product_info",nil];
    
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    
    NSString *trimmed_address1 = [address1.text stringByTrimmingCharactersInSet:whitespace];
    //NSString *trimmed_address2 = [address2.text stringByTrimmingCharactersInSet:whitespace];
    NSString *trimmed_city = [address2.text stringByTrimmingCharactersInSet:whitespace];
    NSString *trimmed_country = [address2.text stringByTrimmingCharactersInSet:whitespace];
    NSString *trimmed_email = [address2.text stringByTrimmingCharactersInSet:whitespace];
    NSString *trimmed_phone = [address2.text stringByTrimmingCharactersInSet:whitespace];
    
    if ([trimmed_address1 length] == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Empty Field"
                                                        message:@"Address field cannot be empty."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
    else if ([trimmed_city length] == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Empty Field"
                                                        message:@"Please enter a valid City"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    else if ([trimmed_country length] == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Empty Field"
                                                        message:@"Please enter a valid country"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    else if ([trimmed_email length] == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Empty Field"
                                                        message:@"Please enter a valid email"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    else if ([trimmed_phone length] == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Empty Field"
                                                        message:@"Please enter a valid phone"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
    else if (self.isNetworkReachable) {
        
        
        //------- upload selected photos ------------
        for (UIImage *image  in self.imagesArray){
        
        // Resize image
        UIGraphicsBeginImageContext(CGSizeMake(640, 960));
        
        [image drawInRect: CGRectMake(0, 0, 640, 960)];
        
        UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        NSData *imageData = UIImageJPEGRepresentation(image, 0.05f);
        
        [self uploadImage:imageData];
        
        }
    
        //---------- save order details  ----------
        PFObject *order_details = [PFObject objectWithClassName:@"order_details"];
        // order_details[@"order_info"] = order_info;
    
        [order_details setObject:order_info forKey:@"order_info"];
    
        // Set the access control list to current user for security purposes
        order_details.ACL = [PFACL ACLWithUser:[PFUser currentUser]];
    
        PFUser *user = [PFUser currentUser];
        [order_details setObject:user forKey:@"user"];
        [order_details saveInBackground];
    }
}

- (void)hudWasHidden:(MBProgressHUD *)hud {
    // Remove HUD from screen when the HUD hides
    [HUD removeFromSuperview];
    HUD = nil;
}

- (void ) uploadImage:(NSData *)imageData
{
    PFFile *imageFile = [PFFile fileWithName:@"mini.jpg" data:imageData];
    
    //HUD creation here (see example for code)
    // The hud will dispable all input on the view (use the higest view possible in the view hierarchy)
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    
    // Set determinate mode
    HUD.mode = MBProgressHUDModeDeterminate;
    HUD.delegate = self;
    HUD.labelText = @"Uploading";
    [HUD show:YES];
    
    // Save PFFile

    [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
    
    if (!error) {
        //Hide determinate HUD
        [HUD hide:YES];
        
        // Show checkmark
        HUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:HUD];
        
        // The sample image is based on the work by http://www.pixelpressicons.com, http://creativecommons.org/licenses/by/2.5/ca/
        // Make the customViews 37 by 37 pixels for best results (those are the bounds of the build-in progress indicators)
        HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
        
        // Set custom view mode
        HUD.mode = MBProgressHUDModeCustomView;
        
        HUD.delegate = self;
        
            // Create a PFObject around a PFFile and associate it with the current user
            PFObject *userPhoto = [PFObject objectWithClassName:@"UserPhoto"];
            [userPhoto setObject:imageFile forKey:@"imageFile"];
            
            // Set the access control list to current user for security purposes
            userPhoto.ACL = [PFACL ACLWithUser:[PFUser currentUser]];
            
            PFUser *user = [PFUser currentUser];
            [userPhoto setObject:user forKey:@"user"];
            
            [userPhoto saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (!error) {
                      NSLog(@"uploaded:");
                   // [self refresh:nil];
                      [HUD hide:YES];
                }
                else{
                    // Log details of the failure
                    NSLog(@"Error: %@ %@", error, [error userInfo]);
                }
            }];
        }

        else{
            [HUD hide:YES];
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }

    } progressBlock:^(int percentDone) {
        // Update your progress spinner here. percentDone will be between 0 and 100.
         HUD.progress = (float)percentDone/100;
    }];
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:@"to_shippingdetails"]){
        
        OrderViewController *controller = (OrderViewController *)segue.destinationViewController;
        //productObj_info.selected_imagesArray = self.imagesArray;
        controller.imagesArray = self.imagesArray;
        controller.productObj_info = self.productObj_info;
        
    }
    
}
@end
