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

* Load - Default 

```objectiveC
ATLoadView *view = [ATLoadView viewWithText:@"LOADING..."];
[view showIn:self.view];
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    [view hide];
});
```

* Load - Light

```objectiveC
ATLoadView *view = [ATLoadView viewWithLightStyle];
[view showIn:self.view];
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    [view hide];
});
```

* Load - Dark

```objectiveC
        ATLoadView *view = [ATLoadView viewWithDarkStyle];
        [view showIn:self.view];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [view hide];
        });
```

* Load - Gif image

```objectiveC
ATLoadView *view = [ATLoadView viewWithGifImage:[YYImage imageNamed:@"popup_load_balls.gif"]];
[view showIn:self.view];
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

ablett, ablett.chen@gmail.com

## License

ATLoadView is available under the MIT license. See the LICENSE file for more info.
