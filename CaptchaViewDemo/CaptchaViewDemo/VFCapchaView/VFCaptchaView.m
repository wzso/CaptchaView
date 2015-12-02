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

@interface VFCaptchaView ()
@property (nonatomic, strong) NSArray *captchaCharacters;
@end

@implementation VFCaptchaView

#pragma mark - Open API
- (instancetype)initWithFrame:(CGRect)frame success:(VFCaptchaVerificationSuccessBlock)success failure:(VFCaptchaVerificationFailureBlock)failure {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 6.f;
        self.captchaCharacters = [self randomCaptchaCharacters];
    }
    
    return self;
}

- (void)setCaptchaCode:(NSString *)captchaCode {
    self.captchaCharacters = [self charactersInString:captchaCode];
    self.codeLength = self.captchaCharacters.count;
    [self setNeedsDisplay];
}

- (void)randomlySetCaptchaCode {
    self.captchaCharacters = [self randomCaptchaCharacters];
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
        NSLog(@"%@", character);
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
    u_int32_t heightDiff = (u_int32_t)(maxHeight - height);
    
    return CGRectMake(index * width + arc4random_uniform(widthDiff), arc4random_uniform(heightDiff), width, height);
}

- (NSArray *)charactersInString:(NSString *)string {
    NSMutableArray *characters = [NSMutableArray array];
    for (int i = 0; i < string.length; i ++) {
        [characters addObject:[NSString stringWithFormat:@"%c",[string characterAtIndex:i]]];
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
        NSString *fontName = familyNames[arc4random_uniform(namesCount)];
        // the font to draw in.
        UIFont *font = [UIFont fontWithName:fontName size:fontSize];
        
        [character drawInRect:[weakSelf rectForCharacterInFont:font atIndex:idx] withAttributes:@{NSFontAttributeName:font, NSForegroundColorAttributeName:RANDOM_COLOR}];
    }];
    
    // draw line for disturbance
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    self.captchaCharacters = [self randomCaptchaCharacters];
    [self setNeedsDisplay];
}

@end
