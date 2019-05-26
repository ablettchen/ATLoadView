//
//  ATLoadView.m
//  ATLoadView
//  https://github.com/ablettchen/ATLoadView
//
//  Created by ablett on 2019/5/5.
//  Copyright (c) 2019 ablett. All rights reserved.
//

#import "ATLoadView.h"
#import <ATCategories/ATCategories.h>
#import <Masonry/Masonry.h>
#import <ATPopupView/UIView+ATPopup.h>
#import <ATLoadingView/ATLoadingView.h>

@implementation ATLoadView

NS_INLINE YYImage *ATLoadViewImageNamed(NSString *imageName) {
    NSString *bundlePath = [[NSBundle bundleForClass:[ATLoadView class]] pathForResource:@"ATLoadView" ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    NSString *filePath = [bundle pathForResource:imageName ofType:nil];
    return [YYImage imageWithContentsOfFile:filePath];
}

NS_INLINE YYImage *at_defaultGifImage(void) {
    return ATLoadViewImageNamed(@"popup_load_default.gif");
}

#pragma mark - lifcycle

- (instancetype)init {
    return [self initWithStyle:ATLoadStyleLight gifImage:nil];
}

#pragma mark - privite

- (instancetype)initWithStyle:(enum ATLoadStyle)style gifImage:(nullable YYImage *)gifImage {
    self = [super init];
    if (!self) return nil;
    
    self.style = style;
    self.gifImage = gifImage;
    
    return self;
}

- (void)setupWithStyle:(enum ATLoadStyle)style gifImage:(nullable YYImage *)gifImage {
    
    BOOL value = (style == ATLoadStyleLight || \
                  style == ATLoadStyleDark || \
                  (style == ATLoadStyleGifImage && gifImage));
    
    NSAssert(value, @"gifImage could not be nil.");
    
    self.type = ATPopupTypeLoad;
    self.gifImage = gifImage;
    
    ATLoadConfig *config = [ATLoadConfig globalConfig];
    
    switch (style) {
            case ATLoadStyleLight:{
                
                [self mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.size.equalTo(@(CGSizeMake(100, 100)));
                }];
                
                self.layer.cornerRadius = config.loadSize.width/2.f;
                self.clipsToBounds = YES;
                self.alpha = 0.f;
                self.backgroundColor = config.lightBackgroundColor;
                
                ATRotationView *rotateView = [ATRotationView new];
                [self addSubview:rotateView];
                [rotateView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.edges.equalTo(self);
                }];
                rotateView.speed = 0.95f;
                rotateView.clockWise = YES;
                [rotateView startRotateAnimation];
                
                UIImageView *imageView = [UIImageView new];
                [rotateView addSubview:imageView];
                [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.size.equalTo(@(CGSizeMake(80, 80)));
                    make.center.equalTo(rotateView);
                }];
                imageView.image = ATLoadViewImageNamed(@"popup_load_circle_l.png");
                
                /*
                UIImageView *inImageView = [[UIImageView alloc] initWithImage:ATLoadViewImageNamed(@"popup_load_word_a.png")];
                [self addSubview:inImageView];
                [inImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.center.equalTo(self);
                }];
                inImageView.scale = 0.3f;
                inImageView.glowRadius = @(2.f);
                inImageView.glowOpacity = @(1.f);
                inImageView.glowColor = [[UIColor colorWithRed:0.203  green:0.598  blue:0.859 alpha:1] colorWithAlphaComponent:0.95f];
                inImageView.glowDuration = @(1.f);
                inImageView.hideDuration = @(3.f);
                inImageView.glowAnimationDuration = @(2.f);
                [inImageView createGlowLayer];
                [inImageView insertGlowLayer];
                [inImageView startGlowLoop];
                 */
                
            }break;
            case ATLoadStyleDark:{
                
                [self mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.size.equalTo(@(config.loadSize));
                }];
                
                self.layer.cornerRadius = 5.f;
                self.clipsToBounds = YES;
                self.alpha = 0.f;
                self.backgroundColor = config.darkBackgroundColor;
                
                ATLoadingView *lv = [ATLoadingView new];
                [self addSubview:lv];
                [lv mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.size.mas_equalTo(CGSizeMake(40, 40));
                    make.center.equalTo(self);
                }];
                [lv start];
                
            }break;
            case ATLoadStyleGifImage:{
                
                [self mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.size.equalTo(@(config.loadSize));
                }];
                
                self.layer.cornerRadius = config.cornerRadius;
                self.clipsToBounds = YES;
                self.alpha = 0.f;
                self.backgroundColor = config.gifBackgroundColor;
                YYAnimatedImageView *imageView = [[YYAnimatedImageView alloc] initWithImage:gifImage];
                [self addSubview:imageView];
                [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.edges.equalTo(self).insets(UIEdgeInsetsMake(config.innerMargin, config.innerMargin, config.innerMargin, config.innerMargin));
                }];
            }break;
        default:
            break;
    }
    
    [UIView animateWithDuration:0.3f animations:^{
        self.alpha = 1.f;
        self.scale = 1.f;
    }];
    
    [[ATPopupWindow sharedWindow] setTouchWildToHide:NO];
    self.attachedView.at_dimBackgroundColor = config.dimBackgroundColor;
    self.attachedView.at_dimBackgroundBlurEnabled = config.dimBackgroundBlurEnabled;
    self.attachedView.at_dimBackgroundBlurEffectStyle = config.dimBackgroundBlurEffectStyle;
}

#pragma mark - overwrite

- (void)show:(ATPopupCompletionBlock)block {
    [self setupWithStyle:self.style gifImage:self.gifImage];
    [super show:block];
}

- (void)hide:(ATPopupCompletionBlock)block {
    [super hide:block];
}

#pragma mark - public

- (instancetype)initWithStyle:(enum ATLoadStyle)style {
    self.style = style;
    if (style == ATLoadStyleGifImage) {
        self.gifImage = at_defaultGifImage();
    }
    return [self initWithStyle:self.style gifImage:self.gifImage];
}

- (instancetype)initWithGifImage:(nonnull YYImage *)gifImage {
    return [self initWithStyle:ATLoadStyleGifImage gifImage:gifImage];
}

- (__kindof ATLoadView *(^)(ATLoadStyle style))withStyle {
    return ^ __kindof ATLoadView *(ATLoadStyle style) {
        self.style = style;
        if (style == ATLoadStyleGifImage) {
            self.gifImage = at_defaultGifImage();
        }
        return self;
    };
}

- (__kindof ATLoadView *(^)(YYImage * _Nonnull gifImage))withGifImage {
    return ^ __kindof ATLoadView *(YYImage * _Nonnull gifImage) {
        self.style = ATLoadStyleGifImage;
        self.gifImage = gifImage;
        return self;
    };
}

@end

@implementation ATLoadConfig

+ (ATLoadConfig *)globalConfig {
    static ATLoadConfig *config;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        config = [ATLoadConfig new];
    });
    return config;
}

- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    
    self.loadSize                       = CGSizeMake(80, 80);
    self.innerMargin                    = 10.0f;
    self.cornerRadius                   = 5.0f;
    
    self.lightBackgroundColor           = UIColorHex(0x00000000);
    self.darkBackgroundColor            = UIColorHex(0x000000C2);
    self.gifBackgroundColor             = UIColorHex(0x00000000);
    
    self.dimBackgroundColor             = UIColorHex(0x00000000);
    self.dimBackgroundBlurEnabled       = NO;
    self.dimBackgroundBlurEffectStyle   = UIBlurEffectStyleExtraLight;
    
    return self;
}

@end
