//
//  CaptchaView.h
//  CaptchaViewDemo
//
//  Created by Vincent on 27/11/2015.
//  Copyright © 2015 wenzhishen.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CaptchaVerificationSuccessBlock)(NSString *verificationCode);
typedef void(^CaptchaVerificationFailureBlock)();

@interface VFCaptchaView : UIView

@property (nonatomic) NSUInteger charactersCount;

/** Designated Initializer
 * @param frame
 *
 *
 **/
- (instancetype)initWithFrame:(CGRect)frame success:(CaptchaVerificationSuccessBlock)success failure:(CaptchaVerificationFailureBlock)failure;

@end
