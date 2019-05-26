//
//  ATLoadView.h
//  ATLoadView
//  https://github.com/ablettchen/ATLoadView
//
//  Created by ablett on 2019/5/5.
//  Copyright (c) 2019 ablett. All rights reserved.
//

#import <ATPopupView/ATPopupView.h>
#import <YYImage/YYImage.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ATLoadStyle) {
    ATLoadStyleLight,                       ///< 白色背景，橙色圆圈， 默认
    ATLoadStyleDark,                        ///< 黑色背景，白色圆圈
    ATLoadStyleGifImage,                    ///< 白色背景，GIF图片
};

@interface ATLoadView : ATPopupView
@property (assign, nonatomic) enum ATLoadStyle style;
@property (copy, nonatomic, nonnull) YYImage *gifImage;
- (instancetype)initWithStyle:(enum ATLoadStyle)style;
- (instancetype)initWithGifImage:(nonnull YYImage *)gifImage;
- (__kindof ATLoadView *(^)(ATLoadStyle style))withStyle;
- (__kindof ATLoadView *(^)(YYImage * _Nonnull gifImage))withGifImage;
@end

@interface ATLoadConfig : NSObject

+ (ATLoadConfig*)globalConfig;

@property (nonatomic, assign) CGSize loadSize;                                  ///< Default is (80, 80).
@property (nonatomic, assign) CGFloat innerMargin;                              ///< Default is 25.
@property (nonatomic, assign) CGFloat cornerRadius;                             ///< Default is 10.

@property (nonatomic, strong) UIColor *lightBackgroundColor;    ///< Default is 0x000000FF.
@property (nonatomic, strong) UIColor *darkBackgroundColor;     ///< Default is 0x000000C2
@property (nonatomic, strong) UIColor *gifBackgroundColor;      ///< Default is 0x00000000.

@property (nonatomic, strong) UIColor *dimBackgroundColor;                       ///< Default is 0x000000C2
@property (nonatomic, assign) BOOL dimBackgroundBlurEnabled;                     ///< Default is NO
@property (nonatomic, assign) UIBlurEffectStyle dimBackgroundBlurEffectStyle;    ///< Default is UIBlurEffectStyleExtraLight

@end
NS_ASSUME_NONNULL_END
