//
//  Product.h
//  printly_iOS
//
//  Created by Muhammad Asjad on 10/6/13.
//  Copyright (c) 2013 Muhammad Asjad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product :NSObject

@property (nonatomic,strong) NSString *product_title;

@property (nonatomic,strong) NSString *product_price;
@property (nonatomic,strong) NSString *product_price_additional;
@property (nonatomic,strong) NSString *product_printSize;
@property(nonatomic, assign) int product_minQty;
@property (strong, nonatomic) UIImage *product_image;
@property (retain,nonatomic) NSMutableArray *selected_imagesArray;

@end
