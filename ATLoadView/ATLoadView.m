//
//  ATLoadView.m
//  ATLoadView
//  https://github.com/ablettchen/ATLoadView
//
//  Created by ablett on 2019/5/5.
//  Copyright (c) 2019 ablett. All rights reserved.
//

#import "ATLoadView.h"
#if __has_include(<ATCategories/ATCategories.h>)
#import <ATCategories/ATCategories.h>
#else
#import "ATCategories.h"
#endif

#if __has_include(<Masonry/Masonry.h>)
#import <Masonry/Masonry.h>
#else
#import "Masonry.h"
#endif

#if __has_include(<ATLoadingView/ATLoadingView.h>)
#import <ATLoadingView/ATLoadingView.h>
#else
#import "ATLoadingView.h"
#endif

typedef NS_ENUM(NSUInteger, ATLoadStyle) {
    ATLoadStyleDefault,
    ATLoadStyleLight,                       ///< 白色背景，橙色圆圈， 默认
    ATLoadStyleDark,                        ///< 黑色背景，白色圆圈
    ATLoadStyleGifImage,                    ///< 白色背景，GIF图片
};


@interface ATLoadView ()
@property (assign, nonatomic) enum ATLoadStyle style;
@property (strong, nonatomic) YYImage *image;
@property (nonatomic, strong, readonly) ATLoadConf *conf;
@property (nonatomic, strong, readonly) UIView *backgroundView;
@property (copy, nonatomic) NSString *text;
@end
@implementation ATLoadView

@synthesize conf = _conf;
@synthesize backgroundView = _backgroundView;

NS_INLINE YYImage *ATLoadViewImageNamed(NSString *imageName) {
    NSString *bundlePath = [[NSBundle bundleForClass:[ATLoadView class]] pathForResource:@"ATLoadView" ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    NSString *filePath = [bundle pathForResource:imageName ofType:nil];
    return [YYImage imageWithContentsOfFile:filePath];
}

NS_INLINE YYImage *at_defaultGifImage(void) {
    return ATLoadViewImageNamed(@"popup_load_default.gif");
}

#pragma mark - Lifcycle

- (void)dealloc {
#ifdef DEBUG
    NSLog(@"%d - %s", (int)__LINE__, __func__);
#endif
}

- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    self.clipsToBounds = YES;
    self.alpha = 0.001f;
    self.style = ATLoadStyleLight;
    self.update(^(ATLoadConf * _Nonnull conf) {});
    return self;
}

#pragma mark - Setter, Getter

- (void (^)(void (^ _Nonnull)(ATLoadConf * _Nonnull)))update {
    @weakify(self);
    return ^void(void(^block)(ATLoadConf *config)) {
        @strongify(self);
        if (!self) return;
        if (block) block(self.conf);
        ///backgroundView
        self.backgroundView.backgroundColor = self.conf.dimBackgroundColor;
        self.at_size = self.conf.size;
        self.layer.cornerRadius = self.conf.cornerRadius;
    };
}

- (ATLoadConf *)conf {
    if (_conf) return _conf;
    _conf = [ATLoadConf new];
    return _conf;
}

- (UIView *)backgroundView  {
    if (_backgroundView) return _backgroundView;
    _backgroundView = [UIView new];
    _backgroundView.clipsToBounds = YES;
    _backgroundView.alpha = 0.001f;
    return _backgroundView;
}

#pragma mark - Privite

- (void)setupViewIn:(UIView *)view {
    [view addSubview:self.backgroundView];
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(view);
        make.center.equalTo(view);
    }];
    
    [self.backgroundView addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(self.conf.size);
        make.centerX.equalTo(self.backgroundView);
    }];
    
    switch (self.style) {
        case ATLoadStyleDefault:{
            
            self.backgroundColor = self.conf.defaultBackgroundColor;
            
            ATLoadingView *lv = [ATLoadingView new];
            [self addSubview:lv];
            [lv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(30, 30));
                make.center.equalTo(self);
            }];
            lv.lineColor = UIColorHex(0x9999994D);
            
            if (self.text.length > 0) {
                
                UILabel *textLabel = ({
                    UILabel *label = [UILabel new];
                    [self.backgroundView addSubview:label];
                    [label mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.right.equalTo(self.backgroundView).insets(self.conf.insets);
                        make.top.equalTo(lv.mas_bottom).offset(15);
                    }];
                    label.font = [UIFont systemFontOfSize:12];
                    label.textColor = UIColorHex(0x666666FF);
                    label.textAlignment = NSTextAlignmentCenter;
                    label;
                });
                textLabel.text = self.text;
            }
            
            [lv start];
            
        }break;
        case ATLoadStyleLight:{
            self.backgroundColor = self.conf.lightBackgroundColor;
            
            UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
            UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
            [self addSubview:effectView];
            [effectView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self);
            }];
            effectView.alpha = 0.5;
            ATLoadingView *lv = [ATLoadingView new];
            [self addSubview:lv];
            [lv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(40, 40));
                make.center.equalTo(self);
            }];
            lv.lineColor = UIColorHex(0x9999994D);
            [lv start];
            
        }break;
        case ATLoadStyleDark:{
            self.backgroundColor = self.conf.darkBackgroundColor;
            
            UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
            UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
            [self addSubview:effectView];
            [effectView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self);
            }];
            effectView.alpha = 0.5;
            
            ATLoadingView *lv = [ATLoadingView new];
            [self addSubview:lv];
            [lv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(40, 40));
                make.center.equalTo(self);
            }];
            [lv start];
            
        }break;
        case ATLoadStyleGifImage:{
            self.backgroundColor = self.conf.gifBackgroundColor;
            
            if (!self.image) {self.image = at_defaultGifImage();}
            YYAnimatedImageView *imageView = [[YYAnimatedImageView alloc] initWithImage:self.image];
            [self addSubview:imageView];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self).insets(self.conf.insets);
            }];
        }break;
        default:
            break;
    }
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.backgroundView);
    }];
    
}

- (void)show:(void(^ __nullable)(BOOL finished))completion {
    [self showIn:[[UIApplication sharedApplication] keyWindow] completion:completion];
}

- (void)showIn:(UIView *)view completion:(void(^)(BOOL finished))completion {
    // setup views
    [self setupViewIn:view];
    // show animation
    self.alpha = 1.0f;
    [self bringSubviewToFront:view];
    @weakify(self);
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         @strongify(self);
                         self.backgroundView.alpha = 1.0f;
                         self.layer.transform = CATransform3DIdentity;
                         self.alpha = 1.0f;
                     }
                     completion:completion];
}

- (void)hide:(void(^ __nullable)(BOOL finished))completion {
    @weakify(self);
    [UIView animateWithDuration:0.3
                          delay:0
                        options: UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         @strongify(self);
                         self.backgroundView.alpha = 0.001f;
                         self.alpha = 0.001f;
                     }
                     completion:^(BOOL finished) {
                         @strongify(self);
                         if (finished) {
                             [self removeFromSuperview];
                             [self.backgroundView removeFromSuperview];
                             self->_backgroundView = nil;
                         }
                         if (completion) {completion(finished);}
                     }];
}

#pragma mark - Public

+ (instancetype)viewWithText:(nullable NSString *)text {
    ATLoadView *view = [ATLoadView new];
    view.style = ATLoadStyleDefault;
    view.text = text;
    return view;
}

+ (instancetype)viewWithLightStyle {
    ATLoadView *view = [ATLoadView new];
    view.style = ATLoadStyleLight;
    return view;
}

+ (instancetype)viewWithDarkStyle {
    ATLoadView *view = [ATLoadView new];
    view.style = ATLoadStyleDark;
    return view;
}

+ (instancetype)viewWithGifImage:(nullable YYImage *)image {
    ATLoadView *view = [ATLoadView new];
    view.style = ATLoadStyleGifImage;
    view.image = image;
    return view;
}

- (void)showIn:(UIView *)view {
    [self showIn:view completion:self.didShow];
}

- (void)show {
    [self show:self.didShow];
}

- (void)hide {
    [self hide:self.didHide];
}

@end

@implementation ATLoadConf

- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    [self reset];
    return self;
}

- (void)reset {
    _size                   = CGSizeMake(80, 80);
    _insets                 = UIEdgeInsetsMake(15, 15, 15, 15);
    _cornerRadius           = 5.0f;
    _cornerRadius           = 10.f;
    _defaultBackgroundColor = UIColorHex(0x00000000);
    _dimBackgroundColor     = UIColorHex(0x00000000);
    _lightBackgroundColor   = UIColorHex(0x00000000);
    _darkBackgroundColor    = UIColorHex(0x00000000);
    _gifBackgroundColor     = UIColorHex(0x00000000);
}

@end
