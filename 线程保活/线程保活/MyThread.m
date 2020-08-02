//
//  MyThread.m
//  线程保活
//
//  Created by Sumang on 2020/8/2.
//  Copyright © 2020 Sumang. All rights reserved.
//

#import "MyThread.h"

@implementation MyThread
- (void)dealloc
{
    NSLog(@"%s", __func__);
}
@end
