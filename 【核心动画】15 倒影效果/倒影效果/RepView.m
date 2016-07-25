//
//  RepView.m
//  倒影效果
//
//  Created by 蓝田 on 16/7/25.
//  Copyright © 2016年 Loto. All rights reserved.
//

#import "RepView.h"

@implementation RepView

// 设置控件主层的类型
+ (Class)layerClass {
  return [CAReplicatorLayer class]; // 设置为复制层
}

@end
