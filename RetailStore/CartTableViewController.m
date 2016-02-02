//
//  CartTableViewController.m
//
//
//  Created by Kirandeep Kaur on 01/02/16.
//
//

#import "CartTableViewController.h"
#import "ProductDetailsTableViewCell.h"
#import "ProductDetailsViewController.h"

@interface CartTableViewController ()

@end

@implementation CartTableViewController


#pragma mark - View lifecycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"ProductDetailsTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ProductsCell"];
    [self configureView];
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - View configuration methods

-(void)configureView {
    
    [self loadCart];
}

-(void)reloadTableView {
    [self.tableView reloadData];
    
}

#pragma mark - Cart retreival helpers

-(Cart *)retriveCartFromStore {
    
    return [Cart MR_findFirstByAttribute:@"cartName" withValue:@"retailStore"];
}

-(void)loadCart {
    
    self.cart = [self retriveCartFromStore];
    self.productsInCart = self.cart.products.allObjects.mutableCopy;
    self.navigationItem.title = [NSString stringWithFormat:@"%@: %@", NSLocalizedString(@"totalPrice", nil),[self getSumOfProductsInCart]];
    [self reloadTableView];
}


#pragma mark - Table view delegates

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    return self.productsInCart.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProductDetailsTableViewCell *cell = [self configureCellForIndexPath:indexPath];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 300.f;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self deleteProductFromCartAtIndexPath:indexPath];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self loadCart];
    }
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"showProduct" sender:self];
}

#pragma mark - Table view helpers

- (ProductDetailsTableViewCell *)configureCellForIndexPath:(NSIndexPath *)indexPath {
    
    ProductDetailsTableViewCell *productCell  = [self.tableView dequeueReusableCellWithIdentifier:@"ProductsCell"];
    
    if(productCell == nil) {
        productCell = [[ProductDetailsTableViewCell alloc]init];
    }
    
    productCell.product = [self getProductAtIndexPath: indexPath];
    
    productCell.productName.text = productCell.product.name;
    productCell.productPrice.text = productCell.product.price;
    productCell.productImage.image = [UIImage imageWithData:productCell.product.image];
    
    return productCell;
}

- (Product *)getProductAtIndexPath: (NSIndexPath *)indexPath {
    
    return [self.productsInCart objectAtIndex:indexPath.row];
}

- (NSDecimalNumber *)getSumOfProductsInCart {
    NSDecimalNumber *totalPrice = [NSDecimalNumber zero];
    for (Product *product in self.productsInCart) {
        NSDecimalNumber *priceForProduct = [NSDecimalNumber decimalNumberWithString:product.price];
        if(![priceForProduct isEqualToNumber:[NSDecimalNumber notANumber]]) {
            totalPrice  = [totalPrice decimalNumberByAdding:priceForProduct];
        }
        
    }
    return totalPrice;
}

- (void)deleteProductFromCartAtIndexPath: (NSIndexPath *)indexpath {
    [self.productsInCart removeObjectAtIndex:indexpath.row];
    self.cart = [self retriveCartFromStore];
    
    
    
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
        
        if(!self.cart) {
            self.cart = [Cart MR_createEntityInContext:localContext];
            self.cart.cartName = @"retailStore";
        }
        self.cart.products = [NSSet setWithArray:self.productsInCart];
        self.cart.numberOfProducts = [NSNumber numberWithInteger:(int) self.cart.products.allObjects.count];
        
    } completion:^(BOOL success, NSError *error) {
        if(success) {
            
        }
        
        if (error) {
            NSLog(@"Error saving context: %@", error.description);
        }
    }];
}


#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showProduct"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        ProductDetailsTableViewCell *selectedCell = (ProductDetailsTableViewCell*)[self.tableView cellForRowAtIndexPath:indexPath];
        ProductDetailsViewController *controller = (ProductDetailsViewController *)segue.destinationViewController;
        [controller.cartButton setHidden:TRUE];
        [controller setProduct:selectedCell.product];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}
@end
