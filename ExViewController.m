//
//  ExViewController.m
//  fantasticPics
//
//  Created by 山本文子 on 2015/01/31.
//  Copyright (c) 2015年 山本文子. All rights reserved.
//

#import "ExViewController.h"

@implementation ExViewController

-(void)viewDidLoad{
    exArray[0] = [UIImage imageNamed:@"ex1.png"];
    exArray[1] = [UIImage imageNamed:@"ex2.png"];
    exArray[2] = [UIImage imageNamed:@"ex3.png"];
    exArray[3] = [UIImage imageNamed:@"ex4.png"];
    exArray[4] = [UIImage imageNamed:@"ex5.png"];
    exArray[5] = [UIImage imageNamed:@"ex6.png"];
    
    index = 0;
    [exImageView setImage:exArray[index]];
    [self.view addSubview:exImageView];
    /*
     諦めたスクロールビュー
    
     // スクロールビュー例文
     UIScrollView *sv = [[UIScrollView alloc] initWithFrame:self.view.bounds];
     sv.backgroundColor = [UIColor cyanColor];
     
     UIView *uv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1000, 1000)];
     [sv addSubview:uv];
     sv.contentSize = uv.bounds.size;
     [self.view addSubview:sv];
     //ここまでなんの意味もない下から
    
    
    //    スクロールビューの初期化
    exScrool.frame = self.view.bounds;
    //    スクロールしたときに反動させるかどうか
    exScrool.bounces=YES;
    //    サイズを設定する
    CGRect rect = CGRectMake(0, 568-128, 320, 128+20);
    //　　UIImageViewを生成
    imageViewDayo =[[UIImageView alloc]initWithFrame:rect];
    
    exScrool.frame = rect;
    rect.size.width = 320*6;
    //    stampScrool.contentSize = imageView.bounds.size;
    exScrool.contentSize = rect.size;
    //scrollviewについて　http://oropon.hatenablog.com/entry/20111116/p1
    
    //    UIScrollViewのインスタンスに画像を貼付ける
    [exScrool addSubview:imageViewDayo];
    
    
    //    for文を使ってボタンの位置をずらす
    for (int i=0;  i<7; i++) {
        //        サイズと位置
        exImages.frame=CGRectMake(i*100, 0, 320, 320);
        
        //        ボタンの背景画像設定
        exImages.image =[UIImage imageNamed:exArray[i]];
    }
    */
}

-(IBAction)next{
    index = index + 1;
    if (index > 5){
        index =0;
    }
    [exImageView setImage:exArray[index]];
}
-(IBAction)back{
    index = index - 1;
    if (index < 0){
        index = 5;
    }
    [exImageView setImage:exArray[index]];
}
-(IBAction)top{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
