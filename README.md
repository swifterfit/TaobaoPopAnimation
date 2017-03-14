# TaobaoPopAnimation

### 背景介绍

最近公司在做电商项目，大部分是在抄袭淘宝，可能会陆续模仿一下动画效果。

看到淘宝选择规格的凹陷的动画，就想到应该和维度和3D有关系，查了一些CATransform3D的资料。废话不多说，说一下我分解动画的思路步骤和主要代码：

先贴一下最终效果：

![](http://oma38gsun.bkt.clouddn.com/TaobaoPopAnimation.gif)

### 动画原理

##### 先看底层凹陷的动画分解(称为rootView)

- rootView的透视效果，同时缩小并上移一定距离

```
- (CATransform3D)firstTransform {

CATransform3D firstTransform = CATransform3DIdentity;
//透视效果，必须有下面的rotate结合，否则没有效果
firstTransform.m34 = 1.0/-1500;
//缩小的效果
firstTransform = CATransform3DScale(firstTransform, 0.95, 0.95, 1);
//绕x轴旋转
firstTransform = CATransform3DRotate(firstTransform, 15.0 * M_PI/180.0, 1, 0, 0);
//z轴位移
firstTransform = CATransform3DTranslate(firstTransform, 0, 0, -100);

return firstTransform;
}

```

- 为了视觉效果，再次制造透视效果，并且缩小移动，整体3d缩小的感觉。

```
- (CATransform3D)secondTransform {

//恢复
CATransform3D secondTransform = CATransform3DIdentity;
//再来一次透视
secondTransform.m34 = [self firstTransform].m34;
//上移
secondTransform = CATransform3DTranslate(secondTransform, 0, self.rootView.frame.size.height * (-0.08), 0);
//再次缩小
secondTransform = CATransform3DScale(secondTransform, 0.85, 0.75, 1);

return secondTransform;
}

```

##### 再看底部上升视图(称为popView)


-  上升比较容易，主要看动画的时机。我放在了。上面的第2步里面同时进行。

##### 看下接口

```
/**
传入凹陷的rootView和底部弹出的popView

@param rootView 底层凹陷的View
@param popView 底部弹出的View
*/
- (void)startAnimationRootView:(UIView *)rootView andPopView:(UIView *)popView;

```

只需要传入你需要做动画的两个view就好。 

可以把代码中一些参数提出来开放。

### 总结

做这种3d视觉效果的动画，基本上理解`CATransform3D`这个结构体每个成员的意义就差不多了。再配合平时用的scale、translate、等就够用了。 

知识量不多，但是挺有意思的，可以开发很多有创意的animation

### Tips

关于`CATransform3D` 可以参考:

[iOS的三维透视投影](http://geeklu.com/2012/07/ios-3d-perspective/)

[Core Animation之CATransform3D:矩阵变换3D旋转](http://blog.csdn.net/yujianxiang666/article/details/45333741)
