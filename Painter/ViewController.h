//
//  ViewController.h
//  Painter
//
//  Created by tommy on 2014/02/16.
//  Copyright (c) 2014年 tommy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TangiblockKit/TangiblockKit.h>

@interface ViewController : UIViewController<TBKBlockRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIView *paintView;

@end
