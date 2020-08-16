//
//  ViewController.m
//  testCa
//
//  Created by 陈列 on 2020/5/26.
//  Copyright © 2020 cl. All rights reserved.
//

#import "ViewController.h"
#import "LFCameraResultView.h"
#import "LFCamera.h"

@interface ViewController ()
@property (strong, nonatomic) LFCamera *lfCamera;
@property (strong, nonatomic) LFCameraResultView *resultView;//结果view
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //test github
    
    //本界面可以随便怎么设计，我这里只做个粗糙版。核心是LFCamera
    
    self.lfCamera = [[LFCamera alloc] initWithFrame:self.view.bounds];
    [self.lfCamera switchCamera:YES];
    //拍摄有效区域（可不设置，不设置则不显示遮罩层和边框）
    self.lfCamera.effectiveRect = CGRectMake(20, 200, self.view.frame.size.width - 40, 280);
    
    [self.view insertSubview:self.lfCamera atIndex:0];
    
    
    
    
    UIButton *take=[UIButton buttonWithType:UIButtonTypeSystem];
    [take setTitle:@"picture" forState:UIControlStateNormal];
    [take setBackgroundColor:[UIColor orangeColor]];
    [take setFrame:CGRectMake(CGRectGetWidth(self.view.frame)/2-50, CGRectGetHeight(self.view.frame)-100, 100, 50)];
    [take addTarget:self action:@selector(takePhoto:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:take];
    
    //    self.view.backgroundColor = [UIColor orangeColor];
    //
    //        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    //
    //        CGFloat centerX = self.view.center.x;
    //        CGFloat centerY = self.view.center.y;
    //
    //        UIBezierPath *bezierpath = [UIBezierPath bezierPath];
    //        [bezierpath moveToPoint:CGPointMake(centerX + 50, centerY)];
    //        [bezierpath addCurveToPoint:CGPointMake(centerX, centerY - 50) controlPoint1:CGPointMake(centerX + 50, centerY) controlPoint2:CGPointMake(centerX + 50, centerY - 50)];
    //        [bezierpath addCurveToPoint:CGPointMake(centerX - 50, centerY) controlPoint1:CGPointMake(centerX, centerY - 50) controlPoint2:CGPointMake(centerX - 50, centerY - 50)];
    //        [bezierpath addCurveToPoint:CGPointMake(centerX, centerY + 50) controlPoint1:CGPointMake(centerX - 50, centerY) controlPoint2:CGPointMake(centerX - 50, centerY + 50)];
    //        [bezierpath addCurveToPoint:CGPointMake(centerX + 50, centerY - 0.00001) controlPoint1:CGPointMake(centerX, centerY + 50) controlPoint2:CGPointMake(centerX + 50, centerY + 50)];
    //
    //        [bezierpath addLineToPoint:CGPointMake(centerX + 100, centerY - 0.00001)];
    //        [bezierpath addLineToPoint:CGPointMake(centerX + 100, centerY + 100)];
    //        [bezierpath addLineToPoint:CGPointMake(centerX - 100, centerY + 100)];
    //        [bezierpath addLineToPoint:CGPointMake(centerX - 100, centerY - 100)];
    //        [bezierpath addLineToPoint:CGPointMake(centerX + 100, centerY - 100)];
    //        [bezierpath addLineToPoint:CGPointMake(centerX + 100, centerY - 0.00001)];
    //
    //        bezierpath.lineWidth = 1;
    //        [bezierpath closePath];
    //        shapeLayer.path = bezierpath.CGPath;
    //        shapeLayer.fillColor = [UIColor redColor].CGColor;
    //
    //    [self.view.layer addSublayer:shapeLayer];
    
}
- (void)takePhoto:(id)sender {
    [self.lfCamera takePhoto:^(UIImage *img) {
        
        self.resultView = [[LFCameraResultView alloc] initWithFrame:self.view.bounds];
        self.resultView.imageView.image = img;
        
        __weak ViewController *weakSelf = self;
        self.resultView.rephotographBlock = ^ {
            [weakSelf.lfCamera restart];
            
        };
        self.resultView.usePhotoBlock = ^(UIImage *img){
            
        };
        [self.view addSubview:self.resultView];
    }];
}

- (void)lightOn:(id)sender {
    [self.lfCamera switchLight:LFCaptureFlashModeOn];
    NSLog(@"灯:%@",@([self.lfCamera getCaptureFlashMode]));
}

- (void)lightOff:(id)sender {
    [self.lfCamera switchLight:LFCaptureFlashModeOff];
    NSLog(@"灯:%@",@([self.lfCamera getCaptureFlashMode]));
}

- (void)lightAuto:(id)sender {
    [self.lfCamera switchLight:LFCaptureFlashModeAuto];
    NSLog(@"灯:%@",@([self.lfCamera getCaptureFlashMode]));
}

- (void)switchFront:(id)sender {
    [self.lfCamera switchCamera:YES];
    NSLog(@"摄像头:%@",@([self.lfCamera isCameraFront]));
}

- (void)switchBack:(id)sender {
    [self.lfCamera switchCamera:NO];
    NSLog(@"摄像头:%@",@([self.lfCamera isCameraFront]));
}

@end
