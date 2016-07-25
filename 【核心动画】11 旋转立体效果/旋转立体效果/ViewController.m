//
//  ViewController.m
//  旋转立体效果
//
//  Created by 蓝田 on 16/7/21.
//  Copyright © 2016年 Loto. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(weak, nonatomic) IBOutlet UIImageView *topView;
@property(weak, nonatomic) IBOutlet UIImageView *bottomView;
@property(weak, nonatomic) IBOutlet UIView *dragView;  // 手势拖动的 View
@property(weak, nonatomic) CAGradientLayer *gradientL; // 渐变图层
@end

@implementation ViewController

// 快速把两个控件拼接成一个完整图片
- (void)viewDidLoad {
  [super viewDidLoad];
  // 通过设置contentsRect可以设置图片显示的尺寸，取值0~1
  _topView.layer.contentsRect = CGRectMake(0, 0, 1, 0.5);
  _topView.layer.anchorPoint = CGPointMake(0.5, 1);

  _bottomView.layer.contentsRect = CGRectMake(0, 0.5, 1, 0.5);
  _bottomView.layer.anchorPoint = CGPointMake(0.5, 0);

  // 添加手势
  UIPanGestureRecognizer *pan =
      [[UIPanGestureRecognizer alloc] initWithTarget:self
                                              action:@selector(pan:)];

  [_dragView addGestureRecognizer:pan];

#pragma mark - 阴影效果(当折叠图片的时候，底部应该有个阴影渐变过程)（利用CAGradientLayer渐变图层，制作阴影效果，添加到底部视图上，并且一开始需要隐藏，在拖动的时候慢慢显示出来。颜色应是由 透明到黑色 渐变,表示阴影从无到有）
  // 创建渐变图层
  CAGradientLayer *gradientL = [CAGradientLayer layer];

  // 设置渐变颜色
  gradientL.colors =
      @[ (id)[UIColor clearColor].CGColor, (id)[UIColor blackColor].CGColor ];

  // 设置尺寸
  gradientL.frame = _bottomView.bounds;

  _gradientL = gradientL;

  // 设置图层透明色为不透明
  gradientL.opacity = 0;

  // 设置渐变定位点（决定渐变的范围）
  //    gradientL.locations = @[@0.1,@0.4,@0.5];

  // 设置渐变开始点，取值0~1（决定渐变的方向）
  //    gradientL.startPoint = CGPointMake(0, 1);

  [_bottomView.layer addSublayer:gradientL];
}

#pragma mark - 拖动的时候旋转上部分内容
- (void)pan:(UIPanGestureRecognizer *)pan {
  // 获取手指偏移量
  CGPoint transP = [pan translationInView:_dragView];

  // 初始化形变
  CATransform3D transfrom = CATransform3DIdentity;

  // 设置立体效果,增加旋转的立体感，给形变设置m34属性,近大远小
  //  -1 / z,z表示观察者在z轴上的值,表示距图层的距离:z越小,离我们越近，东西越大
  transfrom.m34 = -1 / 500.0; // 第二个数

  // 计算折叠角度，因为往下逆时针旋转，所以取反
  CGFloat angle = -transP.y / 200.0 * M_PI;

  // 开始旋转
  transfrom = CATransform3DRotate(transfrom, angle, 1, 0, 0);

  _topView.layer.transform = transfrom;

  // 设置阴影效果
  // 在拖动的时候计算不透明度值，假设拖动200，阴影完全显示，不透明度应该为1，因此opacity=y轴偏移量*1/200.0;
  _gradientL.opacity = transP.y * 1 / 200.0;

#pragma mark - 反弹效果(当手指抬起的时候，应该把折叠图片还原，其实就是把形变清空)
  // 当手指抬起的时候，设置弹簧效果的动画
  if (pan.state == UIGestureRecognizerStateEnded) {
    // 弹簧效果的动画
    [UIView animateWithDuration:0.6
        delay:0
        usingSpringWithDamping:0.2 // 弹性系数:越小，弹簧效果越明显
        initialSpringVelocity:10   // 弹簧的初始速度
        options:UIViewAnimationOptionCurveEaseInOut // 动画效果：快入快出
        animations:^{
          _topView.layer.transform = CATransform3DIdentity; // 初始化形变量
          _gradientL.opacity = 0;                           // 还原阴影
        }
        completion:^(BOOL finished){

        }];
  }
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
