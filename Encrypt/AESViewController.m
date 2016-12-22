//
//  AESViewController.m
//  Encrypt
//
//  Created by txx on 16/12/22.
//  Copyright © 2016年 txx. All rights reserved.
//

#import "AESViewController.h"
#import "AES.h"

@interface AESViewController ()
@property (weak, nonatomic) IBOutlet UITextField *originTextField;
@property (weak, nonatomic) IBOutlet UILabel *randomLabel;
@property (weak, nonatomic) IBOutlet UITextView *encryptTextView;
@property (weak, nonatomic) IBOutlet UITextView *decryTextView;
@property (weak, nonatomic) IBOutlet UIButton *encryptButton;
@property (weak, nonatomic) IBOutlet UIButton *decryButton;

@end

@implementation AESViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"AES";
    
    [_encryptButton  addTarget:self action:@selector(encryWithPublicKey) forControlEvents:UIControlEventTouchUpInside];
    [_decryButton addTarget:self action:@selector(decryWithPriviteKey) forControlEvents:UIControlEventTouchUpInside];

}
-(void)encryWithPublicKey
{
    //生成一个随机的8位字符串，作为des加密数据的key,对数据进行des加密，对加密后的数据用公钥再进行一次rsa加密
    _randomLabel.text = [self shuffledAlphabet];
    _encryptTextView.text = [AES encrypt:_originTextField.text password:_randomLabel.text];

}
-(void)decryWithPriviteKey
{
    _decryTextView.text = [AES decrypt:_encryptTextView.text password:_randomLabel.text];
}

//生成八位随机字符串
- (NSString *)shuffledAlphabet {
    NSString *alphabet = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    
    // Get the characters into a C array for efficient shuffling
    NSUInteger numberOfCharacters = [alphabet length];
    unichar *characters = calloc(numberOfCharacters, sizeof(unichar));
    [alphabet getCharacters:characters range:NSMakeRange(0, numberOfCharacters)];
    
    // Perform a Fisher-Yates shuffle
    for (NSUInteger i = 0; i < numberOfCharacters; ++i) {
        NSUInteger j = (arc4random_uniform((float)numberOfCharacters - i) + i);
        unichar c = characters[i];
        characters[i] = characters[j];
        characters[j] = c;
    }
    
    // Turn the result back into a string
    NSString *result = [NSString stringWithCharacters:characters length:8];
    free(characters);
    return result;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
