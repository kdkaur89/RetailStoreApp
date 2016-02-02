//
//  JSONLoader.m
//
//
//  Created by Kirandeep Kaur on 30/01/16.
//
//

#import "JSONLoader.h"
#import "ProductCategory.h"
#import "Product.h"
#import "ProductCategory.h"

@implementation JSONLoader

- (NSArray *)dataFromJSONFile:(NSURL *)url {
    // Create a NSURLRequest with the given URL
    NSURLRequest *request = [NSURLRequest requestWithURL:url
                                             cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                         timeoutInterval:30.0];
    
    // Get the data
    NSURLResponse *response;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    
    // Now create a NSDictionary from the JSON data
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    // Create a new array to hold the locations
    NSMutableArray *items = [[NSMutableArray alloc] init];
    
    // Get an array of dictionaries with the key "locations"
    NSArray *results = [[jsonDictionary objectForKey:@"result"] objectForKey:@"category"];
    
    [self saveResultsInCoreData: results];
    
    
    // Return the array of Location objects
    return items;
}

- (void) saveResultsInCoreData: (NSArray *)results {
    
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
        for (NSDictionary *category in results) {
            
            ProductCategory *productCategory = [ProductCategory MR_findFirstByAttribute:@"categoryId" withValue:[category valueForKey:@"id"]];
            if(productCategory == nil) {
                productCategory = [ProductCategory MR_createEntityInContext:localContext];
                [ productCategory initWithJsonDictionary:category inContext: localContext];
                NSLog(@"Done");
                
            }
        }
        
    } completion:^(BOOL success, NSError *error) {
        if(success) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"DataSaveFinishedNotification" object:nil];
        }
        
        if (error) {
            NSLog(@"Error saving context: %@", error.description);
        }
    }];
    
}
@end
