//
//  ProductTableViewCell.h
//  
//
//  Created by Kirandeep Kaur on 30/01/16.
//
//

#import <UIKit/UIKit.h>
#import "Product.h"

@interface ProductDetailsTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *productImage;

@property (strong, nonatomic) IBOutlet UILabel *productName;
@property (strong, nonatomic) IBOutlet UILabel *productPrice;

@property (nonatomic, strong) Product *product;


@end
