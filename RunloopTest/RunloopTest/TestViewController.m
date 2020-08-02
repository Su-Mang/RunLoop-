//
//  TestViewController.m
//  RunloopTest
//
//  Created by Sumang on 2020/8/1.
//  Copyright © 2020 Sumang. All rights reserved.
//

#import "TestViewController.h"
#import "ViewController.h"
#import "TestThread.h"
@interface TestViewController ()
@property (nonatomic,strong) TestThread * myThread;
@property (nonatomic,assign) BOOL   stopped;
@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    
    [self.view addSubview:button];
    button .backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(stop) forControlEvents:UIControlEventTouchUpInside];
      
    self.view.backgroundColor = [UIColor orangeColor];
    [self blockStartRunloop];
  //  [self targetStartRunloop];
    
}
-(void) addTarget {
     
}
-(void) stop {
    if(!self.myThread)
        return ;
    [self performSelector:@selector(stopThread) onThread:self.myThread withObject:nil waitUntilDone:YES];
}
-(void) targetStartRunloop {
    self.myThread = [[TestThread alloc]initWithTarget:self selector:@selector(start) object:nil];
    [self.myThread start];
}

-(void) blockStartRunloop {
    __weak typeof(self) weakSelf = self;
       self.stopped = NO;
       self.myThread = [[TestThread alloc] initWithBlock:^{

             [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSDefaultRunLoopMode];
           //           NSTimer * timer = [NSTimer timerWithTimeInterval:1.0 repeats:  block:^(NSTimer * _Nonnull timer) {
           //                   NSLog(@"%s", __func__);
           //               }];
           //           [[NSRunLoop currentRunLoop ] addTimer:timer forMode:NSDefaultRunLoopMode];
           //
               NSLog(@"%s, %@", __func__, [NSThread currentThread]);
            while (!weakSelf.stopped&& weakSelf) {
               
           [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
               }

       }];
      [self.myThread start];

}

-(void) stopThread {
    self.stopped = YES;
     CFRunLoopStop(CFRunLoopGetCurrent());
    NSLog(@"%s, %@", __func__, [NSThread currentThread]);
    self.myThread = nil;
}
-(void) start {
      NSLog(@"%s, %@", __func__, [NSThread currentThread]);
    [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc]init] forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop]run];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
   // [self performSelector:@selector(show) onThread:self.myThread withObject:nil waitUntilDone:NO];
    NSLog(@"123");
    [self dismissViewControllerAnimated:NO completion:nil];
    
  
}


 
-(void )show {
     NSLog(@"%s, %@", __func__, [NSThread currentThread]);
     
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)dealloc {
    
    NSLog(@"%s", __func__);
   [self stop];
    self.myThread = nil;

}
@end
