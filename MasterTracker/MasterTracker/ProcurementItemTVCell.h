//
//  ProcurementItemTVCell.h
//  MasterTracker
//
//  Created by Luke Paulo on 10/25/17.
//  Copyright © 2017 lpinc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyItems, ProcurementItemTVCell;

@protocol ProcurementItemTVCellDelegate <NSObject>

- (void) cell:(ProcurementItemTVCell *)cell didTapImageView:(UIImageView *)imageView;

@end

@interface ProcurementItemTVCell : UITableViewCell

@property (nonatomic, strong) MyItems *item;
@property (nonatomic, weak) id <ProcurementItemTVCellDelegate> delegate;

//since doesn't belong to an instance of this object, we use +. Namaste
+ (CGFloat) heightForItem:(MyItems *)item width:(CGFloat)width;

@end
