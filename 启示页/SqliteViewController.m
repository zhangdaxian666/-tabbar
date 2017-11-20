//
//  SqliteViewController.m
//  启示页
//
//  Created by slcf888 on 2017/8/29.
//  Copyright © 2017年 slcf888. All rights reserved.
//

#import "SqliteViewController.h"
#import "FMDB.h"
@interface SqliteViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    FMDatabase * dataBase;
    NSMutableArray * _usernameArr;
    NSMutableArray * _passwordArr;
    UIAlertController * _alert;
}

@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation SqliteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString * path=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    path=[path stringByAppendingPathComponent:@"my.sqlite"];//zhishi mingzi
    
    dataBase=[FMDatabase databaseWithPath:path];
    
    BOOL open=[dataBase open];
    if (open) {
        NSLog(@"数据库打开");
    }
    
    NSString * create1=@"CREATE TABLE IF NOT EXISTS A_user (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,username TEXT,password TEXT)";
    BOOL c1 = [dataBase executeUpdate:create1];
    if (c1) {
        NSLog(@"创建表成功");
    }
    
    _alert =[UIAlertController alertControllerWithTitle:@"请输入账o密码" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [_alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
        textField.clearsOnBeginEditing=YES;//再次编辑则清空

        textField.placeholder=@"账号";
    }];
    [_alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.clearsOnBeginEditing=YES;
        textField.placeholder=@"密码";
        textField.secureTextEntry = YES;//密

    }];
    UIAlertAction *action=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    [_alert addAction:action];
    
    
    UIAlertAction *action2=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (!_alert.textFields[0].text||!_alert.textFields[1].text) {
            return ;
        }
        
        //插入数据
        NSString * insertSql= @" INSERT INTO A_user(username, password)VALUES(?,?)";
        //yuju
        bool inflag1=[dataBase executeUpdate:insertSql,_alert.textFields[0].text,_alert.textFields[1].text];
        if (inflag1) {
            NSLog(@"插入数据成功");
            
            [self selectForm];
            [self.tableview reloadData];
        }
        
    }];
    [_alert addAction:action2];
    
    
    _usernameArr=[[NSMutableArray alloc]init];
    _passwordArr=[[NSMutableArray alloc]init];
    
    self.tableview.delegate=self;
    self.tableview.dataSource=self;
    self.tableview.tableFooterView=[UIView new];
    
    UIBarButtonItem *left=[[UIBarButtonItem alloc]initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(clcke)];
    self.navigationItem.rightBarButtonItem=left;
    [self selectForm];
    // Do any additional setup after loading the view.
}
#pragma mark-数据
-(void)selectForm{
    [_usernameArr removeAllObjects];
    [_passwordArr removeAllObjects];
    
    NSString * sql=@"select * from A_user";
    FMResultSet *result=[dataBase executeQuery:sql];//xun wen
    
    while (result.next) {
        NSString*username=[result stringForColumn:@"username"];
        [_usernameArr addObject:username];
        NSString*password=[result stringForColumn:@"password"];
        [_passwordArr addObject:password];
    }
}

-(void)clcke{
    
    [self presentViewController:_alert animated:YES completion:nil];
}

#pragma mark-Delegate／datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _usernameArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    //FMDB  定义
    cell.textLabel.text=_usernameArr[indexPath.row];
    cell.detailTextLabel.text=_passwordArr[indexPath.row];
    return cell;
}
#pragma mark
-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
     UITableViewRowAction *editAction=[UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"编辑" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
    
    UIAlertController *editAlert = [UIAlertController alertControllerWithTitle:@"修改账号密码" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [editAlert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text=_usernameArr[indexPath.row];
    }];
    [editAlert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text=_passwordArr[indexPath.row];
    }];
    [self presentViewController:editAlert animated:YES completion:nil];
    
    UIAlertAction*action3=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    [editAlert addAction:action3];
    
    UIAlertAction*action4=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //xiu gai
        BOOL flag = [dataBase executeUpdate:@"UPDATE A_user SET username = ?,password = ? WHERE id = ?;",editAlert.textFields[0].text,editAlert.textFields[1].text,@(indexPath.row+1)];
        
        if (flag) {
            NSLog(@"修改成功");
            [self selectForm];
            [self.tableview reloadData];
        }
    }];
    [editAlert addAction:action4];
}];
    
    UITableViewRowAction * deleAction =[UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        //删除
        BOOL dflag =[dataBase executeUpdate:@"delete from A_user WHERE username = ?",_usernameArr[indexPath.row]];
        if (dflag) {
            NSLog(@"删除");
            [_usernameArr removeObjectAtIndex:indexPath.row];
            [_passwordArr removeObjectAtIndex:indexPath.row];
            [self.tableview reloadData];
        }
    }];
    return @[editAction,deleAction];
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
