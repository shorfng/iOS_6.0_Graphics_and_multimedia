//
//  ViewController.m
//  钟表动画
//
//  Created by 蓝田 on 16/7/15.
//  Copyright © 2016年 Loto. All rights reserved.
//

#define kClockW _clockView.bounds.size.width

#define angle2radion(a) ((a) / 180.0 * M_PI) // 角度转弧度
#define perSecondA 6                         // 一秒钟秒针转6°
#define perMinuteA 6                         // 一分钟分针转6°
#define perHourA 30                          // 一小时时针转30°

// 每分钟时针转多少度
#define perMinuteHourA 0.5

#import "ViewController.h"

@interface ViewController ()
@property(weak, nonatomic) IBOutlet UIImageView *clockView;
@property(nonatomic, weak) CALayer *secondLayer; // 秒针
@property(nonatomic, weak) CALayer *minuteLayer; // 分针
@property(nonatomic, weak) CALayer *hourLayer;   // 时针
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  [self setUpHourLayer];   // 添加时针
  [self setUpMinuteLayer]; // 添加分针
  [self setUpSecondLayer]; // 添加秒针

  // 方式1：NSTimer定时器
//  [NSTimer scheduledTimerWithTimeInterval:1
//                                   target:self
//                                 selector:@selector(timeChange)
//                                 userInfo:nil
//                                  repeats:YES];
//
//  [self timeChange];

  // 方法2：CADisplayLink（link默认是1/60 秒执行一次）
  CADisplayLink *link =
      [CADisplayLink displayLinkWithTarget:self selector:@selector(timeChange)];
  //执行定时器 把定时器放在主运行循环中执行
  [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

// 获取当前的系统的时间
- (void)timeChange {
  // 获取当前日历对象
  NSCalendar *calendar = [NSCalendar currentCalendar];

  // 获取日期的组件：年月日时分秒
  // components:需要获取的日期组件   fromDate：获取哪个日期的组件
  // 经验：以后枚举中有移位运算符，通常一般可以使用并运算（|）
  NSDateComponents *cmp =
      [calendar components:NSCalendarUnitSecond | NSCalendarUnitMinute |
                           NSCalendarUnitHour
                  fromDate:[NSDate date]]; // 获取当前日期的组件

  // 获取秒
  NSInteger second = cmp.second;
  // 获取分
  NSInteger minute = cmp.minute;
  // 获取小时
  NSInteger hour = cmp.hour;

  // 计算秒针转多少度
  CGFloat secondA = second * perSecondA;
  // 计算分针转多少度
  CGFloat minuteA = minute * perMinuteA;
  // 计算时针转多少度
  CGFloat hourA = hour * perHourA + minute * perMinuteHourA;

  // 旋转秒针
  _secondLayer.transform =
      CATransform3DMakeRotation(angle2radion(secondA), 0, 0, 1);
  // 旋转分针
  _minuteLayer.transform =
      CATransform3DMakeRotation(angle2radion(minuteA), 0, 0, 1);
  // 旋转小时
  _hourLayer.transform =
      CATransform3DMakeRotation(angle2radion(hourA), 0, 0, 1);
}

#pragma mark - 添加秒针
- (void)setUpSecondLayer {
  // 创建秒针
  CALayer *secondL = [CALayer layer];

  // 秒针背景色
  secondL.backgroundColor = [UIColor redColor].CGColor;

  // 设置锚点
  secondL.anchorPoint = CGPointMake(0.5, 1);
  // 设置位置
  secondL.position = CGPointMake(kClockW * 0.5, kClockW * 0.5);
  // 设置 bounds
  secondL.bounds = CGRectMake(0, 0, 1, kClockW * 0.5 - 20);

  // 添加到 view 上
  [_clockView.layer addSublayer:secondL];

  _secondLayer = secondL;
}

#pragma mark - 添加分针
- (void)setUpMinuteLayer {
  // 创建分针
  CALayer *layer = [CALayer layer];

  // 分针背景色
  layer.backgroundColor = [UIColor blackColor].CGColor;

  // 设置锚点
  layer.anchorPoint = CGPointMake(0.5, 1);
  // 设置位置
  layer.position = CGPointMake(kClockW * 0.5, kClockW * 0.5);
  // 设置 bounds
  layer.bounds = CGRectMake(0, 0, 4, kClockW * 0.5 - 20);
  // 设置圆角半径
  layer.cornerRadius = 4;

  [_clockView.layer addSublayer:layer];

  _minuteLayer = layer;
}

#pragma mark - 添加时针
- (void)setUpHourLayer {
  // 创建时针
  CALayer *layer = [CALayer layer];

  layer.backgroundColor = [UIColor blackColor].CGColor;

  // 设置锚点
  layer.anchorPoint = CGPointMake(0.5, 1);

  layer.position = CGPointMake(kClockW * 0.5, kClockW * 0.5);

  layer.bounds = CGRectMake(0, 0, 4, kClockW * 0.5 - 40);

  layer.cornerRadius = 4;

  [_clockView.layer addSublayer:layer];

  _hourLayer = layer;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
