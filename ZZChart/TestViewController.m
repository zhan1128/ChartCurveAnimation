//
//  TestViewController.m
//  ZZChart
//
//  Created by JZZ on 2017/5/27.
//  Copyright © 2017年 JZZ. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController () {

    CAGradientLayer *_gradientLayer;
    CAGradientLayer *_topGradientLayer;
    CAGradientLayer *_bottomGradientLayer;

}

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    _gradientLayer = [CAGradientLayer layer];
    _gradientLayer.cornerRadius = 5;
    _gradientLayer.masksToBounds = YES;
    _gradientLayer.frame = CGRectMake(100, 100, 10, 300);
    [self.view.layer addSublayer:_gradientLayer];
    _gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor, (__bridge id) [UIColor yellowColor].CGColor, (__bridge id)[UIColor greenColor].CGColor];
    _gradientLayer.locations = @[@0.0, @0.5, @1];
    _gradientLayer.startPoint = CGPointMake(0.5, 0);
    _gradientLayer.endPoint = CGPointMake(0.5, 1);
    


    _topGradientLayer = [CAGradientLayer layer];
    _topGradientLayer.frame = CGRectMake(0, 0, 60, 60);
    _topGradientLayer.position = CGPointMake(105, 200);
    _topGradientLayer.cornerRadius = 30;
    _topGradientLayer.masksToBounds = YES;
    _topGradientLayer.opacity = 0.5;
    [self.view.layer addSublayer:_topGradientLayer];
    _topGradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor, (__bridge id) [UIColor yellowColor].CGColor];
    _topGradientLayer.locations = @[@0.0, @1];
    _topGradientLayer.startPoint = CGPointMake(0.5, 0);
    _topGradientLayer.endPoint = CGPointMake(0.5, 1);
    
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
