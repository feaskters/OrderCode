//
//  RankTableViewCell.h
//  OrderCode
//
//  Created by iOS123 on 2019/2/14.
//  Copyright © 2019年 iOS123. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface RankTableViewCell : UITableViewCell

@property NSDictionary *rankInfo;
+(instancetype)rankTableViewCell;

@end

NS_ASSUME_NONNULL_END
