//
//  DemoTableViewCell.h
//  Demo
//
//  Created by venusource on 16/8/31.
//  Copyright © 2016年 venusource.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DemoCellModel;

@protocol DemoTableViewCellDelegate <NSObject>

-(void)didClickCellMoreComment:(UIButton *)moredButton With:(UITableViewCell *)cell;

@end

@interface DemoTableViewCell : UITableViewCell

@property (nonatomic,strong) NSIndexPath *tindexPath;
@property (nonatomic,strong) DemoCellModel *model;
@property (nonatomic,weak) id<DemoTableViewCellDelegate> delegate;

@end
