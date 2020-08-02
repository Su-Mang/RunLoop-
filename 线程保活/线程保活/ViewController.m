//
//  ViewController.m
//  线程保活
//
//  Created by Sumang on 2020/8/2.
//  Copyright © 2020 Sumang. All rights reserved.
//

#import "ViewController.h"
#import "TestViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self presentViewController:[[TestViewController alloc]init] animated:NO completion:nil];
}


@end
