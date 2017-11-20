//
//  ViewController.m
//  启示页
//
//  Created by slcf888 on 2017/8/28.
//  Copyright © 2017年 slcf888. All rights reserved.
//

#import "ViewController.h"
#import "PageControllView.h"
@interface ViewController ()

@property(nonatomic,strong)PageControllView*pageCountrolV;
@property(nonatomic,strong)NSArray *imageArr;

@end

@implementation ViewController
-(NSArray *)imageArr
{
    if (!_imageArr) {
        _imageArr = [NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5", nil];
    }
    return _imageArr;
}

-(PageControllView *)pageCountrolV
{
    if (!_pageCountrolV) {
        _pageCountrolV=[[PageControllView instance] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) andImageList:self.imageArr];
    }
    return _pageCountrolV;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.pageCountrolV];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
