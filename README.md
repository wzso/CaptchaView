VFCaptchaView v1.0.0 []
本地授权码验证View

[![996.icu](https://img.shields.io/badge/link-996.icu-red.svg)](https://996.icu)

一个本地的授权码验证View

Captcha View generated locally.

## Usage

### Initialize

`success` is the callback on success in which case `analyser` returns `YES`. 
On the other hand, block `failure` is called on failure and `analyser` returns `NO`. 
`Analyser` is the verificator. It allows you to controller the logic (eg. equation, case-sensitiveness).

`failure` 验证失败的回调，即 `analyser` 返回 `YES` 的时候；
`success` 验证成功的回调，即 `analyser` 返回 `YES` 的时候；
`analyser` 你可以通过这个 block 控制验证的逻辑（如相等，忽略大小写等）。

```
self.captchaView = [[VFCaptchaView alloc] initWithFrame:CGRectMake(20.f, 40.f, SCREEN_WIDTH - 40.f, 40) success:^(NSString *verificationCode) {
        NSString *title = @"Verification Succeeded!";
        NSString *message = @"🤗";
        NSString *cancelButtonTitle = @"Yeah";
        // do things on verification success
        if ([[UIDevice currentDevice].systemVersion floatValue] < 9.0) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil, nil];
            [alertView show];
        } else {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        
    } failure:^{
        // do things on verification failure
        NSString *title = @"Verification Failed!";
        NSString *message = @"😂";
        NSString *cancelButtonTitle = @"Try Again";
        // do things on verification success
        if ([[UIDevice currentDevice].systemVersion floatValue] < 9.0) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil, nil];
            [alertView show];
        } else {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }

    } withAnalyser:^BOOL(NSString *verificationCode) {
        return [verificationCode isEqualToString:self.textField.text];
    }];
 ```

### Set Verfification Code

```
    [self.captchaView setCaptchaCode:@"自定义文字abc123ABC"];
```

### Add Captcha as subview

```
    [self.view addSubview:self.captchaView];
```

## Screenshots

![](https://github.com/zssr/CaptchaView/blob/master/Screen%20Shots/screen%20shot1.jpg)

![](https://github.com/zssr/CaptchaView/blob/master/Screen%20Shots/screen%20shot2.jpg)

### Verification succeed :)

![](https://github.com/zssr/CaptchaView/blob/master/Screen%20Shots/screen%20shot3.jpg)

### Verification failed :(

![](https://github.com/zssr/CaptchaView/blob/master/Screen%20Shots/screen%20shot4.jpg)
