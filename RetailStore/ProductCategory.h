//
//  ProductCategory.h
//  
//
//  Created by Kirandeep Kaur on 01/02/16.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ProductTypes;

@interface ProductCategory : NSManagedObject

@property (nonatomic, retain) NSString * categoryId;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *type;

-(void) initWithJsonDictionary: (NSDictionary *)dict inContext: (NSManagedObjectContext *)localContext;
@end

@interface ProductCategory (CoreDataGeneratedAccessors)

- (void)addTypeObject:(ProductTypes *)value;
- (void)removeTypeObject:(ProductTypes *)value;
- (void)addType:(NSSet *)values;
- (void)removeType:(NSSet *)values;

@end
