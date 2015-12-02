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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    VFCaptchaView *captchaView = [[VFCaptchaView alloc] initWithFrame:CGRectMake(20.f, 40.f, SCREEN_WIDTH - 40.f, 40) success:^(NSString *verificationCode) {
        NSLog(@"Wrong Code: %@. Go!", verificationCode);
    } failure:^{
        NSLog(@"Right Code, Pity!");
    }];
    [captchaView setCaptchaCode:@"你是一只老乌龟"];
    captchaView.codeLength = 10;
    [self.view addSubview:captchaView];
}

@end
