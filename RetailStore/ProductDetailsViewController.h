//
//  ProductDetailsViewController.h
//  
//
//  Created by Kirandeep Kaur on 01/02/16.
//
//

#import <UIKit/UIKit.h>
#import "Product.h"
#import "Cart.h"

@interface ProductDetailsViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *productImage;

@property (strong, nonatomic) IBOutlet UILabel *productNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *productPriceLabel;
@property (strong, nonatomic) IBOutlet UILabel *productNameValueLabel;
@property (strong, nonatomic) IBOutlet UILabel *productPriceValueLabel;
@property (strong, nonatomic) IBOutlet UIButton *cartButton;

@property (nonatomic, strong) Product *product;
@property (nonatomic, strong) NSMutableArray *productsInCart;
@property (nonatomic, strong) Cart *cart;

-(IBAction)addToCart:(id)sender;

@end
