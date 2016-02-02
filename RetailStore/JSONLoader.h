//
//  JSONLoader.h
//  
//
//  Created by Kirandeep Kaur on 30/01/16.
//
//

#import <Foundation/Foundation.h>

@interface JSONLoader : NSObject

// Return an array of Location objects from the json file at location given by url
- (NSArray *)dataFromJSONFile:(NSURL *)url;

@end
