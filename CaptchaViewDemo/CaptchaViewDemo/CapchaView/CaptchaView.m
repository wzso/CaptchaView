//
//  CaptchaView.m
//  CaptchaViewDemo
//
//  Created by Vincent on 27/11/2015.
//  Copyright © 2015 wenzhishen.com. All rights reserved.
//

#import "CaptchaView.h"

#define RANDOM_COLOR [UIColor colorWithRed:arc4random_uniform(1000) / 1000.f green:arc4random_uniform(1000) / 1000.f blue:arc4random_uniform(1000) / 1000.f alpha:1.f]

@implementation CaptchaView

- (instancetype)initWithFrame:(CGRect)frame success:(CaptchaVerificationSuccessBlock)success failure:(CaptchaVerificationFailureBlock)failure {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 6.f;
        self.backgroundColor = RANDOM_COLOR;
    }
    
    return self;
}

@end
