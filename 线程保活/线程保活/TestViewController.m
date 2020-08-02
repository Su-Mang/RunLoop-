//
//  TestViewController.m
//  线程保活
//
//  Created by Sumang on 2020/8/2.
//  Copyright © 2020 Sumang. All rights reserved.
//

#import "TestViewController.h"
#import "MyThread.h"
@interface TestViewController ()
@property(nonatomic, strong) MyThread * myThread;
@property(nonatomic, assign) BOOL isStop;
@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self  creatUI];
    [self BlockcreatMyThread];
    
    
}
-(void) BlockcreatMyThread {
    __weak  typeof(self) weakself = self;
    self.isStop = NO;
    self.myThread = [[MyThread alloc] initWithBlock:^{
       // [weakself start];
        
        [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc]init] forMode:NSDefaultRunLoopMode];
        
          // [[NSRunLoop currentRunLoop] run];
        while (!weakself.isStop&&weakself) {
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        }
    }];
    [self.myThread start];
}
    
-(void) cBlockcreatMyThread {
    __weak  typeof(self) weakself = self;
    self.isStop = NO;
    self.myThread = [[MyThread alloc] initWithBlock:^{
       // [weakself start];
       
     
        
          // [[NSRunLoop currentRunLoop] run];
        while (!weakself.isStop&&weakself) {
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        }
    }];
    [self.myThread start];
}
-(void) TargetcreatMyThread {
   
    self.myThread = [[MyThread alloc] initWithTarget:self selector:@selector(start) object:nil];
     [self.myThread start];
}
 

-(void) start {
    [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc]init] forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop] run];
   
}

-(void) creatUI {
    UIButton * cancleButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 100, 50, 50)];
       [self.view addSubview:cancleButton];
       [cancleButton addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
    [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
       
       UIButton * addButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 200, 50, 50)];
       [self.view addSubview:addButton];
          [addButton addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
    [addButton setTitle:@"添加" forState:UIControlStateNormal];
    self.view.backgroundColor = [UIColor orangeColor];
}

-(void) add {
    [self performSelector:@selector(show) onThread:self.myThread withObject:nil waitUntilDone:NO];
}

-(void)show {
     NSLog(@"%s,%@",__func__,[NSThread currentThread]);
}


-(void) cancle
{
    [self performSelector:@selector(__stop) onThread:self.myThread withObject:nil waitUntilDone:YES];
    
}

-(void)__stop {
    self.isStop = YES;
    CFRunLoopStop(CFRunLoopGetCurrent());
    self.myThread = nil;
}
- (void)dealloc
{
    NSLog(@"%s", __func__);
    [self cancle];
   
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:NO completion:nil];
   // self.myThread = nil;
}

@end
/*
 @interface ViewController ()
 @property (strong, nonatomic) TAYThread *aThread;
 @property (assign, nonatomic, getter=isStoped) BOOL stopped;

 @end

 @implementation ViewController

 - (void)viewDidLoad {
     [super viewDidLoad];
     // 添加一个停止RunLoop的按钮
     UIButton *stopButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
     [self.view addSubview:stopButton];
     stopButton.frame = CGRectMake(180, 180, 100, 50);
     stopButton.titleLabel.font = [UIFont systemFontOfSize:20];
     [stopButton setTitle:@"stop" forState:UIControlStateNormal];
     stopButton.tintColor = [UIColor blackColor];
     [stopButton addTarget:self action:@selector(stop) forControlEvents:UIControlEventTouchUpInside];
     
     self.stopped = NO;
     __weak typeof(self) weakSelf = self;
     self.aThread = [[TAYThread alloc] initWithBlock:^{
         NSLog(@"go");
         [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSDefaultRunLoopMode];
         while (!weakSelf.isStoped) {
             [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
         }
         NSLog(@"ok");
     }];
     [self.aThread start];
 }

 - (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
     [self performSelector:@selector(doSomething) onThread:self.aThread withObject:nil waitUntilDone:NO];
 }

 // 子线程需要执行的任务
 - (void)doSomething {
     NSLog(@"%s %@", __func__, [NSThread currentThread]);
 }

 - (void)stop {
     // 在子线程调用stop
     [self performSelector:@selector(stopThread) onThread:self.aThread withObject:nil waitUntilDone:YES];
 }

 // 用于停止子线程的RunLoop
 - (void)stopThread {
     // 设置标记为NO
     self.stopped = YES;
     
     // 停止RunLoop
     CFRunLoopStop(CFRunLoopGetCurrent());
     NSLog(@"%s %@", __func__, [NSThread currentThread]);
 }

 - (void)dealloc {
     NSLog(@"%s", __func__);
 }


*/
