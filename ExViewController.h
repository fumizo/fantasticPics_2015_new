//
//  ExViewController.h
//  fantasticPics
//
//  Created by 山本文子 on 2015/01/31.
//  Copyright (c) 2015年 山本文子. All rights reserved.
//

#import "ViewController.h"
#import "ExViewController.h"

@interface ExViewController : ViewController{
    UIImage *exArray[6];
//    IBOutlet UIScrollView *exScrool;
    UIImageView * exImages;
    
    //UIImageView * imageViewDayo;
    
    int index;
    
    IBOutlet UIImageView * exImageView;
}

-(IBAction)next;
-(IBAction)back;
-(IBAction)top;

@end
