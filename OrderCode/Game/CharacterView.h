//
//  CharacterView.h
//  OrderCode
//
//  Created by iOS123 on 2019/1/22.
//  Copyright © 2019年 iOS123. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CharacterView : UIImageView

+(instancetype)characterView;
-(void)up;
-(void)left;
-(void)down;
-(void)right;
-(void)fast_left;
-(void)fast_right;
-(void)fast_up;
-(void)fast_down;

//获取当前位置
-(NSArray *)location;

@end

NS_ASSUME_NONNULL_END
