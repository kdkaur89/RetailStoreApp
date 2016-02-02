//
//  ProductCategory.m
//
//
//  Created by Kirandeep Kaur on 01/02/16.
//
//

#import "ProductCategory.h"
#import "ProductTypes.h"


@implementation ProductCategory

@dynamic categoryId;
@dynamic name;
@dynamic type;

-(void) initWithJsonDictionary: (NSDictionary *)dict inContext: (NSManagedObjectContext *)localContext {
    
    self.categoryId = [dict valueForKey:@"id"];
    self.name = [dict valueForKey:@"name"];
    self.type  = [self setupProductTypesWithArray:[dict objectForKey:@"types"] inContext:localContext];
    
}

- (NSSet *)setupProductTypesWithArray: (NSArray *)types inContext: (NSManagedObjectContext *)localContext {
    
    NSMutableSet *typesSet = [NSMutableSet new];
    for (NSDictionary *typesDict in types) {
        
        ProductTypes *productTypes = [ProductTypes MR_createEntityInContext:localContext];
        [productTypes initWithJsonDictionary:typesDict withContext: localContext];
        [typesSet addObject:productTypes];
    }
    
    return typesSet;
    
}

@end
