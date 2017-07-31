//
//  ChartViewController.m
//  ZZChart
//
//  Created by JZZ on 2017/2/14.
//  Copyright © 2017年 JZZ. All rights reserved.
//

#import "ChartViewController.h"
#import "ZZLineChart.h"
#define screenWidth [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height
@interface ChartViewController () {
    ZZLineChart *lineChart;
    NSMutableArray *dataArr;
}

@end

@implementation ChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    switch (_index) {
        case 0:
        {
            [self showFirstQuardrant];
        }
            break;
        case 1:
        {
            [self showFirstAndSecondQuardrant];
            
        }
            break;
        case 2:
        {
            [self showFirstAndFouthQuardrant];
        }
            break;
        case 3:
        {
            [self showAllQuardrant];
        }
            break;
        case 4:
        {
            [self showPieChartUpView];
        }
            break;
        case 5:
        {
            [self showRingChartView];
        }
            break;
        case 6:
        {
            [self showColumnView];
        }break;
        case 7:
        {
            [self showTableView];
        }break;
        case 8:
        {
            [self showRadarChartView];
        }break;
        case 9:
        {
            [self showScatterChart];
        }break;
        default:
            break;
    }
}

-(void)viewWillDisappear:(BOOL)animated {
}
/*
 *  第一象限的折线图
 */
- (void)showFirstQuardrant {
    dataArr = [NSMutableArray arrayWithArray:@[@[@"0.1",@"0.12",@"1",@"0.27",@"0.4",@"0.20",@"0.6",@"0.7",@"0.18",@"0.10",@"0.12",@"0.4",@"0.20",@"0.6"]]];
    lineChart = [[ZZLineChart alloc] initWithFrame:CGRectMake(10, 200, screenWidth-20, 300)];
    lineChart.xLineDataArr = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11"];
    lineChart.contextInsets = UIEdgeInsetsMake(0, 25, 20, 10);
    lineChart.valueArr = dataArr;
    lineChart.showYLevelLine = YES;
    lineChart.showYLine = YES;
    lineChart.showValueLeadingLine = NO;
    lineChart.valueFontSize = 9.0;
    lineChart.showMaxNumber = 12;
    lineChart.backgroundColor = [UIColor whiteColor];
    lineChart.valueLineColorArr =@[ [UIColor greenColor], [UIColor orangeColor]];
    lineChart.pointColorArr = @[[UIColor orangeColor],[UIColor yellowColor]];
    lineChart.xAndYLineColor = [UIColor blackColor];
    lineChart.xAndYNumberColor = [UIColor darkGrayColor];
    lineChart.positionLineColorArr = @[[UIColor blueColor],[UIColor greenColor]];
    lineChart.contentFill = YES;
    lineChart.pathCurve = YES;
    lineChart.contentFillColorArr = @[[UIColor colorWithRed:0 green:1 blue:0 alpha:0.1],[UIColor colorWithRed:1 green:0 blue:0 alpha:0.1]];
    [self.view addSubview:lineChart];
    [lineChart showAnimation];
    [NSTimer scheduledTimerWithTimeInterval:2.0f
                                     target:self
                                   selector:@selector(updateTimer)
                                   userInfo:nil
                                    repeats:YES];
}
- (void)updateTimer {
    //  这个要在你蓝牙代理方法里面去实现  最好要确保你的代理方法发送数据是固定的时间间隔
    [lineChart clear];
    NSMutableArray *arr = [NSMutableArray arrayWithArray:dataArr[0]];
    NSString *str = arr.lastObject;
    [arr insertObject:str atIndex:0];
    [arr removeLastObject];
    [dataArr insertObject:arr atIndex:0];
    [dataArr removeLastObject];
    lineChart.valueArr = dataArr;
    [lineChart showAnimation];
}

/*
 *  第一、二象限的折线图
 */
- (void)showFirstAndSecondQuardrant {

}

/*
 *  第一、四象限的折线图
 */
- (void)showFirstAndFouthQuardrant {
    
}

/*
 *  全象限的折线图
 */
- (void)showAllQuardrant {

}

- (void)showPieChartUpView {
    
}

- (void)showRingChartView {
    
}

- (void)showColumnView {
    
}

- (void)showTableView {
    
}

- (void)showRadarChartView {
    
}

- (void)showScatterChart {
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
