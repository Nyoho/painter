//
//  ViewController.m
//  Painter
//
//  Created by tommy on 2014/02/16.
//  Copyright (c) 2014年 tommy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property TBKDetectionView *detectionView;
@property TBKBlockView *stampView;
@property CGPoint touchPoint;
@property UIImageView *canvas;
@property BOOL isDrawing;
@property NSMutableArray *points;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    self.canvas = [[UIImageView alloc] initWithImage:nil];
    self.canvas.backgroundColor= [UIColor whiteColor];
    self.canvas.frame = self.paintView.frame;
    [self.paintView addSubview:self.canvas];

    self.detectionView = [[TBKDetectionView alloc] initWithFrame:self.view.frame delegate:self];
    [self.view addSubview:self.detectionView];
    [self becomeFirstResponder];


    CGSize blockSize = self.detectionView.recognizer.blockSize;
    self.stampView = [[TBKBlockView alloc] initWithFrame:CGRectMake(0, 0, blockSize.width, blockSize.height)];
    self.stampView.faceColor = [UIColor brownColor];
    self.stampView.hidden = YES;
    [self.view insertSubview:self.stampView belowSubview:self.detectionView];
    self.isDrawing = NO;
    self.points = [NSMutableArray array];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showBlockStamp:(TBKBlock *)block
{
    [self.stampView updateProperties:block];
    self.stampView.hidden = NO;
}

- (void)blocksBegan:(NSSet *)blocks withEvent:(UIEvent *)event
{
    for (TBKBlock *block in blocks) {
        [self showBlockStamp:block];
    }
}

- (void) nonBlockTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    self.touchPoint = [touch locationInView:self.canvas];

    [self.points addObject:[NSValue valueWithCGPoint:self.touchPoint]];
}


- (void) nonBlockTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    self.touchPoint = [touch locationInView:self.canvas];
    [self.points addObject:[NSValue valueWithCGPoint:self.touchPoint]];

}

- (void) nonBlockTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    self.touchPoint = [touch locationInView:self.canvas];

    [self.points addObject:[NSValue valueWithCGPoint:self.touchPoint]];
    [self fill];
}

- (void)fill {
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextMoveToPoint(context, 最初の点x, y);
    for (NSValue *val in self.points) {
        //ここで この pをつかう
        CGPoint p = [val cgpointValue];
        CGContextAddLineToPoint(context, p.x, p.y);
    }
   //とじる点もやった方がいいと思う
    CGContextAddLineToPoint(context, xxx, yyy);
    
    CGContextSetRGBFillColor(context, (248/255.0), (222/255.0), (173/255.0), 1);
    CGContextFillPath(context);

}

@end
