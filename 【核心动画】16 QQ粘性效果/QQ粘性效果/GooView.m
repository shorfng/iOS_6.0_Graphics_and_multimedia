//
//  GooView.m
//  QQ粘性效果
//
//  Created by 蓝田 on 16/7/26.
//  Copyright © 2016年 Loto. All rights reserved.
//

#import "GooView.h"

@interface GooView ()

@property(nonatomic, weak) UIView *smallCircleView;  // 小圆
@property(nonatomic, assign) CGFloat oriSmallRadius; // 小圆半径
@property(nonatomic, weak) CAShapeLayer *shapeLayer; // 不规则矩形

@end

@implementation GooView

#pragma mark - 不规则矩形的懒加载（两圆产生距离才需要绘制）
- (CAShapeLayer *)shapeLayer {
    if (_shapeLayer == nil) {
        CAShapeLayer *layer = [CAShapeLayer layer]; // 创建不规则矩形
        _shapeLayer = layer;
        layer.fillColor = self.backgroundColor.CGColor; // 设置不规则矩形的填充颜色
        
        // 不规则矩形添加按钮的父控件上的layer
        [self.superview.layer insertSublayer:layer below:self.layer];
    }
    
    return _shapeLayer;
}

#pragma mark - 小圆懒加载
- (UIView *)smallCircleView {
    if (_smallCircleView == nil) {
        UIView *view = [[UIView alloc] init];        // 创建
        view.backgroundColor = self.backgroundColor; // 背景色
        _smallCircleView = view;
        
        // 小圆添加按钮的父控件上
        [self.superview insertSubview:view belowSubview:self];
    }
    return _smallCircleView;
}

- (void)awakeFromNib {
    [self setUp];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

#pragma mark - 初始化
- (void)setUp {
    CGFloat w = self.bounds.size.width;
    
    // 记录小圆最初始半径
    _oriSmallRadius = w / 2;
    // 设置最初始圆角半径
    self.layer.cornerRadius = w / 2;
    // 设置小圆的文字颜色
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    // 设置小圆的文字字体大小
    self.titleLabel.font = [UIFont systemFontOfSize:12];
    
    // 添加手势事件（不用touchesBegan,因为会跟按钮监听事件冲突）
    UIPanGestureRecognizer *pan =
    [[UIPanGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(pan:)];
    // 添加手势到控件上
    [self addGestureRecognizer:pan];
    
    // 设置小圆位置、尺寸和圆角半径
    self.smallCircleView.center = self.center;
    self.smallCircleView.bounds = self.bounds;
    self.smallCircleView.layer.cornerRadius = w / 2;
}

// 最大圆心距离
#define kMaxDistance 80

// 计算两个圆心之间的距离
- (CGFloat)circleCenterDistanceWithBigCircleCenter:(CGPoint)bigCircleCenter
                                 smallCircleCenter:(CGPoint)smallCircleCenter {
    
    CGFloat offsetX = bigCircleCenter.x - smallCircleCenter.x; // x2-x1
    CGFloat offsetY = bigCircleCenter.y - smallCircleCenter.y; // y2-y1
    // 开平方得到两个圆心之间的距离
    return sqrt(offsetX * offsetX + offsetY * offsetY);
}

// 描述两圆之间一条矩形路径
- (UIBezierPath *)pathWithBigCirCleView:(UIView *)bigCirCleView
                        smallCirCleView:(UIView *)smallCirCleView {
    
    // 大圆的圆心、x、y、半径
    CGPoint bigCenter = bigCirCleView.center;
    CGFloat x2 = bigCenter.x;
    CGFloat y2 = bigCenter.y;
    CGFloat r2 = bigCirCleView.bounds.size.width / 2;
    
    // 小圆的圆心、x、y、半径
    CGPoint smallCenter = smallCirCleView.center;
    CGFloat x1 = smallCenter.x;
    CGFloat y1 = smallCenter.y;
    CGFloat r1 = smallCirCleView.bounds.size.width / 2;
    
    // 获取圆心距离
    CGFloat d = [self circleCenterDistanceWithBigCircleCenter:bigCenter
                                            smallCircleCenter:smallCenter];
    
    CGFloat sinθ = (x2 - x1) / d;
    CGFloat cosθ = (y2 - y1) / d;
    
    // 坐标系是基于父控件计算的
    CGPoint pointA = CGPointMake(x1 - r1 * cosθ, y1 + r1 * sinθ);
    CGPoint pointB = CGPointMake(x1 + r1 * cosθ, y1 - r1 * sinθ);
    CGPoint pointC = CGPointMake(x2 + r2 * cosθ, y2 - r2 * sinθ);
    CGPoint pointD = CGPointMake(x2 - r2 * cosθ, y2 + r2 * sinθ);
    CGPoint pointO =
    CGPointMake(pointA.x + d / 2 * sinθ, pointA.y + d / 2 * cosθ);
    CGPoint pointP =
    CGPointMake(pointB.x + d / 2 * sinθ, pointB.y + d / 2 * cosθ);
    
    // 1、创建一个路径对象
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    // 2、一个封闭路径（A-B-C-D-A）
    [path moveToPoint:pointA];                             // 起点：A
    [path addLineToPoint:pointB];                          // 添加线AB
    [path addQuadCurveToPoint:pointC controlPoint:pointP]; // 绘制BC曲线
    [path addLineToPoint:pointD];                          // 添加线CD
    [path addQuadCurveToPoint:pointA controlPoint:pointO]; // 绘制DA曲线
    
    // 3、返回path
    return path;
}

- (void)pan:(UIPanGestureRecognizer *)pan {
#warning 移动控件位置
    // 获取手指偏移量
    CGPoint transP = [pan translationInView:self];
    
    // 修改按钮的形变,并不会修改中心点，因此要用下面的方法
    //    self.transform = CGAffineTransformTranslate(self.transform, transP.x,
    //    transP.y);
    
    // 通过修改center的xy，用以修改按钮的形变
    CGPoint center = self.center;
    center.x += transP.x;
    center.y += transP.y;
    
    // 将修改后的参数赋值
    self.center = center;
    
    // 复位
    [pan setTranslation:CGPointZero inView:self];
    
#warning 设置小圆半径（小圆半径随着大小两个圆的圆心的距离不断增加而减小）
    // 计算圆心距离
    CGFloat d = [self
                 circleCenterDistanceWithBigCircleCenter:self.center
                 smallCircleCenter:self.smallCircleView.center];
    
    // 计算小圆的半径（随着圆心距的不断变化而变化）
    CGFloat smallRadius = _oriSmallRadius - d / 10;
    
    // 设置小圆的尺寸（随着小圆半径的不断变化而变化）
    self.smallCircleView.bounds =
    CGRectMake(0, 0, smallRadius * 2, smallRadius * 2);
    
    // 设置小圆的圆角半径（随着小圆半径的不断变化而变化）
    self.smallCircleView.layer.cornerRadius = smallRadius;
    
#warning 绘制不规则矩形
    /*
     遇到的问题：不能通过绘图，因为绘图只能在当前控件上画，超出部分不会显示
     解决方法：展示不规则矩形，通过不规则矩形路径生成一个图层
     */
    
    // 当圆心距离大于最大圆心距离的时候，可以拖出来
    if (d > kMaxDistance) {
        self.smallCircleView.hidden = YES;      // 隐藏小圆
        [self.shapeLayer removeFromSuperlayer]; // 移除不规则的矩形
        self.shapeLayer = nil;                  // 清空不规则的矩形的内容
    } else if (d > 0 && self.smallCircleView.hidden == NO) {
        // 当有圆心距离，并且圆心距离不大的时候，展示不规则矩形
        self.shapeLayer.path =
        [self pathWithBigCirCleView:self smallCirCleView:self.smallCircleView]
        .CGPath;
    }
    
#warning 手指抬起的时候，还原
    if (pan.state == UIGestureRecognizerStateEnded) {
        
        // 当圆心距离大于最大圆心距离的时候，展示gif动画
        if (d > kMaxDistance) {
            // 创建imageView，设置Frame
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
            
            // for循环展示图片
            NSMutableArray *arrM = [NSMutableArray array];
            for (int i = 1; i < 9; i++) {
                UIImage *image =
                [UIImage imageNamed:[NSString stringWithFormat:@"%d", i]];
                [arrM addObject:image];
            }
            
            imageView.animationImages = arrM;   // 将图片添加到数组
            imageView.animationRepeatCount = 1; // 设置动画次数
            imageView.animationDuration = 0.5;  // 设置动画时间
            [imageView startAnimating];         // 开始动画
            [self addSubview:imageView];        // 添加图片
            
            // 延迟0.4s，移除控件
            dispatch_after(
                           dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)),
                           dispatch_get_main_queue(), ^{
                               [self removeFromSuperview];
                           });
            
        } else { // 当圆心距离小于最大圆心距离的时候
            [self.shapeLayer removeFromSuperlayer]; // 移除不规则矩形
            self.shapeLayer = nil; // 清空不规则的矩形的内容
            
            // 当抬起手指的时候，还原位置、显示小圆
            [UIView animateWithDuration:0.5
                                  delay:0
                 usingSpringWithDamping:0.2
                  initialSpringVelocity:0
                                options:UIViewAnimationOptionCurveLinear
                             animations:^{
                                 self.center = self.smallCircleView.center; // 设置大圆中心点位置
                             }
                             completion:^(BOOL finished) {
                                 self.smallCircleView.hidden = NO; // 显示小圆
                             }];
        }
    }
}

@end
