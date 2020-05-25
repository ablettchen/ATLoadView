//
//  ATLoadView.h
//  ATLoadView
//  https://github.com/ablettchen/ATLoadView
//
//  Created by ablett on 2019/5/5.
//  Copyright (c) 2019 ablett. All rights reserved.
//

#import <UIKit/UIKit.h>
#if __has_include(<YYImage/YYImage.h>)
#import <YYImage/YYImage.h>
#else
#import "YYImage.h"
#endif

NS_ASSUME_NONNULL_BEGIN

@class ATLoadConf;
@interface  ATLoadView : UIView

@property (nonatomic, copy, readonly) void(^update)(void(^block)(ATLoadConf *conf));

@property (nullable, nonatomic, copy) void(^didShow)(BOOL finished);
@property (nullable, nonatomic, copy) void(^didHide)(BOOL finished);

+ (instancetype)viewWithText:(nullable NSString *)text;
+ (instancetype)viewWithLightStyle;
+ (instancetype)viewWithDarkStyle;
+ (instancetype)viewWithGifImage:(nullable YYImage *)image;
+ (instancetype)viewWithDefaultGif;

- (void)showIn:(UIView *)view;
- (void)show;
- (void)hide;

@end

@interface ATLoadConf : NSObject

@property (nonatomic, assign) CGSize size;                      ///< Default is (80, 80).
@property (nonatomic, assign) UIEdgeInsets insets;              ///< Default is UIEdgeInsetsMake(15, 15, 15, 15).

@property (nonatomic, assign) CGFloat offsetY;                  ///< Default is 0.
@property (nonatomic, assign) CGFloat cornerRadius;             ///< Default is 10.

@property (nonatomic, strong) UIColor *dimBackgroundColor;      ///< Default is 0x0000007F
@property (nonatomic, strong) UIColor *defaultBackgroundColor;  ///< Default is 0x00000000.
@property (nonatomic, strong) UIColor *lightBackgroundColor;    ///< Default is 0x00000000.
@property (nonatomic, strong) UIColor *darkBackgroundColor;     ///< Default is 0x00000080
@property (nonatomic, strong) UIColor *gifBackgroundColor;      ///< Default is 0x00000000.

- (void)reset;

@end
NS_ASSUME_NONNULL_END
