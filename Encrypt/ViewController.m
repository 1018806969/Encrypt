//
//  ViewController.m
//  Encrypt
//
//  Created by txx on 16/12/22.
//  Copyright © 2016年 txx. All rights reserved.
//

#import "ViewController.h"
#import "DESViewController.h"
#import "MD5ViewController.h"
#import "AESViewController.h"


typedef NS_ENUM(NSInteger,TEncryptType)
{
    TEncryptTypeDES,
    TEncryptTypeRSA,
    TEncryptTypeRSAAndJavaServer,
    TEncryptTypeAES,
    TEncryptTypeMD5
};

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSArray               *datas;

@end

static NSString *const TCellId = @"TCellId";
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Encrypt";
    self.tableView.delegate = self ;
    self.tableView.dataSource =self ;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:TCellId];
    self.datas = @[@"DES Encrypt&&Decode",@"RSA Encrypt&&Decode",@"RSA & Java Server",@"AES Encrypt&&Decode",@"MD5 Encrypt"];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datas.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TCellId];
    cell.textLabel.text = self.datas[indexPath.row];
    cell.backgroundColor = [UIColor purpleColor];
    return cell ;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case TEncryptTypeDES:
        {
            DESViewController *DES = [[DESViewController alloc]init];
            [self.navigationController pushViewController:DES animated:YES];
            break;
        }
        case TEncryptTypeAES:
        {
            AESViewController *AES = [[AESViewController alloc]init];
            [self.navigationController pushViewController:AES animated:YES];
            break;
        }
        case TEncryptTypeMD5:
        {
            MD5ViewController *md5 = [[MD5ViewController alloc]init];
            [self.navigationController pushViewController:md5 animated:YES];
            break;
        }


            
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
