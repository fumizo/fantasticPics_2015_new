//
//  DoneViewController.h
//  fantasticPics
//
//  Created by 山本文子 on 2015/01/22.
//  Copyright (c) 2015年 山本文子. All rights reserved.
//

#import "ViewController.h"
#import <Social/Social.h>


@interface DoneViewController : ViewController{
    NSData * imageData;
    IBOutlet UIImageView * doneImage;
}

-(IBAction)twitter;
-(IBAction)instagram;
-(IBAction)backStart;
-(IBAction)top;


//@property (nonatomic, readonly) NSData *imageDate;
@property (nonatomic) NSData *imageData;


@end
