//
//  ProductTypes.m
//
//
//  Created by Kirandeep Kaur on 01/02/16.
//
//

#import "ProductTypes.h"
#import "Product.h"
#import "ProductCategory.h"


@implementation ProductTypes

@dynamic type;
@dynamic productCategory;
@dynamic products;

-(void) initWithJsonDictionary: (NSDictionary *)dict withContext:(NSManagedObjectContext *)localContext {
    
    self.type = [dict valueForKey:@"type"];
    self.products = [self setupProductsWithArray: [dict objectForKey:@"products"] inContext:localContext];
}

- (NSSet *)setupProductsWithArray: (NSArray *)products inContext: (NSManagedObjectContext *)localContext {
    
    NSMutableSet *productsSet = [NSMutableSet new];
    
    for (NSDictionary *productDict in products) {
        
        Product *product = [Product MR_createEntityInContext:localContext];
        product.productType = self;
        [product initWithJsonDictionary:productDict];
        [productsSet addObject:product];
    }
    return productsSet.copy;
    return nil;
    
}

@end
