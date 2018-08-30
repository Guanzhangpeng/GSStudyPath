##                                             Github 点个赞↑👍 感谢您的支持!
## 主要功能列表

### 引导页

**一句代码集成图片引导页**

```objc
  [GSIntroductionView sharedWithImages:@[@"user_guid1",@"user_guid2",@"user_guid3"]];
```


### UISearchController搜索框

![](https://github.com/Guanzhangpeng/GSStudyPath/blob/master/IMAGES/QQ20180822-200817.gif)

![](https://github.com/Guanzhangpeng/GSStudyPath/blob/master/IMAGES/QQ20180825-163629.gif)

![](https://github.com/Guanzhangpeng/GSStudyPath/blob/master/IMAGES/QQ20180830-101350.gif)

### UICollectionView

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


## 本仓库会持续更新，我会将工作和学习中遇到的问题和效果总结到该仓库中，希望得到你们的喜欢👍 谢谢


