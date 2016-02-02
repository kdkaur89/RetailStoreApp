//
//  MasterViewController.h
//  RetailStore
//
//  Created by Kirandeep Kaur on 29/01/16.
//  Copyright (c) 2016 KD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class ProductsViewController;

@interface DashboardViewController : UITableViewController

@property (strong, nonatomic) ProductsViewController *detailViewController;
@property (strong, nonatomic) NSArray *categories;
@property (strong, nonatomic) NSArray *productsInSection;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *item;



@end

