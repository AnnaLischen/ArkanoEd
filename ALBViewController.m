//
//  ALBViewController.m
//  ArkanoEd
//
//  Created by Anastasya Karchevsky on 21.10.13.
//  Copyright (c) 2013 Rosa Alba. All rights reserved.
//

#import "ALBViewController.h"

@interface ALBViewController () <UICollisionBehaviorDelegate>
@property (strong, nonatomic) IBOutlet UIView *ball;
@property (strong, nonatomic) IBOutlet UIView *puddle;


@property (strong, nonatomic) UIDynamicAnimator *animator;
@property (strong, nonatomic) UIPushBehavior *push;
@property (strong, nonatomic) UICollisionBehavior *collision;

@end

@implementation ALBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    self.push = [[UIPushBehavior alloc]initWithItems:@[self.ball] mode:UIPushBehaviorModeInstantaneous];
    [self.push setPushDirection:CGVectorMake(0, 0.3)];
    
    self.collision = [[UICollisionBehavior alloc] initWithItems:@[self.ball]];
    [self.collision addBoundaryWithIdentifier:@"bar" fromPoint: self.puddle.frame.origin toPoint:CGPointMake (self.puddle.frame.origin.x+self.puddle.frame.size.width,self.puddle.frame.origin.y)];
    [self.collision addBoundaryWithIdentifier:@"top" fromPoint:CGPointMake(0,0) toPoint:CGPointMake(self.view.frame.size.width, 0)]; //верхний край
    [self.collision addBoundaryWithIdentifier:@"left" fromPoint:CGPointMake(0,0) toPoint:CGPointMake(0, self.view.frame.size.height)]; //левый край
    [self.collision addBoundaryWithIdentifier:@"right" fromPoint:CGPointMake(self.view.frame.size.width,0) toPoint:CGPointMake(self.view.frame.size.width, self.view.frame.size.height)]; //правый край
    [self.collision addBoundaryWithIdentifier:@"bottom" fromPoint:CGPointMake(0, self.view.frame.size.height) toPoint:CGPointMake(self.view.frame.size.width, self.view.frame.size.height)]; //нижний край
    
    self.collision.collisionDelegate = self;
    
    [self.animator addBehavior:self.push];
    [self.animator addBehavior:self.collision];
}

-(void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p
{
    if ([(NSString *) identifier isEqualToString:@"bar"]) {
        [self.push setPushDirection:CGVectorMake(0.3, -0.3)];
        [self.push setActive:YES];
    }
    
    if ([(NSString *) identifier isEqualToString:@"top"]) {
        [self.push setPushDirection:CGVectorMake(0.3, 0.3)];
        [self.push setActive:YES];
    }
    
    if ([(NSString *) identifier isEqualToString:@"left"]) {
        [self.push setPushDirection:CGVectorMake(-0.3, 0.3)];
        [self.push setActive:YES];
    }
    
    if ([(NSString *) identifier isEqualToString:@"right"]) {
        [self.push setPushDirection:CGVectorMake(0.3, 0.3)];
        [self.push setActive:YES];
    }
    
    if ([(NSString *) identifier isEqualToString:@"bottom"]) {
        [self.push setPushDirection:CGVectorMake(0.1, 0.3)];
        [self.push setActive:YES];
    }


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
