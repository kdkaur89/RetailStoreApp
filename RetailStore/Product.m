//
//  Product.m
//
//
//  Created by Kirandeep Kaur on 01/02/16.
//
//

#import "Product.h"
#import "ProductTypes.h"


@implementation Product

@dynamic brand;
@dynamic image;
@dynamic name;
@dynamic price;
@dynamic productId;
@dynamic productType;

-(void) initWithJsonDictionary: (NSDictionary *)dict {
    
    self.brand = [dict valueForKey:@"brand"];
    self.productId = [dict valueForKey:@"id"];
    self.image = [self setImageFromData: [dict valueForKey:@"image"]];
    self.name = [dict valueForKey:@"name"];
    self.price = [dict valueForKey:@"price"];
    
}



- (NSData *)setImageFromData: (NSString *)image {
    if (image == nil || image.length == 0) {
        UIImage *placeholderImg = [UIImage imageNamed:@"placeholderImage"];
        return UIImagePNGRepresentation(placeholderImg);
    }
    else{
        return [image dataUsingEncoding:NSUTF8StringEncoding];
    }
}



@end
