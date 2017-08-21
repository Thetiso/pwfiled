//
//  UIColor+Common.m
//  PetAdopt
//
//  Created by Matthew on 2017/8/16.
//  Copyright © 2017年 Matthew. All rights reserved.
//

#import "UIColor+Common.h"

@implementation UIColor (Common)
+(UIColor *)colorFromRGB:(NSUInteger)rgbValue
{
    return [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0];
}
+(UIColor *)pinkText
{
    return [UIColor colorFromRGB:(0xEA7B9A)];
}
+(UIColor *)grayText
{
    return [UIColor colorFromRGB:0x969696];
}
+(UIColor *)blueText
{
    return [UIColor colorFromRGB:0x93c1ff];
}
+(UIColor *)grayBg
{
    return [UIColor colorFromRGB:0xf2f2f2];
}
+(UIColor *)darkGrayBg
{
    return [UIColor colorFromRGB:0xf8f8f8];
}
+(UIColor *)uploadBtnColor
{
    return [UIColor colorFromRGB:0xFF6600];
}
+(UIColor *)wariningColor
{
    return [UIColor colorFromRGB:0x993300];
}
+(UIColor *)redFocusColor
{
    return [UIColor colorFromRGB:0xFF0036];
}
+(UIColor *)lightBlack
{
    return [UIColor colorFromRGB:0x666666];
}
+(UIColor *)darkBlack
{
    return [UIColor colorFromRGB:0x333333];
}
+(UIColor *)overlayerColor
{
    return [[UIColor blackColor] colorWithAlphaComponent:0.2];
}
+(UIColor *)popViewColor
{
    return [[UIColor blackColor] colorWithAlphaComponent:0.6];
}
@end
