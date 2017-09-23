//
//  CivetShakeView.m
//  CivetShake
//
//  Created by fox on 16/5/16.
//  Copyright © 2016年 bruceyou. All rights reserved.
//

#import "CivetShakeView.h"
//添加  这是动画两个类
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>
@interface CivetShakeView (){
    UIActivityIndicatorView* AILoad;
    SystemSoundID            soundID;
}
@property (retain, nonatomic) IBOutlet UIImageView *imgUp;
@property (retain, nonatomic) IBOutlet UIImageView *imgDown;
@end

@implementation CivetShakeView

- (void)viewDidLoad {
    [super viewDidLoad];
     self.navigationItem.title=@"香信摇一摇";
    //设置导航栏背景所有
    self.navigationController.navigationBar.barTintColor=[UIColor purpleColor];
    //UIImageView *imgUp = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height/2)];
   // self.imgUp.frame=CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height/2);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) viewWillAppear:(BOOL)animated
{//注册第一响应事件
    [self  resignFirstResponder];
    [super viewWillAppear:animated];
}
- (void)viewDidAppear:(BOOL)animated
{//设置第一响应事件
    [super viewDidAppear:animated];
    [self  becomeFirstResponder];
}
-(BOOL)canBecomeFirstResponder
{
    return YES;
}
#pragma mark  摇一摇
- (void) motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{//摇一摇事件响应
    if (motion == UIEventSubtypeMotionShake) {
        NSLog(@"摇一摇开启");
        AILoad.hidden=NO;
       [AILoad startAnimating];
       [self   addAnimations];
    }
}
//摇一摇结束之后 处理摇一摇之后的信息  比如 展示搜索到的联系人
- (void)motionEnded:(UIEventSubtype)motion withEvent:(nullable UIEvent *)event {
       NSLog(@"摇一摇结束");
//            if(motion==UIEventSubtypeMotionShake)
//            {
//        
//            //添加
//            [self addAnimations];
//            //添加
//            AudioServicesPlaySystemSound (soundID);
//                
//            }
//
}
#pragma mark  摇一摇 动画开始
- (void)addAnimations
{
   // Animation method  1 animateWithDuration
//    [UIView animateWithDuration:0.4 animations:^{
//        self.imgUp.frame = CGRectMake(0, -40, self.imgUp.frame.size.width, self.imgUp.frame.size.height);
//    }];
//    
//    [UIView animateWithDuration:0.4 animations:^{
//        self.imgDown.frame = CGRectMake(0, self.imgDown.frame.origin.y+40, self.imgDown.frame.size.width, self.imgDown.frame.size.height);
//    }];
//
// Animation method  2  CABasicAnimation
    
    
    AudioServicesPlaySystemSound (soundID);
    //让imgup上下移动
    CABasicAnimation *move2 = [CABasicAnimation animationWithKeyPath:@"position"];
    move2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //这里的X Y 是图片的中心位置吧
    move2.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.imgUp.frame.size.width/2, self.view.frame.size.height/4)];
    NSLog(@"imgUp的x=%lf,y=%lf",self.imgUp.frame.size.width,self.imgUp.frame.size.height);
    move2.toValue =   [NSValue valueWithCGPoint:CGPointMake(self.imgUp.frame.size.width/2,  self.view.frame.size.height/4-100)];
    move2.duration = 0.7;
    move2.repeatCount = 1;
    move2.autoreverses = YES;
    move2.delegate=self;
   [self.imgUp.layer   addAnimation:move2  forKey:@"callmove2"];
    
    
    //让imagdown上下移动
    CABasicAnimation *move1 = [CABasicAnimation animationWithKeyPath:@"position"];
    move1.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    move1.fromValue  = [NSValue valueWithCGPoint:CGPointMake(self.imgDown.frame.size.width/2, self.view.frame.size.height*3/4)];
    move1.toValue =    [NSValue valueWithCGPoint:CGPointMake(self.imgDown.frame.size.width/2, self.view.frame.size.height*3/4+100)];
  
        NSLog(@"imgDown的x=%lf,y=%lf",self.imgDown.frame.size.width,self.imgDown.frame.size.height);
    move1.duration = 0.7;
    move1.repeatCount = 1;
    move1.autoreverses = YES;
    move1.delegate=self;
    //最后一步是 添加动画到对应图层  给move1   取一个叫callmove1的名称
    [self.imgDown.layer addAnimation:move1  forKey:@"callmove1"];

    [AILoad stopAnimating];
    AILoad.hidden=YES;
    NSLog(@"摇一摇动画");
}

//代理 动画的监听
#pragma mark 动画开始
- (void)animationDidStart:(CAAnimation *)anim {
       NSLog(@"动画开始了");
     }

#pragma mark 动画结束
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
        // 查看一下动画执行完毕后的position值
        // NSString *string = NSStringFromCGPoint(imgDown.layer.position);
      //   NSLog(@"动画结束了，position:%@", string);
    //  NSLog(@"动画结束了");
    //动画执行完毕，打印执行完毕后的position值
       //  NSString *str=NSStringFromCGPoint(self.move2.position);
     //   NSLog(@"执行后：%@",str);
    
     }
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
