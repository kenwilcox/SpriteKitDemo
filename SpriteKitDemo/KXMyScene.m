//
//  KXMyScene.m
//  SpriteKitDemo
//
//  Created by Kenneth Wilcox on 9/27/14.
//  Copyright (c) 2014 Kenneth Wilcox. All rights reserved.
//

#import "KXMyScene.h"

@implementation KXMyScene

-(id)initWithSize:(CGSize)size {
  //  srand48(time(0));
  if (self = [super initWithSize:size]) {
    /* Setup your scene here */
    
    self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
    
    SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    
    myLabel.text = @"Hello, World!";
    myLabel.fontSize = 30;
    myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                   CGRectGetMidY(self.frame));
    
    [self addChild:myLabel];
  }
  return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  /* Called when a touch begins */
  
  for (UITouch *touch in touches) {
    CGPoint location = [touch locationInNode:self];
    
    SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
    
    sprite.position = location;
    
    //    SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
    //    double r = drand48();// + (location.y / 100);
    NSUInteger r = arc4random_uniform(3) + 1;
    NSLog(@"%lu", (unsigned long)r);
    SKAction *action = [SKAction moveByX:0.0f y:200.0f duration:r];
    
    [sprite runAction:[SKAction repeatActionForever:action]];
    
    [self addChild:sprite];
  }
}

-(void)update:(CFTimeInterval)currentTime {
  /* Called before each frame is rendered */
}

@end
