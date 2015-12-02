//
//  CaptchaView.h
//  CaptchaViewDemo
//
//  Created by Vincent on 27/11/2015.
//  Copyright © 2015 wenzhishen.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^VFCaptchaVerificationSuccessBlock)(NSString *verificationCode);
typedef void(^VFCaptchaVerificationFailureBlock)();

@interface VFCaptchaView : UIView

/**
 *  Specify the count of length of captcha code in a CaptchaView.
 *  Default count is 6.
 */
@property (nonatomic) NSUInteger codeLength;

/**
 *  Specify a captcha code manually. You can use this method to specify a
 *  code retrieved from network.
 *
 *  @param captchaCode a captcha code
 */
- (void)setCaptchaCode:(NSString *)captchaCode;

/**
 *  you can call this method to randomly change the cha
 */
- (void)randomlySetCaptchaCode;

/**
 *  Designated initializer
 *
 *  @param frame   a frame
 *  @param success callback on verification success
 *  @param failure callback on verification failure
 *
 *  @return initialized instance
 */
- (instancetype)initWithFrame:(CGRect)frame success:(VFCaptchaVerificationSuccessBlock)success failure:(VFCaptchaVerificationFailureBlock)failure;

@end
