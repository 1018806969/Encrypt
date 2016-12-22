//
//  DESViewController.m
//  Encrypt
//
//  Created by txx on 16/12/22.
//  Copyright © 2016年 txx. All rights reserved.
//

#import "DESViewController.h"
#import "DES3Util.h"

@interface DESViewController ()
@property (weak, nonatomic) IBOutlet UITextField *originTextField;
@property (weak, nonatomic) IBOutlet UILabel *randomLabel;
@property (weak, nonatomic) IBOutlet UITextView *encryptTextView;
@property (weak, nonatomic) IBOutlet UITextView *decodeTextView;
@property (weak, nonatomic) IBOutlet UIButton *encryptButton;
@property (weak, nonatomic) IBOutlet UIButton *decodeButton;

@end

@implementation DESViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"DES Encrypt&Decode";
    
    [self.encryptButton addTarget:self action:@selector(encryWithPublicKey) forControlEvents:UIControlEventTouchUpInside];
    [self.decodeButton addTarget:self action:@selector(decryWithPriviteKey) forControlEvents:UIControlEventTouchUpInside];
}
-(void)encryWithPublicKey
{
    //生成一个随机的8位字符串，作为DES加密数据的key，对数据进行DES加密，对加密后的数据用公钥在进行一个RSA加密
    _randomLabel.text = [self shuffledAlphabet];
    
    _encryptTextView.text = [DES3Util encryptUseDES:_originTextField.text key:_randomLabel.text];
}
-(void)decryWithPriviteKey
{
    _decodeTextView.text = [DES3Util decryptUseDES:_encryptTextView.text key:_randomLabel.text];
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
