##                                             Github 点个赞↑👍 感谢您的支持!
## 主要功能列表

### 一.引导页

**一句代码集成图片引导页**

```objc
  [GSIntroductionView sharedWithImages:@[@"user_guid1",@"user_guid2",@"user_guid3"]];
```
### 二.SegmentBar

**SegmentBar 类似网易新闻 今日头条的标题栏 集成超级简单方便**

```objc
     ZPSegmentView * segmentView=[[ZPSegmentView alloc] initWithFrame:frame];
    [segmentView setupWithtitles:@[@"汽车",@"美女",@"头条",@"财经新闻"] style:style childVcs:@[控制器] parentVc:self];
    [self.view addSubview:segmentView];
```
然后我们可以为`SegmentBar`指定自己想要的样式:

```objc
    ZPSegmentBarStyle * style=[[ZPSegmentBarStyle alloc] init];
    style.isScrollEnabled=NO;//导航条是否可以滚动,默认YES;
    style.isShowCover=YES;//导航条是否显示遮盖效果,默认YES;
    style.coverViewMargin=6;//遮盖间距;
    style.isShowBottomLine=YES;//导航条下方是否显示BottomLine,默认YES;
    style.bottomLineColor=[UIColor orangeColor];//BottomLine 的颜色;
    style.isNeedScale=YES;//导航条是否有放大效果,默认YES;
```
效果图如下:

![](https://github.com/Guanzhangpeng/GSStudyPath/blob/master/IMAGES/QQ20180830-131055.gif)
### 三.UISearchController搜索框

![](https://github.com/Guanzhangpeng/GSStudyPath/blob/master/IMAGES/QQ20180822-200817.gif)

![](https://github.com/Guanzhangpeng/GSStudyPath/blob/master/IMAGES/QQ20180825-163629.gif)

![](https://github.com/Guanzhangpeng/GSStudyPath/blob/master/IMAGES/QQ20180830-101350.gif)

### 四.UICollectionView

**无限循环轮播两句代码即可调用:**

```objc
    GSInfiniteView *infiniteView = [[GSInfiniteView alloc] initWithFrame:CGRectMake(0, 64, SCREENSIZE.width, 280)];
    infiniteView.imgArray = @[@"1",@"2",@"3",@"4",@"5"];//图片数组
    infiniteView.desArray = @[@"第十六届",@"还是到了发生了",@"胜利大街分类数据得浪费",@"胜利大街菲利斯佛罗伦萨的积分老师讲东方闪电",@"东山街道解放路围殴我可是绝大部分快睡吧达芙妮"];//描述数组
    infiniteView.imgClick = ^(NSInteger index) {
        NSLog(@"点击了第 %ld 张图片",index);
    };
    [self.view addSubview:infiniteView];
```

![](http://om62rgcp0.bkt.clouddn.com/15355979341848.jpg)

**自定义布局:**

![QQ20180830-105947](http://om62rgcp0.bkt.clouddn.com/QQ20180830-105947.gif)


**瀑布流效果**

![](http://om62rgcp0.bkt.clouddn.com/15355982569381.jpg)

### 五.UITableView

**QQ好友列表**

![](https://github.com/Guanzhangpeng/GSStudyPath/blob/master/IMAGES/qqfrends.png)

**可拉伸头部控件**

![](https://github.com/Guanzhangpeng/GSStudyPath/blob/master/IMAGES/可拉伸头部控件.gif)

## 本仓库会持续更新，我会将工作和学习中遇到的问题和效果总结到该仓库中，希望得到你们的喜欢👍 谢谢


