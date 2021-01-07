#
# Be sure to run `pod lib lint ATLoadView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    
    s.name                    = 'ATLoadView'
    s.version                 = '0.1.18'
    s.summary                 = 'ATLoadView.'
    s.description             = "加载指示图"
    s.homepage                = 'https://github.com/ablettchen/ATLoadView'
    s.license                 = { :type => 'MIT', :file => 'LICENSE' }
    s.author                  = { 'ablett' => 'ablettchen@gmail.com' }
    s.platform                = :ios, "10.0"
    s.source                  = { :git => 'https://github.com/ablettchen/ATLoadView.git', :tag => s.version.to_s }
    s.source_files            = 'ATLoadView/**/*.{h,m}'
    s.resource                = 'ATLoadView/ATLoadView.bundle'
    s.requires_arc            = true
    
    s.dependency 'ATLoadingView'
    s.dependency 'ATCategories'
    s.dependency 'Masonry'
    s.dependency 'YYImage'
    
end
