//
//  CaptchaView.m
//  CaptchaViewDemo
//
//  Created by Vincent on 27/11/2015.
//  Copyright © 2015 wenzhishen.com. All rights reserved.
//

#import "VFCaptchaView.h"

#define RANDOM_COLOR [UIColor colorWithRed:arc4random_uniform(1000) / 1000.f green:arc4random_uniform(1000) / 1000.f blue:arc4random_uniform(1000) / 1000.f alpha:1.f]
#define RANDOM_FONT_SIZE (arc4random_uniform(6) + 15)

@interface VFCaptchaView ()
@property (nonatomic, strong) NSArray *captchaCode;
@end

@implementation VFCaptchaView

#pragma mark - Open API
- (instancetype)initWithFrame:(CGRect)frame success:(VFCaptchaVerificationSuccessBlock)success failure:(VFCaptchaVerificationFailureBlock)failure {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 6.f;
        self.captchaCode = [self randomCaptchaCode];
    }
    
    return self;
}

- (void)setCaptchaCode:(NSString *)captchaCode {
    _captchaCode = [captchaCode componentsSeparatedByString:@""];
    self.codeLength = _captchaCode.count;
    [self setNeedsDisplay];
}

- (void)randomlySetCaptchaCode {
    self.captchaCode = [self randomCaptchaCode];
}

#pragma mark - Private Methods
- (NSString *)randomCaptchaCode {
    NSMutableString *captchaCode = [NSMutableString string];
    NSArray *array = [@"阿里巴巴和四十万大盗开业庆典abcdefghijklmnopqrstuvwxyz这是一个简单的验证码视图ABCDEFGHIJKLMNOPQRSTUVWXYZ你通过手动设置验证码0123456789随机生成的也行" componentsSeparatedByString:@""];
    if (!self.codeLength) {
        self.codeLength = 6;
    }
    for (int i = 0; i < self.codeLength; i ++) {
        NSString *character = array[arc4random_uniform((unsigned int)array.count)];
        [captchaCode appendString:character];
    }
    
    return captchaCode;
}

#pragma mark - Override Methods
- (void)drawRect:(CGRect)rect {
    self.backgroundColor = RANDOM_COLOR;
    
    CGFloat margin = 2.f;
    // max width of a character
    CGFloat width = (self.frame.size.width - (self.captchaCode.count + 1) * margin) / self.captchaCode.count;
    // max height of a character
    CGFloat height = [@"哈" boundingRectWithSize:CGSizeMake(width, self.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]} context:nil].size.height;
    
    __weak typeof(self) weakSelf = self;
    NSArray *familyNames = [UIFont familyNames];
    u_int32_t namesCount = (u_int32_t)familyNames.count;
    [self.captchaCode enumerateObjectsUsingBlock:^(NSString *  _Nonnull character, NSUInteger idx, BOOL * _Nonnull stop) {
        
        
        NSString *fontName = familyNames[arc4random_uniform(namesCount)];
        [character drawInRect:CGRectMake(0, 0, 0, 0) withAttributes:@{NSFontAttributeName:[UIFont fontWithName:fontName size:RANDOM_FONT_SIZE], NSForegroundColorAttributeName:RANDOM_COLOR}];
    }];
}

@end
