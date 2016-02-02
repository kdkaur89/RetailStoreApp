//
//  CartTableViewController.h
//  
//
//  Created by Kirandeep Kaur on 01/02/16.
//
//

#import <UIKit/UIKit.h>
#import "Cart.h"


@interface CartTableViewController : UITableViewController
@property (nonatomic, strong) Cart *cart;
@property (nonatomic, strong) NSMutableArray *productsInCart;

@end
