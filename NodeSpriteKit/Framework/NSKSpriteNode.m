//
//  NSKSpriteNode.m
//  NodeSpriteKit
//
//  Created by Kevin Whinnery on 11/5/13.
//  Copyright (c) 2013 Kevin Whinnery. All rights reserved.
//

#import "SKNode+ManagedNode.h"
#import "NSKSpriteNode.h"
#import "NSKScene.h"

@implementation NSKSpriteNode

// Update managed properties on a node, given the options specified
+(void)updateNode:(NSKSpriteNode*)node withOptions:(NSDictionary*)options
{
    node.userInteractionEnabled = [options objectForKey:@"interactive"];
    node.name = [options objectForKey:@"uuid"];
    node.position = CGPointMake([[options objectForKey:@"x"] floatValue],
                                [[options objectForKey:@"y"] floatValue]);
    
    // Use auto sizing if none is specified
    if ([options objectForKey:@"width"] && [options objectForKey:@"height"]) {
        node.size = CGSizeMake([[options objectForKey:@"width"] floatValue],
                               [[options objectForKey:@"height"] floatValue]);
    }
}

#pragma mark JavaScript interface
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
    // hard code a size for the physics body for now
    self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.size.width/2];
}

@end
