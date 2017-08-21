//
//  MConstant.h
//  PetAdopt
//
//  Created by Matthew on 2017/8/16.
//  Copyright © 2017年 Matthew. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

extern CGFloat const TOPBARHEIGHT;
extern CGFloat const SUBTOPBARHEIGHT;
extern CGFloat const TOPBARWITHSTATUSHEIGHT;
extern CGFloat const TOPBUTTONHEIGHT;
extern CGFloat const STATUSHEIGHT;
extern CGFloat const MAXARTICLECELLWIDTHFORSHARE;
extern CGFloat const FOCUSUSERAVATORWIDTH;
extern CGFloat const PETAVATORHEIGHT;
extern CGFloat const FOCUSUSERNAMEHEIGHT;
extern CGFloat const NORMALTABLECELLMARGINBOTTOM;
extern CGFloat const TabBarHeight;
extern CGFloat const NORMALMARGINLEFTANDRIGHT;
extern CGFloat const TOPBARTAGWIDTH;


typedef NS_ENUM(NSInteger, MAtcType) {
    MAtcDefault,
    MFosterAtc,
};

typedef NS_ENUM(NSInteger, MDefaultAtcSubType) {
    MAtcDefaultSubType, //默认图文贴
    MVideoAtc,
    MImgAtc, //纯图片分享
};

typedef NS_ENUM(NSInteger, MFosterAtcSubType) {
    MFosterAtcDefaultSubType = 0,       //领养其他种类
    MFosterCat               = 1 << 0,
    MFosterDog               = 1 << 1,
    MHelp                    = 1 << 2,  //救助帖
};


typedef NS_ENUM(NSInteger, MLoginType) {
    MDefaultLogin,
    MWeixinLOGIN,
    MWeiBoLOGIN,
    MPhoneLOGIN,
};

typedef NS_ENUM(NSInteger, MSysMsgType) {
    SysMsgReportArticle,
    SysMsgDeleteArticle,
    SysMsgReportComment,
    SysMsgDeleteComment,
    SysMsgReviewFail,
    SysMsgReviewSuccess,
    SysMsgVersion,
};

typedef NS_ENUM(NSInteger, MUserGender) {
    MUserGenderUnknown,
    MUserFemmale,
    MUserMale,
};

typedef NS_ENUM(NSInteger, MFavorType) {
    MFavorAtc,
    MFavorCmmt,
};

typedef NS_ENUM(NSInteger, BannerType) {
    BannerTypeDefault,
    BannerServiceType,
};


/*
 typedef NS_OPTIONS(NSUInteger, AtcCacheType) {
 AtcCacheDefault                 = 0,
 AtcCacheSgt                     = 1 << 0,
 AtcCacheFocus                   = 1 << 1,
 AtcCacheCmmt                    = 1 << 2,
 AtcCacheFavor                   = 1 << 3,
 AtcCacheEnshrine                = 1 << 4,
 AtcCacheSelf                    = 1 << 5,
 AtcCacheTag                     = 1 << 6,
 };
 
 */

@interface MConstant : NSObject

@end
