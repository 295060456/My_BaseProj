
# Uncomment the next line to define a global platform for your project

install!'cocoapods',:deterministic_uuids=>false#解决与私有库的冲突
 platform :ios, '12.2'

target 'My_BaseProj' do
  # Uncomment the next line if you're using Swift or would like to use dynamic frameworks
  # use_frameworks!

  # Pods for My_BaseProj

pod 'SocketRocket'
pod 'FLEX'#调试界面相关插件
pod 'TWPageViewController'
pod 'ReactiveObjC'    #重量级框架
pod 'EAIntroView'#启动图
pod 'Texture' #Facebook
pod 'GKNavigationBarViewController' 
pod 'Masonry' #布局
#pod 'PureLayout'
#pod 'MyLayout'
pod 'AFNetworking'
pod 'Reachability'              #检查联网情况
pod 'MJRefresh'
pod 'MJExtension'    #上拉加载、下拉刷新
pod 'YYKit'#pod 'YYText'
pod 'SDWebImage'
pod 'SDWebImage/WebP'
pod 'IQKeyboardManager'
pod 'OpenUDID'
pod 'ZXingObjC/QRCode'#ZXing是一个开放源码的，用Java实现的多种格式的1D/2D条码图像处理库，目前由Google维护更新
pod 'SGQRCode'#二维码生成、扫描及页面跳转
pod 'DTCoreText'  #解析HTML与CSS最终用CoreText绘制出来，通常用于在一些需要显示富文本的场景下代替低性能的UIWebView
#pod 'MWPhotoBrowser'#一个简单的iOS照片和视频浏览器，带有可选的网格视图，标题和选择
pod 'FDFullscreenPopGesture'#一个丝滑的全屏滑动返回手势
pod 'ZYSuspensionView/SuspensionView'    #悬浮球带点击事件 https://github.com/ripperhe/ZYSuspensionView
pod 'FMDB'     #数据库第三方框架
pod 'WCDB'
pod 'Shimmer'  #Facebook 推出的一款具有闪烁效果的第三方控件
pod 'BEMCheckBox'               #复选框 更炫
pod 'PGBanner'                  #轮播图
pod 'TXScrollLabelView'         #“走马灯”效果
pod 'HCSStarRatingView'         #星级评分显示
pod 'NJKWebViewProgress'        #Web_View进度条
#pod 'MBProgressHUD'
pod 'MBProgressHUD+WJExtension' #基于 MBProgressHUD 的封装、并增加了操作成功与失败的HUD动画与祝贺撒花效果
pod 'SVProgressHUD' #是一个弹出提示层，用来提示 网络加载 或 提示对错
pod 'DDProgressView'            #加载状态显示
pod 'pop'     #动画
pod 'AYCheckVersion'            #提示更新
pod 'UICountingLabel'           #Lable上的默认值持续变动到指定值
pod 'RegexKitLite'  #第三方正则表达式开源库
pod 'AwesomeMenu'
pod 'PYSearch'  #优雅的搜索控制器取代了UISearchController for iOS（iPhone和iPad）
pod 'TTTAttributedLabel'#替代UILabel https://github.com/TTTAttributedLabel/TTTAttributedLabel
pod 'WebViewJavascriptBridge'
pod 'HBDNavigationBar'  #自定义UINavigationBar，用于在各种状态之间平滑切换，包括条形样式，条形色调，背景图像，背景alpha，条形隐藏，标题文本属性，色调颜色，阴影隐藏... https://github.com/listenzz/HBDNavigationBar
pod 'EScrollPageView'#嵌套滚动,分页滚动 https://github.com/EasySnail/EScrollPageView
pod 'JDStatusBarNotification' #网络提示--> 网络监听显示，主要是展示状态
#pod 'HWPanModal'#HWPanModal 用于从底部弹出控制器（UIViewController），并用拖拽手势来关闭控制器。提供了自定义视图大小和位置，高度自定义弹出视图的各个属性。 https://github.com/HeathWang/HWPanModal
#pod 'SearchTextField'
pod 'ZFPlayer' #https://github.com/renzifeng/ZFPlayer
pod 'JXCategoryView'
pod 'LYEmptyView'#https://github.com/dev-liyang/LYEmptyView iOS一行代码集成空白页面占位图(无数据、无网络占位图)
pod 'TZImagePickerController'#https://github.com/banchichen/TZImagePickerController 一个支持多选，选原图和视频的图片选择器，同时有预览，裁剪功能，支持iOS6 +。一个UIImagePickerController的克隆，支持挑选多张照片，原始照片，视频，还允许预览照片和视频，支持iOS6 +
pod 'BRPickerView'
pod 'Reveal-SDK', :configurations => ['Debug']
pod 'MLeaksFinder' #在开发时在iOS应用中查找内存泄漏 https://github.com/Tencent/MLeaksFinder
pod 'JJStockView'#Excel
pod 'CocoaLumberjack'

#视频相关框架
#pod 'ZFPlayer/ControlView'
#pod 'ZFPlayer/AVPlayer'
#pod 'ZFPlayer/ijkplayer'
#pod 'ZFPlayer/KSYMediaPlayer'

#https://github.com/honcheng/PaperFold-for-iOS
#https://github.com/tomaz/appledoc
#https://reactnative.cn/docs/getting-started.html  REACT NATIVE
#https://github.com/BradLarson/GPUImage 一款强大的图片滤镜工具, 支持自定义滤镜, 可用来实时处理图片和视频流
#https://github.com/XVimProject/XVim 一款在 Xcode 上实现了 Vim 功能的插件
#https://github.com/gotosleep/JASidePanels 左右侧滑ViewController

#https://www.jianshu.com/p/71738cbeb146 iOS top100开源框架

  target 'My_BaseProjTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'My_BaseProjUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
