//
//  Common.h
//  Meow
//
//  Created by Matthew on 16/5/30.
//  Copyright © 2016年 Matthew. All rights reserved.
//

#import "MConstant.h"
#import "UIFont+Common.h"
#import "UIColor+Common.h"

@interface MCommon : NSObject
@property(strong, nonatomic) NSString * DeviceID;
@property(strong, nonatomic) NSString * DevicePlatform;
@property(assign, nonatomic) CGFloat SHeight;
@property(assign, nonatomic) CGFloat SWidth;
@property(assign, nonatomic) CGFloat Height;
@property(assign, nonatomic) CGFloat Width;
@property(assign, nonatomic) BOOL IsPortrait; //调用的时候去获取设备的方向

+(instancetype)share;
@end
