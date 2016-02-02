//
//  DetailViewController.m
//  RetailStore
//
//  Created by Kirandeep Kaur on 29/01/16.
//  Copyright (c) 2016 KD. All rights reserved.
//

#import "ProductsViewController.h"
#import "ProductDetailsTableViewCell.h"
#import "ProductDetailsViewController.h"

@interface ProductsViewController ()

@end

@implementation ProductsViewController

#pragma mark - View lifecycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"ProductDetailsTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ProductsCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Managing the detail item

- (void)setListOfProducts:(NSArray *)listOfProducts {
    
    if(_listOfProducts != listOfProducts) {
        _listOfProducts = listOfProducts;
    }
    [self configureView];
}


- (void)configureView {
    
    self.navigationItem.title = NSLocalizedString(@"home", nil);
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"showCart", nil)
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(showCart)];
    [self.navigationItem setRightBarButtonItem:item animated:YES];

    [self.tableView reloadData];
    
}

#pragma mark - Core data accessors

-(void)showCart {
    [self performSegueWithIdentifier:@"showCart" sender:self];
}

-(void)updateItemsInCart {
    
    [self.navigationItem.rightBarButtonItem setTitle:@"X"];
    
}

#pragma mark - Table view delegates

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ProductDetailsTableViewCell *cell = [self configureCellForIndexPath:indexPath];
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 300.f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.listOfProducts.count;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"productDetails" sender:self];
}

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
    
    return [self.listOfProducts objectAtIndex:indexPath.row];
}


#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"productDetails"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        ProductDetailsTableViewCell *selectedCell = (ProductDetailsTableViewCell*)[self.tableView cellForRowAtIndexPath:indexPath];
        ProductDetailsViewController *controller = (ProductDetailsViewController *)segue.destinationViewController;
        [controller setProduct:selectedCell.product];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}

@end
