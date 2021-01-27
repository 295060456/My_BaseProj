# Uncomment the next line to define a global platform for your project

# https://juejin.im/post/6844903602146770952 你真的会写Podfile吗？
# https://kemchenj.github.io/2019-05-31/

# 下面两行是指明依赖库的来源地址
source 'https://github.com/CocoaPods/Specs.git'# 使用官方默认地址（默认）
source 'https://github.com/Artsy/Specs.git'# 使用其他来源地址

# install! 只走一次，多次使用只以最后一个标准执行
# deterministic_uuids 解决与私有库的冲突
# generate_multiple_pod_projects 可以让每个依赖都作为一个单独的项目引入，大大增加了解析速度；cocoapods 1.7 以后支持
# disable_input_output_paths ？？？
# 需要特别说明的：在 post_install 时，为了一些版本的兼容，需要遍历所有 target，调整一部分库的版本；但是如果开启了 generate_multiple_pod_projects 的话，由于项目结构的变化，installer.pod_targets 就没办法获得所有 pods 引入的 target 了
install! 'cocoapods',:deterministic_uuids=>false,generate_multiple_pod_projects: true,disable_input_output_paths: true

platform :ios, '13.5' # platform用于指定应建立的静态库的平台
inhibit_all_warnings! # 忽略引入库的所有警告（强迫症者的福音啊）
use_frameworks!

# 特别说明：Ruby对大小写敏感，所以方法名首字母不要用大写，否则执行失败
# 调试框架
def debugPods
  pod 'DoraemonKit' # https://github.com/didi/DoraemonKit 滴滴打车出的工具
  pod 'FLEX'  # https://github.com/Flipboard/FLEX 调试界面相关插件
  pod 'CocoaLumberjack' # https://github.com/CocoaLumberjack/CocoaLumberjack A fast & simple, yet powerful & flexible logging framework for Mac and iOS
  pod 'Reveal-SDK',:configurations => ['Debug']
  pod 'JJException' # https://github.com/jezzmemo/JJException 保护App,一般常见的问题不会导致闪退，增强App的健壮性，同时会将错误抛出来，根据每个App自身的日志渠道记录
  pod 'FBRetainCycleDetector' # https://github.com/facebook/FBRetainCycleDetector
  #  pod 'CocoaDebug' # https://github.com/CocoaDebug/CocoaDebug
  #  pod 'MLeaksFinder'  # 在开发时在iOS应用中查找内存泄漏 https://github.com/Tencent/MLeaksFinder
  #  pod 'FBMemoryProfiler' # https://github.com/facebook/FBMemoryProfiler An iOS library providing developer tools for browsing objects in memory over time, using FBAllocationTracker and FBRetainCycleDetector.
  end
def longConnection
  pod 'CocoaAsyncSocket' # https://github.com/robbiehanson/CocoaAsyncSocket WebSocket的OC框架
  # CocoaAsyncSocket 的学习资料
  # https://juejin.im/post/6844904062408720391#heading-0
  # https://www.jianshu.com/p/9153d5628363
  pod 'MQTTClient' # https://github.com/novastone-media/MQTT-Client-Framework
  pod 'Socket.IO-Client-Swift', '~> 15.2.0' # https://github.com/socketio/socket.io-client-swift Socket.iO
  end
# 几乎每个App都用到的框架
def appCommon
  pod 'ReactiveObjC'  # https://github.com/ReactiveCocoa/ReactiveObjC 重量级框架
  pod 'Masonry' # https://github.com/SnapKit/Masonry 布局
  pod 'AFNetworking' # https://github.com/AFNetworking/AFNetworking A delightful networking framework for iOS, macOS, watchOS, and tvOS.
  pod 'Reachability' # https://github.com/tonymillion/Reachability 检查联网情况
  pod 'YYKit' # https://github.com/ibireme/YYKit A collection of iOS components.
  #pod 'YYText'
  pod 'MJRefresh' # https://github.com/CoderMJLee/MJRefresh An easy way to use pull-to-refresh
  pod 'MJExtension' # https://github.com/CoderMJLee/MJExtension A fast, convenient and nonintrusive conversion framework between JSON and model. Your model class doesn't need to extend any base class. You don't need to modify any model file.
  pod 'SDWebImage'  # https://github.com/SDWebImage/SDWebImage Asynchronous image downloader with cache support as a UIImageView category
  #  pod 'SDWebImageWebPCoder' # https://github.com/SDWebImage/SDWebImageWebPCoder
  pod 'IQKeyboardManager' # https://github.com/hackiftekhar/IQKeyboardManager Codeless drop-in universal library allows to prevent issues of keyboard sliding up and cover UITextField/UITextView. Neither need to write any code nor any setup required and much more.
  pod 'TABAnimated' # https://github.com/tigerAndBull/TABAnimated
  end
## GK一族
def gk
  pod 'GKNavigationBar' # https://github.com/QuintGao/GKNavigationBar GKNavigationBarViewController的分类实现方式，耦合度底，使用更加便捷
  pod 'GKPageScrollView' # https://github.com/QuintGao/GKPageScrollView iOS类似微博、抖音、网易云等个人详情页滑动嵌套效果
  pod 'GKPhotoBrowser' # https://github.com/QuintGao/GKPhotoBrowser iOS仿微信、今日头条等图片浏览器 
  end
## JX一族
def jx
  pod 'JXCategoryView'  # https://github.com/pujiaxin33/JXCategoryView A powerful and easy to use category view (segmentedcontrol, segmentview, pagingview, pagerview, pagecontrol) (腾讯新闻、今日头条、QQ音乐、网易云音乐、京东、爱奇艺、腾讯视频、淘宝、天猫、简书、微博等所有主流APP分类切换滚动视图)
  pod 'JXPagingView/Pager'
  end
## 相册选择
def photoAlbum
  pod 'HXPhotoPicker' # 相册选择 https://github.com/SilenceLove/HXPhotoPicker
  pod 'TZImagePickerController' # 【作者不维护了，慢慢就废弃了】https://github.com/banchichen/TZImagePickerController 一个支持多选，选原图和视频的图片选择器，同时有预览，裁剪功能，支持iOS6 +。一个UIImagePickerController的克隆，支持挑选多张照片，原始照片，视频，还允许预览照片和视频，支持iOS6 +
  #pod 'MWPhotoBrowser'#一个简单的iOS照片和视频浏览器，带有可选的网格视图，标题和选择
  end
## 富文本
def richText
  pod 'DTCoreText'  #https://github.com/Cocoanetics/DTCoreText 解析HTML与CSS最终用CoreText绘制出来，通常用于在一些需要显示富文本的场景下代替低性能的UIWebView 比较麻烦
#  pod 'RZRichTextView' # https://github.com/rztime/RZRichTextView  富文本编辑器
  end
## Label
def label
  pod 'Shimmer' # Facebook 推出的一款具有闪烁效果的第三方控件
  pod 'RQShineLabel'  # https://github.com/zipme/RQShineLabel 一个类似Secret文字渐变效果的开源库
  end
## 开屏广告
def ad
#    pod 'XHLaunchAd' # https://github.com/CoderZhuXH/XHLaunchAd 开屏广告、启动广告解决方案-支持静态/动态图片广告/mp4视频广告
  #  pod 'LBLaunchImageAd' # https://github.com/AllLuckly/LBLaunchImageAd 启动图 未适配iOS 13 拖动到手动Pod自己改
    pod 'FLAnimatedImageView+RGWrapper' # https://github.com/RengeRenge/FLAnimatedImageView-RGWrapper FLAnimatedImage是适用于iOS的高性能动画GIF引擎
  end
## 约束框架
def constraint
  #pod 'PureLayout'
  #pod 'MyLayout'
  end

# 一些UI层自定义的框架
def ui

  gk ## GK一族
  jx ## JX一族
  photoAlbum ## 相册选择
  richText ## 富文本
  label ## Label
  ad ## 开屏广告

  pod 'MGSwipeTableCell' # https://github.com/MortimerGoro/MGSwipeTableCell 滑动tableViewCell
  pod 'TWPageViewController'  # https://github.com/Easence/TWPageViewController 一个支持懒加载的PageViewController，用于替换iOS系统的UIPageViewController。可以用来实现类似腾讯新闻、今日头条的效果
  pod 'UICountingLabel' # https://github.com/dataxpress/UICountingLabel Lable上的默认值持续变动到指定值 Adds animated counting support to UILabel.
  pod 'JJStockView' # https://github.com/jezzmemo/JJStockView Excel iOS股票,课程表,表格控件
  pod 'ZWPullMenuView' # https://github.com/wangziwu/ZWPullMenuView 下拉选择视图、支持微信、支付宝等样式。自动计算最优显示位置、动画效果。
  pod 'WMZBanner' # https://github.com/wwmz/WMZBanner WMZBanner - 最好用的轻量级轮播图+卡片样式+自定义样式
  pod 'HBDNavigationBar'  # https://github.com/listenzz/HBDNavigationBar 自定义UINavigationBar，用于在各种状态之间平滑切换，包括条形样式，条形色调，背景图像，背景alpha，条形隐藏，标题文本属性，色调颜色，阴影隐藏...
  pod 'WXSTransition' # https://github.com/alanwangmodify/WXSTransition 这是一个界面转场动画集。 目前只支持纯代码 已支持手势返回
#  pod 'SDCycleScrollView' # https://github.com/gsdios/SDCycleScrollView
  pod 'TKCarouselView' # https://github.com/libtinker/TKCarouselView
  pod 'BSYKeyBoard' # https://github.com/baishiyun/BSYKeyBoard
  pod 'CWLateralSlide' # https://github.com/ChavezChen/CWLateralSlide
  pod 'LYEmptyView' # https://github.com/dev-liyang/LYEmptyView iOS一行代码集成空白页面占位图(无数据、无网络占位图)
  pod 'SZTextView' # https://github.com/glaszig/SZTextView SZTextView 用于替代内置的 UITextView，实现了 placeholder 功能。打破传统侧滑抽屉框架LeftVC，RightVC，CenterVC模式，使用自定义转场动画实现的0耦合、0侵入、0污染的抽屉框架，抽屉控制器拥有完整的生命周期函数调用，关闭抽屉时抽屉不会展示在我们看不见的地方（屏幕外，或者根控制器下边）,最重要的是简单：只要一行代码就能拥有一个侧滑抽屉。
  pod 'BEMCheckBox' # https://github.com/Boris-Em/BEMCheckBox 复选框 更炫 Tasteful Checkbox for iOS
  pod 'TXScrollLabelView' # https://github.com/tingxins/TXScrollLabelView “走马灯”效果 TXScrollLabelView, the best way to show & display information such as adverts / boardcast / onsale e.g. with a customView.
  pod 'HCSStarRatingView' # https://github.com/hsousa/HCSStarRatingView 星级评分显示 Simple star rating view for iOS written in Objective-C
  pod 'NJKWebViewProgress'  # https://github.com/ninjinkun/NJKWebViewProgress Web_View进度条 UIWebView progress interface
  pod 'DDProgressView'  # https://github.com/ddeville/DDProgressView 加载状态显示 A custom UIProgressView à la Twitter for iPhone
  pod 'pop' # https://github.com/facebookarchive/pop 动画 An extensible iOS and OS X animation library, useful for physics-based interactions.
  pod 'AwesomeMenu' # https://github.com/levey/AwesomeMenu AwesomeMenu is a menu with the same look as the story menu of Path.
  pod 'TTTAttributedLabel'  # https://github.com/TTTAttributedLabel/TTTAttributedLabel 替代UILabel
  pod 'ZFJTreeViewKit'
  pod 'PPBadgeView' #https://github.com/jkpang/PPBadgeView iOS自定义Badge组件, 支持UIView, UITabBarItem, UIBarButtonItem以及子类
  pod 'RDVTabBarController' # https://github.com/robbdimitrov/RDVTabBarController
#  pod 'BRPickerView'  # https://github.com/91renb/BRPickerView 该组件封装的是iOS中常用的选择器组件，主要包括：日期选择器、时间选择器（DatePickerView）、地址选择器（AddressPickerView）、自定义字符串选择器（StringPickerView）。支持自定义主题样式，适配深色模式，支持将选择器组件添加到指定容器视图。
  #  pod 'DZNEmptyDataSet' # https://github.com/dzenbot/DZNEmptyDataSet 空白数据集显示框架
  #  pod 'HWPanModal'#HWPanModal 用于从底部弹出控制器（UIViewController），并用拖拽手势来关闭控制器。提供了自定义视图大小和位置，高度自定义弹出视图的各个属性。 https://github.com/HeathWang/HWPanModal
  #  pod 'SearchTextField'
  #  pod 'Texture' # Facebook出品的一款界面框架  暂时打开会报错 但是还是在更新
end
## 提示相关
def alert
  pod 'TFPopup'# https://github.com/shmxybfq/TFPopup 不耦合view代码,可以为已创建过 / 未创建过的view添加弹出方式;只是一种弹出方式;
  pod 'SPAlertController'# https://github.com/SPStore/SPAlertController 深度定制AlertController
  pod 'WHToast' # https://github.com/remember17/WHToast 一个轻量级的提示控件，没有任何依赖
  # pod 'TRCustomAlert' # https://github.com/troila-mobile/troila-mobie-CustomAlert-iOS
  # pod 'SVProgressHUD' # https://github.com/SVProgressHUD/SVProgressHUD 是一个弹出提示层，用来提示 网络加载 或 提示对错 A clean and lightweight progress HUD for your iOS and tvOS app
end
## 数据库
def database
  pod 'FMDB'  # https://github.com/ccgus/fmdb 数据库第三方框架 A Cocoa / Objective-C wrapper around SQLite
  pod 'WCDB'  # https://github.com/Tencent/wcdb WCDB is a cross-platform database framework developed by WeChat.
  # pod 'FMDB/SQLCipher' # 数据库加解密
  # pod 'LKDBHelper' # https://github.com/li6185377/LKDBHelper-SQLite-ORM
  end
## 二维码相关
def qrCode
  pod 'WSLNativeScanTool' # https://github.com/wsl2ls/ScanQRcode 是在利用原生API的条件下封装的二维码扫描工具，支持二维码的扫描、识别图中二维码、生成自定义颜色和中心图标的二维码、监测环境亮度、打开闪光灯这些功能；WSLScanView是参照微信封装的一个扫一扫界面，支持线条颜色、大小、动画图片、矩形扫描框样式的自定义；这个示例本身就是仿照微信的扫一扫功能实现的。
#  pod 'LBXScan' # https://github.com/MxABC/LBXScan iOS 二维码、条形码
#  pod 'LBXScan/LBXNative'
#  pod 'LBXScan/LBXZXing'
#  pod 'LBXScan/LBXZBar'
#  pod 'LBXScan/UI'
  end
## 视频相关框架
def videoFunc

  pod 'ZFPlayer'  # https://github.com/renzifeng/ZFPlayer Support customization of any player SDK and control layer(支持定制任何播放器SDK和控制层)
  pod 'ZFPlayer/ControlView'
  pod 'ZFPlayer/AVPlayer'
  pod 'ZFPlayer/ijkplayer'
#  pod 'ZFPlayer/KSYMediaPlayer'
#  pod 'KSYMediaPlayer_iOS/KSYMediaPlayer_live' # https://github.com/ksvc/KSYMediaPlayer_iOS 金山云iOS播放SDK（KSYUN Live Streaming player SDK），支持RTMP HTTP-FLV HLS 协议（supporting RTMP HTTP-FLV HLS protocol），直播延时2-3秒（Living delay 2 or 3 seconds
#  pod 'KSYMediaPlayer_iOS'  # https://github.com/ksvc/KSYMediaPlayer_iOS 金山云iOS播放SDK（KSYUN Live Streaming player SDK），支持RTMP HTTP-FLV HLS 协议（supporting RTMP HTTP-FLV HLS protocol），直播延时2-3秒（Living delay 2 or 3 seconds
#  pod 'KSYMediaPlayer_iOS/KSYMediaPlayer_vod'
#  pod 'ksyhttpcache' # https://github.com/ksvc/ksyhttpcache_ios 金山云iOS平台http缓存SDK，可方便地与播放器集成，实现http视频边播放边下载（缓存）功能
  end
## 写的比较好的Demo
def goodDemo
  # pod 'DYVideoCamera' # https://github.com/Sexy-Queen-team/DYVideoCamera DYVideoCamera 是一个适用于 iOS 视频录制组件,可高度定制化和二次开发,特色是支持自定义 比特率, 滤镜, 裁剪, 音乐, 试听音乐实时缓存。
  # https://github.com/wang82426107/SDVideoCamera
  end
# 一些功能性的
def func

  constraint ## 约束框架
  database ## 数据库
  qrCode ## 二维码相关
  videoFunc ## 视频相关框架
  
  pod 'BMLongPressDragCellCollectionView' # https://github.com/liangdahong/BMLongPressDragCellCollectionView
  pod 'SocketRocket'  # https://github.com/facebookarchive/SocketRocket 长连接
  pod 'TXFileOperation' # https://github.com/xtzPioneer/TXFileOperation
  pod 'YQImageCompressor' # https://github.com/976431yang/YQImageCompressor iOS端简易图片压缩工具
  pod 'OpenUDID'  # https://github.com/ylechelle/OpenUDID Open source initiative for a universal and persistent UDID solution for iOS
  pod 'GoogleTagManager'
  pod 'JDStatusBarNotification' # 网络提示--> 网络监听显示，主要是展示状态
  pod 'AYCheckVersion'  # https://github.com/AYJk/AYCheckVersion 提示更新 Check version from AppStore / 从AppStore检查更新
  pod 'JPImageresizerView' # https://github.com/Rogue24/JPImageresizerView 一个专门裁剪图片、GIF、视频的轮子，简单易用，功能丰富（高自由度的参数设定、支持旋转和镜像翻转、蒙版、压缩等），能满足绝大部分裁剪的需求。
  pod 'MSWeakTimer' # https://github.com/mindsnacks/MSWeakTimer Thread-safe NSTimer drop-in alternative that doesn't retain the target and supports being used with GCD queues.
  #  pod 'lottie-ios' # 这个是swift版本
  pod 'lottie-ios', '~> 2.5.3' # 这个是OC版本
  pod 'JSONModel' # https://github.com/jsonmodel/jsonmodel
  pod 'WebViewJavascriptBridge' # https://github.com/marcuswestin/WebViewJavascriptBridge An iOS/OSX bridge for sending messages between Obj-C and JavaScript in UIWebViews/WebViews  JS < —— > OC
end

# 基础的公共配置
def cocoPodsConfig
  target 'My_BaseProjTests' do
    inherit! :search_paths # abstract! 指示当前的target是抽象的，因此不会直接链接Xcode target。与其相对应的是 inherit！
    # Pods for testing
    end

  target 'My_BaseProjUITests' do
    inherit! :search_paths
    # Pods for testing
    end

  # 当我们下载完成，但是还没有安装之时，可以使用hook机制通过pre_install指定要做更改，更改完之后进入安装阶段。 格式如下：
  pre_install do |installer|
      # 做一些安装之前的更改
    end

  # 这个是cocoapods的一些配置,官网并没有太详细的说明,一般采取默认就好了,也就是不写.
  post_install do |installer|
    installer.pods_project.targets.each do |target|

      # 当我们安装完成，但是生成的工程还没有写入磁盘之时，我们可以指定要执行的操作。 比如，我们可以在写入磁盘之前，修改一些工程的配置：

      puts "!!!! #{target.name}"
      end
    end
  end

target 'My_BaseProj' do
  # Pods for My_BaseProj

  debugPods
  longConnection
  appCommon
  ui
  alert
  func

#  cocoPodsConfig
end

#https://github.com/honcheng/PaperFold-for-iOS
#https://github.com/tomaz/appledoc
#https://reactnative.cn/docs/getting-started.html  REACT NATIVE
#https://github.com/BradLarson/GPUImage 一款强大的图片滤镜工具, 支持自定义滤镜, 可用来实时处理图片和视频流
#https://github.com/XVimProject/XVim 一款在 Xcode 上实现了 Vim 功能的插件
#https://github.com/gotosleep/JASidePanels 左右侧滑ViewController

#https://www.jianshu.com/p/71738cbeb146 iOS top100开源框架
