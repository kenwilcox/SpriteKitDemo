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
    
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"Space"];
    background.position = CGPointMake(size.width * 0.5, size.height * 0.5);
    [self addChild:background];
    
    self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
    
    SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    
    myLabel.text = @"Hello, World!";
    myLabel.name = @"helloNode";
    myLabel.fontSize = 30;
    myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                   CGRectGetMidY(self.frame));
    
    [self addChild:myLabel];
  }
  return self;
}

-(void)flicker:(SKSpriteNode *)node {
  SKAction *fadeOut = [SKAction fadeOutWithDuration:0.01];
  SKAction *fadeIn = [SKAction fadeInWithDuration:0.1];
  SKAction *sequence = [SKAction sequence:@[fadeOut, fadeIn]];
  SKAction *repeat = [SKAction repeatActionForever:sequence];
  [node runAction:repeat];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  /* Called when a touch begins */
  
  SKNode *helloNode = [self childNodeWithName:@"helloNode"];
  if (helloNode != nil) {
    helloNode.name = nil;
    SKAction *moveUp = [SKAction moveByX:0 y:100.0 duration:0.5];
    SKAction *zoom = [SKAction scaleTo:2.0 duration:0.25];
    SKAction *pause = [SKAction waitForDuration:0.1];
    SKAction *fadeAway = [SKAction fadeOutWithDuration:0.5];
    SKAction *remove = [SKAction removeFromParent];
    SKAction *moveSequence = [SKAction sequence:@[moveUp, zoom, pause, fadeAway, remove]];
    [helloNode runAction:moveSequence];
  } else {
    
    for (UITouch *touch in touches) {
      CGPoint location = [touch locationInNode:self];
      
      SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
      
      sprite.position = location;
      
      //    SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
      //    double r = drand48();// + (location.y / 100);
      NSUInteger r = arc4random_uniform(3) + 1;
//      NSLog(@"%lu", (unsigned long)r);
      SKAction *action = [SKAction moveByX:0.0f y:200.0f duration:r];
      
      // If scale is a negative number, it flips (rotates) the image
      SKAction *scale = [SKAction scaleBy:0.5 duration:2.0];
      [sprite runAction:[SKAction repeatActionForever:action]];
      [sprite runAction:scale];
      
      [self addChild:sprite];
      
//      SKSpriteNode *square = [SKSpriteNode spriteNodeWithColor:[SKColor redColor] size:CGSizeMake(20, 20)];
//      // Force it to be on top of the space ship
//      sprite.zPosition = 1;
//      // Add the square to the spaceship sprite it will inherit the sequence
//      [sprite addChild:square];
      
      SKSpriteNode *leftFlame = [SKSpriteNode spriteNodeWithImageNamed:@"Flame"];
      // centered
      leftFlame.position = CGPointMake(-12, -109);
      [self flicker:leftFlame];
      [sprite addChild:leftFlame];
      
      SKSpriteNode *rightFlame = [SKSpriteNode spriteNodeWithImageNamed:@"Flame"];
      // with changing the anchor point
      rightFlame.anchorPoint = CGPointMake(0.5, 1.0);
      rightFlame.position = CGPointMake(12, -87);
      [self flicker:rightFlame];
      [sprite addChild:rightFlame];
    }
  }
}

-(void)update:(CFTimeInterval)currentTime {
  /* Called before each frame is rendered */
}

@end
