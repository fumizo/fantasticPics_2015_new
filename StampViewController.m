//
//  StampViewController.m
//  fantasticPics
//
//  Created by 山本文子 on 2014/12/20.
//  Copyright (c) 2014年 山本文子. All rights reserved.
//

#import "StampViewController.h"
#import "DoneViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>

@interface StampViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation StampViewController{
    UIImageView *making;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    num = 0;

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
    stampArray[6] = @"fantasticPics_aoni.logo.png";  //青二ロゴ
    
    //    スクロールビューの初期化
    stampScrool.frame = self.view.bounds;
    //    スクロールしたときに反動させるかどうか
    stampScrool.bounces=YES;
    //    サイズを設定する
    CGRect rect = CGRectMake(0, 568-128, 320, 128+20);
    //　　UIImageViewを生成
    UIImageView *imageView =[[UIImageView alloc]initWithFrame:rect];
    
    stampScrool.frame = rect;
    
    //    //    スクロールビューに背景画像を設定
    //    imageView.image =[UIImage imageNamed:@"gurade.png"];
    
    //    UIScrollViewのコンテンツサイズを画像のサイズに合わせる
    rect.size.width = 1200;
//    stampScrool.contentSize = imageView.bounds.size;
    stampScrool.contentSize = rect.size;
    //scrollviewについて　http://oropon.hatenablog.com/entry/20111116/p1
    
    //    UIScrollViewのインスタンスに画像を貼付ける
    [stampScrool addSubview:imageView];
    
    
    
    //    for文を使ってボタンの位置をずらす
    for (int i=0;  i<7; i++) {
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
        
        
        //ドラッグジェスチャーを登録
        //    UIPanGestureRecognizer *pan;
        pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
        //    (void)[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
        [tapbtn addGestureRecognizer:pan];
    }
    
    stampView.userInteractionEnabled = YES;  //タッチを検出
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
        case 6:
            [self stamp7];
            
        default:
            break;            
    }
    
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    //    タッチされた場所の所得
    UITouch *touch = [touches anyObject];
    //    指一本だけ情報を所得
    CGPoint location = [touch locationInView:self.view];
    
    //   その位置を所得
    if(index > 0){
        //In visible background view
        stampImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:stampArray[index-1]]];
        //        stampView = [self.view viewWithTag:index-1];
        //        [stampImgView setTag: index-1]; //今のスタンプにタグをつける。indexと同じ番号
        stampImgView.backgroundColor = [UIColor clearColor];
        stampView =  [[UIView alloc] initWithFrame:CGRectMake(0,0,stampImgView.frame.size.width,stampImgView.frame.size.height)];
        
//        [stampView addGestureRecognizer:pan];ここどうよ

        [stampView addSubview:stampImgView];
        index = 0;  //一回スタンプしたらindexを0にして、押せなくするのよ
        
        //ここで調節のやつを呼んでみる
        [self reSizeButtons];
        
        stampView.center = CGPointMake(location.x, location.y);
        
        viewList[count] = stampImgView;
        count = count +1;
        
        
        //画像の上以外にスタンプを押させない
        if (location.y +  stampImgView.frame.size.height/2>= 348){
        }else if (location.y - stampImgView.frame.size.height/2<= 28){
        }else{
            [self.view addSubview:stampView]; //画像に表示する
//            num = num +1; //１回スタンプを追加したらnumを１にする、１だったら四隅けしてnumを０に
        }
        /*
        if (num == 2) {
            [self removeResizeButtons];
            num = 0;
        }
         */
    }
    
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
    closeVw.image = [UIImage imageNamed:@"fantasticPics_close.png" ];
    closeVw.userInteractionEnabled = YES;
    UITapGestureRecognizer * singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
    [closeVw addGestureRecognizer:singleTap];
    
    [stampView addSubview:closeVw];
    
    //Resizing view which is in bottom right corner
    resizeVw = [[UIImageView alloc]initWithFrame:CGRectMake(stampView.frame.size.width-25, stampView.frame.size.height-25, 25, 25)];
    resizeVw.backgroundColor = [UIColor clearColor];
    resizeVw.userInteractionEnabled = YES;
    resizeVw.image = [UIImage imageNamed:@"fantasticPics_resize.png" ];
    
    [stampView addSubview:resizeVw];
    UIPanGestureRecognizer* panResizeGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(resizeTranslate:)];
    [resizeVw addGestureRecognizer:panResizeGesture];
    
    //Rotating view which is in bottom left corner
    rotateVw = [[UIImageView alloc]initWithFrame:CGRectMake(0, stampView.frame.size.height-25, 25, 25)];
    rotateVw.backgroundColor = [UIColor clearColor];
    rotateVw.image = [UIImage imageNamed:@"fantasticPics_kaiten.png" ];
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
-(void)stamp7{
    index = 7;
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
    /*
    for (UIView *view in [_view subviews]) {
        //わわわ
        [view removeFromSuperview];
    }
     for (stampView in [_photoView subviews]) {
     [stampView removeFromSuperview];
     }

    */
    
    for(int i = count; i !=0; i= i-1){
        [viewList[i-1] removeFromSuperview];
        viewList[count] = Nil;
    }
    [self removeResizeButtons];
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
        
        stampView.bounds = CGRectMake(stampView.bounds.origin.x, stampView.bounds.origin.y, stampView.bounds.size.width + (wChange), stampView.bounds.size.height + (hChange));
//        stampImgView.bounds = CGRectMake(stampImgView.bounds.origin.x, stampImgView.bounds.origin.y, stampImgView.bounds.size.width + (wChange), stampImgView.bounds.size.height + (hChange));
        stampImgView.frame = CGRectMake(12, 12, stampView.bounds.size.width-24, stampView.bounds.size.height-27);
        
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
    
// 画質調整ポイント①
    CGRect rect = CGRectMake(0, 0, self.photoView.frame.size.width, self.photoView.frame.size.height);
    //CGRect rect = CGRectMake(0, 0, imageView.image.size.width, imageView.image.size.height);
    
    // This Option(last value) is very important for Quority of Photo
// 画質調整ポイント②
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0);
    
    // Decide layer to save
    [self.photoView.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    // Get PNG Image Data
// 画質調整ポイント③
    NSData *pngData = UIImagePNGRepresentation(UIGraphicsGetImageFromCurrentImageContext());
    //UIImage *jpgImage = UIGraphicsGetImageFromCurrentImageContext();
    //NSData *jpgData = UIImageJPEGRepresentation(jpgImage, 1.0);
    UIImage *captureImage = [UIImage imageWithData:pngData];
    
    // End Context
    UIGraphicsEndImageContext();
    
    UIImageWriteToSavedPhotosAlbum(captureImage, nil, nil, nil);
    UIGraphicsEndImageContext();
    

    /*
    //    キャプチャする範囲の指定
    //    CGRect rect = CGRectMake(0, 70, 320, 320);
    
    //画像の範囲を取得
    CGRect rect = self.photoView.bounds;
    UIGraphicsBeginImageContextWithOptions(rect.size, self.photoView.opaque, 0.0); //画質を落とさない
//    UIGraphicsBeginImageContext(rect.size);  //これをコメントアウトで画質を落とさなくする
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
     */
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    //imageView.image = [info objectForKey:UIImagePickerControllerEditedImage];
//#warning 画質調整ポイント④
    self.photoView.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}


-(IBAction)done{
    [self removeResizeButtons]; //四隅のやつがついたまま保存しないようにする

    // 画質調整ポイント①
    CGRect rect = CGRectMake(0, 0, self.photoView.frame.size.width, self.photoView.frame.size.height);
    //CGRect rect = CGRectMake(0, 0, imageView.image.size.width, imageView.image.size.height);
    
    // This Option(last value) is very important for Quority of Photo
    // 画質調整ポイント②
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0);
    
    // Decide layer to save
    [self.photoView.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    // Get PNG Image Data
    // 画質調整ポイント③
    NSData *pngData = UIImagePNGRepresentation(UIGraphicsGetImageFromCurrentImageContext());
    //UIImage *jpgImage = UIGraphicsGetImageFromCurrentImageContext();
    //NSData *jpgData = UIImageJPEGRepresentation(jpgImage, 1.0);
    UIImage *captureImage = [UIImage imageWithData:pngData];
    
    // End Context
    UIGraphicsEndImageContext();
    
    UIImageWriteToSavedPhotosAlbum(captureImage, nil, nil, nil);
    UIGraphicsEndImageContext();
    
    // Alert
    if (captureImage) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"保存完了" message:@"保存に成功しました" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
    
}


/*
// 完了を知らせる
- (void) savingImageIsFinished:(UIImage *)_image didFinishSavingWithError:(NSError *)_error contextInfo:(void *)_contextInfo
{
    NSLog(@"ここでインジケータでもだそうか！");
    
    UIAlertView *alert;
    
    if(_error){//エラーのとき
        alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"画像の保存に失敗しました。"
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"OK", nil
                              ];
        
        [alert show];
//        [alert release];
        
    }else{//保存できたとき
        alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"画像の保存に成功しました。"
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"OK", nil
                              ];
        [alert show];
    }
}
 */


//アラートのokしたら画面遷移
/*
// アラートのボタンが押された時に呼ばれるデリゲート例文
-(void)alertView:(UIAlertView*)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (buttonIndex) {
        case 0:
            //１番目のボタンが押されたときの処理を記述する
            
             DoneViewController *doneVC =  [self.storyboard instantiateViewControllerWithIdentifier:@"DoneViewController"];
            [self presentViewController:doneVC animated:YES completion:nil];//YESならModal,Noなら何もなし

            break;
        case 1:
            //２番目のボタンが押されたときの処理を記述する
            break;
    }
    
}
 */

//ドラッグジェスチャー
-(void)panAction:(UIPanGestureRecognizer *)sender{
    //移動距離の取得
    CGPoint p = [sender translationInView:self.view];

    //移動した距離のx,yをスタンプに設定
    CGPoint movedPoint = CGPointMake(stampView.center.x + p.x , stampView.center.y + p.y);
    stampView.center = movedPoint;
    NSLog(@"*座標%@を移動中...*", NSStringFromCGPoint(movedPoint));
    //    移動した距離を初期化
    [sender setTranslation:CGPointZero inView:self.view];
    
    //ジェスチャー終了
    if(sender.state == UIGestureRecognizerStateEnded){
        NSLog(@"移動終了");
    }
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
