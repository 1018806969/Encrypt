//
//  MD5ViewController.m
//  Encrypt
//
//  Created by txx on 16/12/22.
//  Copyright © 2016年 txx. All rights reserved.
//

#import "MD5ViewController.h"
#import <CommonCrypto/CommonDigest.h>

@interface MD5ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *originTextFiled;
@property (weak, nonatomic) IBOutlet UITextView *encryptTextView;
@property (weak, nonatomic) IBOutlet UIButton *encryptButton;

@end

@implementation MD5ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"MD5 encrypt";
    [self.encryptButton addTarget:self action:@selector(encryWithPublicKey) forControlEvents:UIControlEventTouchUpInside];
}
-(void)encryWithPublicKey
{
    _encryptTextView.text = [self md5Enctypt:_originTextFiled.text];
}
-(NSString *)md5Enctypt:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (int)strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
