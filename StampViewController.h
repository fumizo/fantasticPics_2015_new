//
//  StampViewController.h
//  fantasticPics
//
//  Created by 山本文子 on 2014/12/20.
//  Copyright (c) 2014年 山本文子. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "DBLibraryManager.h"
#import "DBCameraViewController.h"
#import "DBCameraContainerViewController.h"
#import "DBCameraSegueViewController.h"
#import "DoneViewController.h"
@interface StampViewController : UIViewController<DBCameraViewControllerDelegate , UIGestureRecognizerDelegate>{
    
    NSString *stampArray[7];
    int index;
    UIImageView *viewList[100];
    int count;
    
    IBOutlet UIScrollView *stampScrool;
    
    
    
    //ここからCGGestureRecognizer
    CGAffineTransform _currentTransform;
    float _scale;
    float _angle;
    BOOL _isMoving;
    
    
    UIImageView *stampImgView;  //画像自体
    UIView *stampView;          //うしろでこれに画像自体を置いてる
    
    UIImageView *resizeVw;   //サイズ変える
    UIImageView *rotateVw;  //これが角度
    UIImageView *closeVw;   //これで閉じる
    
    float deltaAngle;
    CGPoint prevPoint;
    CGAffineTransform startTransform;
    
    UIImage *capture; //キャプチャした画像
    //ドラッグジェスチャー
    UIPanGestureRecognizer *pan;

    //一度スタンプを選択して連続で押すときに１回ずつ[self removeResizeButtons];呼びたいっていう変数
    int num;

//    BOOL isReSize;//四隅のやつがいらなくなったらnoにいるときはonに
    
    NSData *pngData;
    
    
    
    
}

-(void)stamp1;
-(void)stamp2;
-(void)stamp3;
-(void)stamp4;
-(void)stamp5;
-(void)stamp6;
-(void)stamp7;

- (IBAction)backStamp;
- (IBAction)clearStamp;

- (void)panAction:(UIPanGestureRecognizer *)sender;


@property IBOutlet UIImageView * photoView;
@property (nonatomic) UIImage *photoImage;


//-(IBAction)goNext;

@end