//
//  StampViewController.m
//  fantasticPics
//
//  Created by 山本文子 on 2014/12/20.
//  Copyright (c) 2014年 山本文子. All rights reserved.
//

#import "StampViewController.h"

@interface StampViewController ()

@end

@implementation StampViewController{
    UIImageView *making;
    
}
/*んーどうしてできひんねん*/
//@synthesize photoView;
//@synthesize photoImage;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //    // UIPinchGestureRecognizerを登録
    //    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchAction:)];
    //    [stampView addGestureRecognizer:pinch];
    
    
    index = 0;
    stampArray[0] = @"UT_990yen_sozai";  //990円のやつ
    stampArray[1] = @"simamura_logo_sozai";  //しまむらロゴ
    stampArray[2] = @"MUSEE_summer_sozai";   //ミュゼ200円
    stampArray[3] = @"MUSEE.logo_sozai";     //ミュゼロゴ
    stampArray[4] = @"highBall_miho_sozai";  //うちのハイボールは角だから
    stampArray[5] = @"highBall_haikara_sozai";  //お好きでしょハイから
    
    //    スクロールビューの初期化
    stampScrool.frame = self.view.bounds;
    //    スクロールしたときに反動させるかどうか
    stampScrool.bounces=YES;
    //    サイズを設定する
    CGRect rect = CGRectMake(0, 568-128, 320, 128);
    //　　UIImageViewを生成
    UIImageView *imageView =[[UIImageView alloc]initWithFrame:rect];
    
    stampScrool.frame = rect;
    
    //    //    スクロールビューに背景画像を設定
    //    imageView.image =[UIImage imageNamed:@"gurade.png"];
    
    //    UIScrollViewのコンテンツサイズを画像のサイズに合わせる
    stampScrool.contentSize = imageView.bounds.size;
    
    
    //    UIScrollViewのインスタンスに画像を貼付ける
    [stampScrool addSubview:imageView];
    
    
    
    //    for文を使ってボタンの位置をずらす
    for (int i=0;  i<6; i++) {
        //        ボタンの種類を設定
        UIButton *tapbtn =[UIButton buttonWithType:UIButtonTypeCustom];
        
        tapbtn.userInteractionEnabled = true;
        
        //        サイズと位置
        tapbtn.frame=CGRectMake(i*100, 0, 100, 100);
        
        //        ボタンの背景画像設定
        [tapbtn setBackgroundImage:[UIImage imageNamed:stampArray[i]] forState:UIControlStateNormal];
        
        //        ボタンが押されたときの処理
        [tapbtn addTarget:self action:@selector(tap:) forControlEvents:UIControlEventTouchUpInside];
        
        tapbtn.tag=i;
        
        [stampScrool addSubview:tapbtn];
    }
    
    
}

/*
 //UIGestureRecognizerについて
 //ジェスチャーの同時処理を許可
 - (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
 return YES;
 }
 */


//ボタンが押されたときの処理
-(void)tap:(UIButton*)button{
    
    [self removeResizeButtons];
    
    switch (button.tag) {
        case 0:
            [self stamp1];
            break;
        case 1:
            [self stamp2];
            break;
        case 2:
            [self stamp3];
            break;
        case 3:
            [self stamp4];
            break;
        case 4:
            [self stamp5];
            break;
        case 5:
            [self stamp6];
            break;
            
        default:
            break;
            //        isReSize = NO ;
            
    }
    
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    //    タッチされた場所の所得
    UITouch *touch = [touches anyObject];
    //    指一本だけ情報を所得
    CGPoint location = [touch locationInView:self.view];
    
    /*さわったところにお花できるやつ
     UIImage *makingRing = [UIImage imageNamed:@"fantasticPics_ring"];
     making = [[UIImageView alloc]initWithImage:makingRing];
     
     //    making.center = CGPointMake(location.x, location.y);
     CGRect rect = CGRectMake(location.x -25, location.y-25, 50, 50);
     making.frame = rect;
     [self.view addSubview:making];
     
     [UIView animateWithDuration:1.1f // アニメーション速度2.5秒
     delay:0.0f // 1秒後にアニメーション
     options:UIViewAnimationOptionCurveEaseInOut
     animations:^{
     // 画像を2倍に拡大
     making.transform = CGAffineTransformMakeScale(1.7,  1.7);
     making.alpha = 0;
     } completion:^(BOOL finished) {
     // アニメーション終了時
     }];
     */
    
    //   その位置を所得
    if(index > 0){
        //In visible background view
        stampImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:stampArray[index-1]]];
        //        stampView = [self.view viewWithTag:index-1];
        //        [stampImgView setTag: index-1]; //今のスタンプにタグをつける。indexと同じ番号
        stampImgView.backgroundColor = [UIColor clearColor];
        stampView =  [[UIView alloc] initWithFrame:CGRectMake(0,0,stampImgView.frame.size.width,stampImgView.frame.size.height)];
        [stampView addSubview:stampImgView];
        index = 0;  //一回スタンプしたらindexを0にして、押せなくするのよ
        
        //ここで調節のやつを呼んでみる
        [self reSizeButtons];
        
        stampView.center = CGPointMake(location.x, location.y);
        
        viewList[count] = stampImgView;
        count = count +1;
        
        /*
         // UIPinchGestureRecognizerを登録
         UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchAction:)];
         pinch.delegate = self;
         [stampView addGestureRecognizer:pinch];
         */
        [self.view addSubview:stampView]; //画像に表示する
    }
    //    // UIPinchGestureRecognizerを登録
    //    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchAction:)];
    //    [self.view addGestureRecognizer:pinch];
    
}

/*ライブラリのやつ使うからコメントアウトするよ
 //拡大縮小する
 - (void)pinchAction:(UIPinchGestureRecognizer *)sender {
 stampView = sender.view;
 CGFloat scale = [sender scale];
 
 // ピンチの操作開始してからの拡大縮小を、transformで設定
 stampView.transform = CGAffineTransformConcat(stampView.transform, CGAffineTransformMakeScale(scale, scale));
 }
 */


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES]; //NavigationBarを非表示
    
    
    NSData* imageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"hogehoge"];
    if(imageData) {
        self.photoView.image = [UIImage imageWithData:imageData];
        //ビューのサイズを写真に合わせたい
        //        self.photoImage.size =
        //        CGSize cs = self.photoImage.size;
        //        self.photoView.frame = cs;
        
        self.photoView = [[UIImageView alloc]initWithImage:self.photoImage];
        CGRect rect = CGRectMake(0, 0, self.photoImage.size.height , self.photoImage.size.width);
        self.photoView.frame = rect;
        
        //たてよこ変わらないように
        [self.photoView setContentMode:UIViewContentModeScaleAspectFit];
        [self.view addSubview:self.photoView];
        
        
        NSLog(@"復元完了");
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"hogehoge"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }else{
        self.photoView.image = self.photoImage;
    }
}

-(IBAction)back{
    
    NSData* imageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"cache"];
    if(imageData) {
        UIImage *image = [UIImage imageWithData:imageData];
        
        NSLog(@"復元完了");
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"cache"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        DBCameraSegueViewController *segue = [[DBCameraSegueViewController alloc] initWithImage:image thumb:image boolsecond:true];
        [self presentViewController:segue animated:YES completion:nil];
    }else{
        NSLog(@"復元失敗");
    }
    
}

- (void)reSizeButtons{
    
    //サイズの調整
    //Close button view which is in top left corner
    closeVw = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    closeVw.backgroundColor = [UIColor clearColor];
    closeVw.image = [UIImage imageNamed:@"close_gold.png" ];
    closeVw.userInteractionEnabled = YES;
    UITapGestureRecognizer * singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
    [closeVw addGestureRecognizer:singleTap];
    
    [stampView addSubview:closeVw];
    
    //Resizing view which is in bottom right corner
    resizeVw = [[UIImageView alloc]initWithFrame:CGRectMake(stampView.frame.size.width-25, stampView.frame.size.height-25, 25, 25)];
    resizeVw.backgroundColor = [UIColor clearColor];
    resizeVw.userInteractionEnabled = YES;
    resizeVw.image = [UIImage imageNamed:@"button_02.png" ];
    
    [stampView addSubview:resizeVw];
    UIPanGestureRecognizer* panResizeGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(resizeTranslate:)];
    [resizeVw addGestureRecognizer:panResizeGesture];
    
    //Rotating view which is in bottom left corner
    rotateVw = [[UIImageView alloc]initWithFrame:CGRectMake(0, stampView.frame.size.height-25, 25, 25)];
    rotateVw.backgroundColor = [UIColor clearColor];
    rotateVw.image = [UIImage imageNamed:@"button_01.png" ];
    rotateVw.userInteractionEnabled = YES;
    [stampView addSubview:rotateVw];
    
    UIPanGestureRecognizer * panRotateGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(rotateViewPanGesture:)];
    [rotateVw addGestureRecognizer:panRotateGesture];
    [panRotateGesture requireGestureRecognizerToFail:panResizeGesture];
    
    //    isReSize = NO ;
}


-(void)stamp1{
    index = 1;
}
-(void)stamp2{
    index = 2;
}
-(void)stamp3{
    index = 3;
}
-(void)stamp4{
    index = 4;
}
-(void)stamp5{
    index = 5;
}
-(void)stamp6{
    index = 6;
    
}

-(IBAction)backStamp{
    
    [self removeResizeButtons];
    
    if (count > 0) {
        count = count-1;
        [viewList[count] removeFromSuperview];
    }
    else{count =0;
    }
}

-(IBAction)clearStamp{
    for(int i = count; i !=0; i= i-1){
        [viewList[i-1] removeFromSuperview];
        
        viewList[count] = Nil;
    }
}



//ここから下にサイズ、傾きのやつ
-(void)singleTap:(UIPanGestureRecognizer *)recognizer
{
    UIView * close = (UIView *)[recognizer view];
    [close.superview removeFromSuperview];
    
}

-(void)removeResizeButtons{
    
    //    [self.view viewWithTag:1];
    [closeVw removeFromSuperview];
    [rotateVw removeFromSuperview];
    [resizeVw removeFromSuperview];
}

//stampArray[index-2]

-(void)resizeTranslate:(UIPanGestureRecognizer *)recognizer
{
    if ([recognizer state]== UIGestureRecognizerStateBegan)
    {
        prevPoint = [recognizer locationInView:stampImgView.superview];
        [stampImgView setNeedsDisplay];
        
        
    }
    else if ([recognizer state] == UIGestureRecognizerStateChanged)
    {
        if (stampImgView.bounds.size.width < 20)
        {
            
            stampImgView.bounds = CGRectMake(stampImgView.bounds.origin.x, stampImgView.bounds.origin.y, 20, stampImgView.bounds.size.height);
            stampImgView.frame = CGRectMake(12, 12, stampImgView.bounds.size.width-24, stampImgView.bounds.size.height-27);
            resizeVw.frame =CGRectMake(stampImgView.bounds.size.width-25, stampImgView.bounds.size.height-25, 25, 25);
            rotateVw.frame = CGRectMake(0, stampImgView.bounds.size.height-25, 25, 25);
            closeVw.frame = CGRectMake(0, 0, 25, 25);
            
        }
        
        if(stampImgView.bounds.size.height < 20)
        {
            stampImgView.bounds = CGRectMake(stampImgView.bounds.origin.x, stampImgView.bounds.origin.y, stampImgView.bounds.size.width, 20);
            stampImgView.frame = CGRectMake(12, 12, stampImgView.bounds.size.width-24, stampImgView.bounds.size.height-27);
            resizeVw.frame =CGRectMake(stampImgView.bounds.size.width-25, stampImgView.bounds.size.height-25, 25, 25);
            rotateVw.frame = CGRectMake(0, stampImgView.bounds.size.height-25, 25, 25);
            closeVw.frame = CGRectMake(0, 0, 25, 25);
            
            
        }
        
        CGPoint point = [recognizer locationInView:stampImgView.superview];
        float wChange = 0.0, hChange = 0.0;
        
        wChange = (point.x - prevPoint.x); //Slow down increment
        hChange = (point.y - prevPoint.y); //Slow down increment
        
        
        stampImgView.bounds = CGRectMake(stampImgView.bounds.origin.x, stampImgView.bounds.origin.y, stampImgView.bounds.size.width + (wChange), stampImgView.bounds.size.height + (hChange));
        stampImgView.frame = CGRectMake(12, 12, stampImgView.bounds.size.width-24, stampImgView.bounds.size.height-27);
        
        resizeVw.frame =CGRectMake(stampImgView.bounds.size.width-25, stampImgView.bounds.size.height-25, 25, 25);
        rotateVw.frame = CGRectMake(0, stampImgView.bounds.size.height-25, 25, 25);
        closeVw.frame = CGRectMake(0, 0, 25, 25);
        
        prevPoint = [recognizer locationInView:stampImgView.superview];
        
        [stampImgView setNeedsDisplay];
    }
    else if ([recognizer state] == UIGestureRecognizerStateEnded)
    {
        
        prevPoint = [recognizer locationInView:stampImgView.superview];
        [stampImgView setNeedsDisplay];
    }
}
-(void)rotateViewPanGesture:(UIPanGestureRecognizer *)recognizer
{
    if ([recognizer state] == UIGestureRecognizerStateBegan)
    {
        deltaAngle = atan2([recognizer locationInView:stampImgView].y-stampImgView.center.y, [recognizer locationInView:stampImgView].x-stampImgView.center.x);
        startTransform = stampImgView.transform;
    }
    else if ([recognizer state] == UIGestureRecognizerStateChanged)
    {
        float ang = atan2([recognizer locationInView:stampImgView.superview].y - stampImgView.center.y, [recognizer locationInView:stampImgView.superview].x - stampImgView.center.x);
        float angleDiff = deltaAngle - ang;
        stampImgView.transform = CGAffineTransformMakeRotation(-angleDiff);
        [stampImgView setNeedsDisplay];
    }
    else if ([recognizer state] == UIGestureRecognizerStateEnded)
    {
        deltaAngle = atan2([recognizer locationInView:stampImgView].y-stampImgView.center.y, [recognizer locationInView:stampImgView].x-stampImgView.center.x);
        startTransform = stampImgView.transform;
        [stampImgView setNeedsDisplay];
    }
}

-(void)capture{
    //    キャプチャする範囲の指定
    //    CGRect rect = CGRectMake(0, 70, 320, 320);
    
    //画像の範囲を取得
    CGRect rect = self.photoView.bounds;
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextFillRect(ctx, rect);
    
    [self.photoView.layer renderInContext:ctx];
    
    //    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    //    UIImage *capture = UIGraphicsGetImageFromCurrentImageContext();
    //    UIImageWriteToSavedPhotosAlbum(capture, nil, nil, nil);
    
    //    pngに変換する
    NSData *data = UIImagePNGRepresentation(UIGraphicsGetImageFromCurrentImageContext());
    capture = [UIImage imageWithData:data];
    UIGraphicsEndImageContext();
}

-(IBAction)done{
    [self removeResizeButtons]; //四隅のやつがついたまま保存しないようにする
    [self capture];
    UIImageWriteToSavedPhotosAlbum(capture, self, sel_registerName("savingImageIsFinished:didFinishSavingWithError:contextInfo"), nil);
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
