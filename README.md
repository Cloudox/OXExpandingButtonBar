# OXExpandingButtonBar
OXExpandingButtonBar是一个弹出按钮的控件。首先有一个主按钮，点击主按钮后，主按钮旋转，并向上弹出一串子按钮。弹出时子按钮会旋转，并且到达最终位置后还会反弹一下，还是挺萌的哈哈。再次点击主按钮，主按钮会反向旋转回来，子按钮也会向下反向旋转着收回来。

这里的主按钮和子按钮都是在本控件外自行设置的，所以子按钮的响应方法也可以方便地在自己的ViewController里设置。在初始化本控件前，要创建主按钮和子按钮数组。可以查看我的示例看看怎么使用，还是挺简单的~

## 效果图
![未展开时](https://github.com/Cloudox/OXExpandingButtonBar/blob/master/ExpandingButtonNot.jpg) ![展开时](https://github.com/Cloudox/OXExpandingButtonBar/blob/master/ExpandingButtonExpanded.jpg)
## 导入
只用复制OXExpandingButtonBar.h和OXExpandingButtonBar.m文件到你的工程中，就可以进入import调用了，很方便。

## 使用
首先要对控件进行初始化，上面也说了，所有的按钮都是在初始化本控件之前需要自己创建的，直接在ViewController里，创建你的主按钮和所有子按钮，子按钮放到一个数组里面，在这个过程中你的子按钮的响应方法也就可以自行设置了。然后还要设置一个CGPoint变量，用于对按钮位置进行定位。

```objective-c
/**
 * 初始化bar
 * 参数：mainButton:主按钮；buttons：子按钮数组；center：中心点
**/
- (id) initWithMainButton:(UIButton*)mainButton
                  buttons:(NSArray*)buttons
                   center:(CGPoint)center;
```

也可以使用这个方法来从别的地方展开或收起子按钮串：

```objective-c
/**
 * 展开子按钮
 **/
- (void)showButtonsAnimated;

/**
 * 收起子按钮
 **/
- (void) hideButtonsAnimated;
```

## 自定义
有一些属性可以自行定义，这部分也在不停考虑和增加中，有建议的可以告诉我~  
已实现定义方法如下：

```objective-c
- (void)setMainRotate:(float)rotate;
```
设置展开时主按钮旋转到的角度。


```objective-c
- (void)setMainReRotate:(float)rotate;
```
设置收起时主按钮旋转到的角度。


```objective-c
- (void)setSpin:(BOOL)b;
```
设置弹出子按钮时是否旋转子按钮。
