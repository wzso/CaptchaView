//
//  CaptchaView.m
//  CaptchaViewDemo
//
//  Created by Vincent on 27/11/2015.
//  Copyright © 2015 wenzhishen.com. All rights reserved.
//

#import "VFCaptchaView.h"

#define RANDOM_COLOR [UIColor colorWithRed:arc4random_uniform(100) / 100.f green:arc4random_uniform(100) / 100.f blue:arc4random_uniform(100) / 100.f alpha:1.f]
#define RANDOM_FONT_SIZE (arc4random_uniform(6) + 15)
#define Lines_Count 5

@interface VFCaptchaView ()
@property (nonatomic, strong) NSArray *captchaCharacters;
@property (nonatomic, copy) VFCaptchaVerificationSuccessBlock successCallback;
@property (nonatomic, copy) VFCaptchaVerificationFailureBlock failureCallback;
@property (nonatomic, copy) VFCaptchaVerificationAnalyser analyser;
@end

@implementation VFCaptchaView

#pragma mark - Open API
- (instancetype)initWithFrame:(CGRect)frame success:(VFCaptchaVerificationSuccessBlock)success failure:(VFCaptchaVerificationFailureBlock)failure withAnalyser:(VFCaptchaVerificationAnalyser)analyser {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 6.f;
        self.captchaCharacters = [self randomCaptchaCharacters];
        
        self.successCallback = success;
        self.failureCallback = failure;
        self.analyser = analyser;
    }
    
    return self;
}

- (void)beginVerification {
    NSAssert(self.analyser, @"analyser must not be nil");
    NSString *captchaCode = [self.captchaCharacters componentsJoinedByString:@""];
    if (self.analyser(captchaCode)) {
        if (self.successCallback) {
            self.successCallback(captchaCode);
        }
        [self randomlySetCaptchaCode];
    }
    else {
        if (self.failureCallback) {
            self.failureCallback();
        }
        [self randomlySetCaptchaCode];
    }
}

- (void)setCaptchaCode:(NSString *)captchaCode {
    self.captchaCharacters = [self charactersInString:captchaCode];
    self.codeLength = self.captchaCharacters.count;
    NSLog(@"CAPTCHA CODE IS: %@", captchaCode);
    [self setNeedsDisplay];
}

- (void)randomlySetCaptchaCode {
    self.captchaCharacters = [self randomCaptchaCharacters];
    NSLog(@"CAPTCHA CODE IS: %@", [self.captchaCharacters componentsJoinedByString:@""]);
    [self setNeedsDisplay];
}

#pragma mark - Private Methods
- (NSArray *)randomCaptchaCharacters {
    NSMutableArray *captchaCharacters = [NSMutableArray array];
    NSArray *array = [self charactersInString:@"阿里巴巴和四十万大盗开业庆典abcdefghijklmnopqrstuvwxyz这是一个简单的验证码视图ABCDEFGHIJKLMNOPQRSTUVWXYZ你通过手动设置验证码0123456789随机生成的也行"];
    if (!self.codeLength) {
        self.codeLength = 6;
    }
    u_int32_t count = (u_int32_t)array.count;
    for (int i = 0; i < self.codeLength; i ++) {
        NSString *character = array[arc4random_uniform(count)];
        [captchaCharacters addObject:character];
    }
    
    return captchaCharacters;
}

- (CGRect)rectForCharacterInFont:(UIFont *)font atIndex:(NSUInteger)index {
    CGFloat margin = 2.f;
    // max width for each character
    CGFloat maxWidth = (self.frame.size.width - (self.captchaCharacters.count + 1) * margin) / self.captchaCharacters.count;
    // max height of a character
    CGFloat maxHeight = self.frame.size.height;
    
    // the size of the rectangle a character can draw in
    CGSize size = [@"哈" boundingRectWithSize:CGSizeMake(maxWidth, maxHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    CGFloat width = size.width;
    CGFloat height = size.height;
    u_int32_t widthDiff = (u_int32_t)(maxWidth - width);
    u_int32_t heightDiff = (u_int32_t)fabs(maxHeight - height - 2.f);
    return CGRectMake(index * (maxWidth + margin) + margin + arc4random_uniform(widthDiff), arc4random_uniform(heightDiff), width, height);
}

- (NSArray *)charactersInString:(NSString *)string {
    NSMutableArray *characters = [NSMutableArray array];
    for (int i = 0; i < string.length; i ++) {
        [characters addObject:[string substringWithRange:NSMakeRange(i, 1)]];
    }
    return characters;
}

#pragma mark - Override Methods
- (void)drawRect:(CGRect)rect {
    self.backgroundColor = RANDOM_COLOR;
    
    __weak typeof(self) weakSelf = self;
    NSArray *familyNames = [UIFont familyNames];
    u_int32_t namesCount = (u_int32_t)familyNames.count;
    
    // draw characters
    [self.captchaCharacters enumerateObjectsUsingBlock:^(NSString *  _Nonnull character, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat fontSize = RANDOM_FONT_SIZE;
        
        // the font to draw in.
        
#if 0   // to adapt variety of font
        NSString *fontName = familyNames[arc4random_uniform(namesCount)];
        NSLog(@"%@", fontName);
        UIFont *font = [UIFont fontWithName:fontName size:fontSize];
#else
        UIFont *font = [UIFont systemFontOfSize:fontSize];
#endif
        [character drawInRect:[weakSelf rectForCharacterInFont:font atIndex:idx] withAttributes:@{NSFontAttributeName:font, NSForegroundColorAttributeName:RANDOM_COLOR}];
    }];
    
    
    // draw line for distraction
    u_int32_t maxWidth = (u_int32_t)rect.size.width;
    u_int32_t maxHeight = (u_int32_t)rect.size.height;
    for (int i = 0; i < Lines_Count; i ++) {
        UIBezierPath *path = [[UIBezierPath alloc] init];
        [path moveToPoint:CGPointMake(arc4random_uniform(maxWidth), arc4random_uniform(maxHeight))];
        [path addLineToPoint:CGPointMake(arc4random_uniform(maxWidth), arc4random_uniform(maxHeight))];
        [RANDOM_COLOR setStroke];
        path.lineWidth = 1.f;
        [path stroke];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    self.captchaCharacters = [self randomCaptchaCharacters];
    NSLog(@"CAPTCHA CODE IS: %@", [self.captchaCharacters componentsJoinedByString:@""]);
    [self setNeedsDisplay];
}

@end
