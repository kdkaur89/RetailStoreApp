//
//  ProductTypes.h
//  
//
//  Created by Kirandeep Kaur on 01/02/16.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Product, ProductCategory;

@interface ProductTypes : NSManagedObject

@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) ProductCategory *productCategory;
@property (nonatomic, retain) NSSet *products;

-(void) initWithJsonDictionary: (NSDictionary *)dict withContext: (NSManagedObjectContext *)localContext;
@end

@interface ProductTypes (CoreDataGeneratedAccessors)

- (void)addProductsObject:(Product *)value;
- (void)removeProductsObject:(Product *)value;
- (void)addProducts:(NSSet *)values;
- (void)removeProducts:(NSSet *)values;

@end
