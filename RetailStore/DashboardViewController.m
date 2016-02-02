//
//  MasterViewController.m
//  RetailStore
//
//  Created by Kirandeep Kaur on 29/01/16.
//  Copyright (c) 2016 KD. All rights reserved.
//

#import "DashboardViewController.h"
#import "ProductsViewController.h"
#import "ProductCategory.h"
#import "Product.h"
#import "Cart.h"
#import "JSONLoader.h"
#import "ProductTypes.h"
#import "DashboardTableViewCell.h"
#import "CartTableViewController.h"
@interface DashboardViewController ()

@end

@implementation DashboardViewController


#pragma mark - View lifecycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadView) name:@"DataSaveFinishedNotification" object:nil];
    
    [self getProducts];
    [self configureView];
    
    self.detailViewController = (ProductsViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)reloadView {
    
    self.categories = [ProductCategory MR_findAll];
    [self.tableView reloadData];
}
- (void)configureView {
    
    self.navigationItem.title = NSLocalizedString(@"home", nil);
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"showCart", nil)
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(showCart)];
    [self.navigationItem setRightBarButtonItem:item animated:YES];
    
}

#pragma mark - Caore data accessors

- (void)getProducts {
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        JSONLoader *jsonLoader = [[JSONLoader alloc] init];
        [jsonLoader dataFromJSONFile:[[NSBundle mainBundle] URLForResource:@"Products" withExtension:@"json"]];
        [self performSelectorOnMainThread:@selector(reloadView)
                               withObject:nil waitUntilDone:YES];
    });

    
}

-(void)showCart {
    [self performSegueWithIdentifier:@"showCart" sender:self];
}



#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        ProductTypes *selectedProductType = ((DashboardTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath]).productType;
        ProductsViewController *controller = (ProductsViewController *)[[segue destinationViewController] topViewController];
        [controller setListOfProducts:[self getListOfProductsForProductType: selectedProductType]];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}

-(NSArray *)getListOfProductsForProductType: (ProductTypes *)selectedProductType {
    
    return selectedProductType.products.allObjects;
    
}
#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.categories.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return ((ProductCategory *)[self.categories objectAtIndex:section]).type.allObjects.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DashboardTableViewCell *cell = (DashboardTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[DashboardTableViewCell alloc] init];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return ((ProductCategory *)[self.categories objectAtIndex:section]).name;
}


- (void)configureCell:(DashboardTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    ProductTypes *productType = [self getTypeOfProductsAtIndexpath: indexPath];
    cell.textLabel.text = productType.type;
    cell.productType = productType;
    
}

-(ProductTypes *)getTypeOfProductsAtIndexpath: (NSIndexPath *)indexpath {
    
    NSArray *productTypesInSection = ((ProductCategory *)[self.categories objectAtIndex:indexpath.section]).type.allObjects;
    ProductTypes *productType = [productTypesInSection objectAtIndex:indexpath.row];
    return productType;
    
}

#pragma mark - Fetched results controller


- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

@end
