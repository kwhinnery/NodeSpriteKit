//
//  NSKSpriteNode.m
//  NodeSpriteKit
//
//  Created by Kevin Whinnery on 11/5/13.
//  Copyright (c) 2013 Kevin Whinnery. All rights reserved.
//

#import "NSKSpriteNode.h"
#import "NSKScene.h"

@implementation NSKSpriteNode

// Update managed properties on a node, given the options specified
+(void)updateNode:(NSKSpriteNode*)node withOptions:(NSDictionary*)options
{
    node.userInteractionEnabled = YES;
    node.name = [options objectForKey:@"uuid"];
    node.position = CGPointMake([[options objectForKey:@"x"] floatValue],
                                [[options objectForKey:@"y"] floatValue]);
    
    // Use auto sizing if none is specified
    if ([options objectForKey:@"width"] && [options objectForKey:@"height"]) {
        node.size = CGSizeMake([[options objectForKey:@"width"] floatValue],
                               [[options objectForKey:@"height"] floatValue]);
    }
}

+(id)create:(NSDictionary *)options
{
    NSKSpriteNode *node = [[NSKSpriteNode alloc] initWithImageNamed:[options valueForKey:@"image"]];
    [NSKSpriteNode updateNode:node withOptions:options];
    return node;
}

// Update managed node properties
-(void)update:(NSDictionary *)options
{
    [NSKSpriteNode updateNode:self withOptions:options];
}

-(void)addPhysics:(NSDictionary *)options
{
    // hard code a size for the physics body
    self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.size.width/2];
}

// Handle touch events
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint positionInScene = [touch locationInNode:self];
    NSKScene *scene = (NSKScene*) self.scene;
    [scene fireEvent:@{@"eventType":@"touch",
                       @"target":self.name,
                       @"data":@{@"x": [NSNumber numberWithFloat:positionInScene.x],
                                 @"y": [NSNumber numberWithFloat:positionInScene.y]}}];
}

@end
