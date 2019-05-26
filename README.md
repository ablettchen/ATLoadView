# ATLoadView

[![CI Status](https://img.shields.io/travis/ablettchen@gmail.com/ATLoadView.svg?style=flat)](https://travis-ci.org/ablettchen@gmail.com/ATLoadView)
[![Version](https://img.shields.io/cocoapods/v/ATLoadView.svg?style=flat)](https://cocoapods.org/pods/ATLoadView)
[![License](https://img.shields.io/cocoapods/l/ATLoadView.svg?style=flat)](https://cocoapods.org/pods/ATLoadView)
[![Platform](https://img.shields.io/cocoapods/p/ATLoadView.svg?style=flat)](https://cocoapods.org/pods/ATLoadView)

## Example

![](https://github.com/ablettchen/ATLoadView/blob/master/Example/images/load.gif)

To run the example project, clone the repo, and run `pod install` from the Example directory first.

```objectiveC
#import <ATLoadView/ATLoadView.h>
```

* Load - Light

```objectiveC
ATLoadView *view = ATLoadView.build.showIn(self.view); // default style is Light
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    [view hide];
});
```

* Load - Dark

```objectiveC
ATLoadView *view = ATLoadView.build.withStyle(ATLoadStyleDark).showIn(self.view);
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    [view hide];
});
```

* Load - Gif image

```objectiveC
//ATLoadView *view = ATLoadView.build.withStyle(ATLoadStyleGifImage).showIn(self.view); // default gif image
ATLoadView *view = ATLoadView.build.withGifImage([YYImage imageNamed:@"popup_load_balls.gif"]).showIn(self.view);
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    [view hide];
});
```

## Requirements

## Installation

ATLoadView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ATLoadView'
```

## Author

ablettchen@gmail.com, ablett.chen@gmail.com

## License

ATLoadView is available under the MIT license. See the LICENSE file for more info.
