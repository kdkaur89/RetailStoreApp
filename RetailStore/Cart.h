//
//  Cart.h
//  
//
//  Created by Kirandeep Kaur on 01/02/16.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Product;

@interface Cart : NSManagedObject

@property (nonatomic, retain) NSNumber * numberOfProducts;
@property (nonatomic, retain) NSString *cartName;
@property (nonatomic, retain) NSSet *products;
@end

@interface Cart (CoreDataGeneratedAccessors)

- (void)addProductsObject:(Product *)value;
- (void)removeProductsObject:(Product *)value;
- (void)addProducts:(NSSet *)values;
- (void)removeProducts:(NSSet *)values;

@end
