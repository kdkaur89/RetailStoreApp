//
//  Product.h
//  
//
//  Created by Kirandeep Kaur on 01/02/16.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ProductTypes;
@class Cart;

@interface Product : NSManagedObject

@property (nonatomic, retain) NSString * brand;
@property (nonatomic, retain) NSData * image;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * price;
@property (nonatomic, retain) NSString * productId;
@property (nonatomic, retain) ProductTypes *productType;

-(void) initWithJsonDictionary: (NSDictionary *)dict;

@end
