//
//  ProductDetailsViewController.m
//
//
//  Created by Kirandeep Kaur on 01/02/16.
//
//

#import "ProductDetailsViewController.h"


@interface ProductDetailsViewController ()

@end

@implementation ProductDetailsViewController

#pragma mark - View lifecycle methods

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self configureView];
}


-(void)setProduct:(Product *)product {
    
    if(_product != product) {
        _product = product;
    }
    [self configureView];
    
}
- (void)configureView {
    
    self.productImage.image = [UIImage imageWithData:self.product.image];
    self.productNameLabel.text = NSLocalizedString(@"productName", nil);
    self.productNameValueLabel.text = self.product.name;
    self.productPriceLabel.text = NSLocalizedString(@"productPrice", nil);
    self.productPriceValueLabel.text = self.product.price;
    [self.cartButton setTitle:NSLocalizedString(@"addToCart", nil) forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Cart setter helpers

-(void)addToCart:(id)sender {
    
    [self addSelectedProductToCartStore];
    
}

-(void)addSelectedProductToCartStore {
    
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
        self.cart = [self getCart];
        if(!self.cart) {
            self.cart = [Cart MR_createEntityInContext:localContext];
            self.cart.cartName = @"retailStore";
        }
        
        Product *newProduct = [[Product alloc] initWithEntity:[NSEntityDescription entityForName:@"Product" inManagedObjectContext:localContext] insertIntoManagedObjectContext:nil];
        newProduct = self.product;
        
        [[self.cart MR_inContext:localContext] addProductsObject:newProduct];
        self.cart.numberOfProducts = [self getNumberOfProductsInCart];
        
    } completion:^(BOOL success, NSError *error) {
        if(success) {
            
        }
        
        if (error) {
            NSLog(@"Error saving context: %@", error.description);
        }
    }];
    
    
}

- (NSSet *)addProductToCart {
    self.productsInCart = [self getProductsInCart].mutableCopy;
    [self.productsInCart addObject:self.product];
    
    return [NSSet setWithArray:self.productsInCart];
}

-(NSNumber *)getNumberOfProductsInCart {
    return [NSNumber numberWithInteger: (int)self.productsInCart.count];
}

-(NSArray *)getProductsInCart {
    return self.cart.products.allObjects;
}

-(void)setProductsInCart:(NSMutableArray *)productsInCart {
    
    if(_productsInCart != productsInCart) {
        _productsInCart = productsInCart;
    }
    Cart *cart =[self getCart];
    _productsInCart = cart.products.allObjects.mutableCopy;
    
}

-(Cart *)getCart {
    return [Cart MR_findFirstByAttribute:@"cartName" withValue:@"retailStore"];
}
@end
