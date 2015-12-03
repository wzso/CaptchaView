//
//  ViewController.m
//  CaptchaViewDemo
//
//  Created by Vincent on 27/11/2015.
//  Copyright © 2015 wenzhishen.com. All rights reserved.
//

#import "ViewController.h"
#import "VFCaptchaView.h"

#define SCREEN_WIDTH self.view.frame.size.width
#define SCREEN_HEIGHT self.view.frame.size.height

@interface ViewController () <UITextFieldDelegate>
@property (nonatomic, strong) VFCaptchaView *captchaView;
@property (nonatomic, weak) IBOutlet UITextField *textField;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.captchaView = [[VFCaptchaView alloc] initWithFrame:CGRectMake(20.f, 40.f, SCREEN_WIDTH - 40.f, 40) success:^(NSString *verificationCode) {
        // do things on verification success
        NSLog(@"Verification Succeeded!🤗");
    } failure:^{
        // do things on verification failure
        NSLog(@"Verification Failed!😂");
    } withAnalyser:^BOOL(NSString *verificationCode) {
        return [verificationCode isEqualToString:self.textField.text];
    }];
    
    [self.captchaView setCaptchaCode:@"ImagineADog"];
    [self.view addSubview:self.captchaView];
}

#pragma mark - Target-Action
- (IBAction)refreshCaptchaCode {
    self.captchaView.codeLength = 5 + arc4random_uniform(4);
    [self.captchaView randomlySetCaptchaCode];
}

- (IBAction)beginVerification {
    if (self.textField.isFirstResponder) {
        [self.textField resignFirstResponder];
    }
    [self.captchaView beginVerification];
}

- (IBAction)resignKeyboard {
    if (self.textField.isFirstResponder) {
        [self.textField resignFirstResponder];
    }
}

#pragma mark - Delegate Methods
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.captchaView beginVerification];
    [textField resignFirstResponder];
    
    return YES;
}

@end
