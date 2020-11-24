#  系统Nav
和tabbarVC一样，会将VC顶起来
self.navigationController.navigationBar.hidden = YES;//导航栏还在只是bar被隐藏了，所以VC在视图的样子是保持顶起
[self.navigationController setNavigationBarHidden:YES animated:NO];//整个导航栏（包括bar）全部隐藏，VC是全屏

