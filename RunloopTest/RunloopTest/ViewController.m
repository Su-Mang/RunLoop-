//
//  ViewController.m
//  RunloopTest
//
//  Created by Sumang on 2020/8/1.
//  Copyright © 2020 Sumang. All rights reserved.
//

#import "ViewController.h"
#import "TestThread.h"
#import "TestViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    TestViewController * testViewController  = [[TestViewController alloc] init];
         testViewController.modalPresentationStyle  = UIModalPresentationFullScreen;
       [self presentViewController:testViewController animated:NO completion:nil];
}
-(void) Test {
    
    //添加Source\Timer\Observer
           [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSDefaultRunLoopMode];
//           NSTimer * timer = [NSTimer timerWithTimeInterval:1.0 repeats:  block:^(NSTimer * _Nonnull timer) {
//                   NSLog(@"%s", __func__);
//               }];
//           [[NSRunLoop currentRunLoop ] addTimer:timer forMode:NSDefaultRunLoopMode];
//
    NSLog(@"%s, %@", __func__, [NSThread currentThread]);
     [[NSRunLoop currentRunLoop] run];
    
}









- (void )  nstimerTest {
    UITextView * textview = [[UITextView alloc] initWithFrame:CGRectMake(100, 200, 200, 50) ];
       [self.view addSubview:textview];
       textview.text = @"1238ajskdhd abckjabsckjasbciuagfcihasdihasiudhasnbkduyuhgasdbjhaksduiasdhkjasdhjuiusadnkjasdasdasdaasdasd";
       static int count = 0;
       NSTimer * timer = [NSTimer timerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
           NSLog(@"%d", ++count);
       }];
      // [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
     //  [[NSRunLoop currentRunLoop] addTimer:timer forMode:UITrackingRunLoopMode];
       [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}


- (void)dealloc {
    NSLog(@"%s", __func__);

}
@end
