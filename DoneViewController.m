//
//  DoneViewController.m
//  fantasticPics
//
//  Created by 山本文子 on 2015/01/22.
//  Copyright (c) 2015年 山本文子. All rights reserved.
//

#import "DoneViewController.h"

@implementation DoneViewController

-(void)viewDidLoad{
//    [self.navigationController setNavigationBarHidden:YES animated:YES]; //NavigationBarを非表示
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:YES]; //NavigationBarを非表示
}

/*
-(IBAction)save{
    //    キャプチャする範囲の指定
    CGRect rect = CGRectMake(0, 70, 320, 320);
    
    UIGraphicsBeginImageContext(rect.size);
    
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *capture = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    //    キャプチャした画像の範囲
    UIImageWriteToSavedPhotosAlbum(capture, nil, nil, nil);
    UIGraphicsEndImageContext();
    
    //    アラートを出す
    UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"【attention】" message:@"SAVE complete!" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alert show ];
    //　　アラートを画面に設定する
    //    timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(count) userInfo:nil repeats:YES];
}
 */

-(IBAction)backStart{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)top{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)twitter{
    //    if(isSound == NO ) flee.volume = 0;
    
    
    //    キャプチャする範囲の指定
    CGRect rect = CGRectMake(0, 0, 320, 251);
    
    UIGraphicsBeginImageContext(rect.size);
    
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
//    capture = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    //    キャプチャした画像の範囲
//    UIImageWriteToSavedPhotosAlbum(capture, nil, nil, nil);
    UIGraphicsEndImageContext();
    
    
    SLComposeViewController *twitterPostVC = [ SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    //    //投稿する文章
    //    [twitterPostVC setInitialText:[NSString stringWithFormat:@"I WAS %dしゅ! #OCTAGON_JP \n %@ \n https://itunes.apple.com/jp/app/octagon-wanwo-shi-fenkerushuttingugemu/id913077665?mt=8",score,coment]];
    //    [twitterPostVC addImage:capture];
    //投稿する文章
    [twitterPostVC setInitialText:[NSString stringWithFormat:@""]];
//    [twitterPostVC addImage:capture];
    
    //アラート
    [twitterPostVC setCompletionHandler:^ (SLComposeViewControllerResult result) {
        if(result == SLComposeViewControllerResultDone ){
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle: nil
                                                                message:NSLocalizedString(@"tweetSuccessMessage", nil)
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles: nil];
            [alertView show];
        }else{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle: nil
                                                                message:NSLocalizedString(@"tweetFiledMassage", nil)
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles: nil];
            [alertView show];
            
            /*
             UIAlertController *alert =
             [UIAlertController alertControllerWithTitle:@"背景"
             message:@"背景色確認用"
             preferredStyle:UIAlertControllerStyleAlert];
             
             [alert addAction:[UIAlertAction actionWithTitle:@"確認"
             style:UIAlertActionStyleDefault
             handler:nil]];
             
             [self presentViewController:alert
             animated:YES
             completion:^{
             }];
             */
        }
    }];
    
    //tweetする
    [self presentViewController:twitterPostVC animated:YES completion:nil];
    
}

-(IBAction)instagram{
    
}
@end
