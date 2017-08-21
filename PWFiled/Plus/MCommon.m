//
//  Common.m
//  Meow
//
//  Created by Matthew on 16/5/30.
//  Copyright © 2016年 Matthew. All rights reserved.
//

#import "MCommon.h"
#import <AVFoundation/AVFoundation.h>
#import <sys/socket.h>
#import <sys/sysctl.h>
@implementation MCommon
+ (instancetype)share
{
    static dispatch_once_t t = 0;
    static MCommon *com = nil;
    dispatch_once(&t, ^{
        com = [[MCommon alloc] init];
    });
    return com;
}
-(instancetype)init
{
    if (self = [super init]) {
        [self setScreenSize];
    }
    return self;
}
-(void)setScreenSize
{
    CGSize size = [UIScreen mainScreen].bounds.size;
    _SWidth = _Width = size.width;
    _SHeight = _Height = size.height;
    if (_Width > _Height && !CGSizeEqualToSize(size, CGSizeZero)) {
        _SWidth = _Height;
        _SHeight = _Width;
    }
}


@end
