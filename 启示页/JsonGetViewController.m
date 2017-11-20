//
//  JsonGetViewController.m
//  启示页
//
//  Created by slcf888 on 2017/8/31.
//  Copyright © 2017年 slcf888. All rights reserved.
//

#import "JsonGetViewController.h"
#import "CustomCell.h"
#import "JsonGetModel.h"
#import "AFNetworking.h"

#define JsonGet @"http://iappfree.candou.com:8080/free/applications/limited?currency=rmb&page=1"
#define Json  @"http://localhost:8001/biz/financing/mycommission"

@interface JsonGetViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableview;
    NSMutableArray *_dataArray;
}
@end

@implementation JsonGetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    _dataArray=[NSMutableArray array];
    
//    [self JudgeNetState];
    [self loadData];
    [self configUI];
    // Do any additional setup after loading the view.
}
-(void)JudgeNetState{
    AFHTTPRequestOperationManager*manage=[[AFHTTPRequestOperationManager alloc]initWithBaseURL:[NSURL URLWithString:@"http://baidu.com"]];
    
    [manage.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status==AFNetworkReachabilityStatusNotReachable) {
            NSLog(@"xxxx");
        } else if (status==AFNetworkReachabilityStatusReachableViaWWAN) {
            NSLog(@"-网");
        }else if(status==AFNetworkReachabilityStatusReachableViaWiFi){
            NSLog(@"---wifi");
        }
    }];
    [manage.reachabilityManager startMonitoring];
}

-(void)loadData{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", nil];

    [manager GET:JsonGet parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        NSDictionary *dic=(NSDictionary *)responseObject;
        NSArray *applications=dic[@"applications"];
        
        for (NSDictionary *item in applications) {
            JsonGetModel *model=[[JsonGetModel alloc]init];
            model.iconUrl = item[@"iconUrl"];
            model.name = item[@"name"];
            model.description1 = item[@"description"];
            model.updataDate = item[@"updateDate"];
            [_dataArray addObject:model];
        }
        [_tableview reloadData];
       
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}
-(void)configUI{
    self.automaticallyAdjustsScrollViewInsets=NO;
    _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.height) style:UITableViewStylePlain];
    _tableview.delegate=self;
    _tableview.dataSource=self;
    //
    [_tableview registerClass:[CustomCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableview];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId=@"cell";
    CustomCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    [cell fileData:_dataArray[indexPath.row]];
    return cell;
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
