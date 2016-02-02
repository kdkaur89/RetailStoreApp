//
//  ProductTableViewCell.m
//  
//
//  Created by Kirandeep Kaur on 30/01/16.
//
//

#import "ProductDetailsTableViewCell.h"

@implementation ProductDetailsTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.productImage.contentMode = UIViewContentModeScaleAspectFit;
    self.productImage.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
