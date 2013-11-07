//
//  NSKScene.m
//  NodeSpriteKit
//
//  Created by Kevin Whinnery on 11/4/13.
//  Copyright (c) 2013 Kevin Whinnery. All rights reserved.
//

#import "NSKScene.h"
#import "NSKUtils.h"

@implementation NSKScene

// Update managed properties on a scene, given the options specified
+(void)updateScene:(NSKScene*)scene withOptions:(NSDictionary*)options
{
    scene.context = [JSContext currentContext];
    scene.backgroundColor = [NSKUtils colorForHex:[options valueForKey:@"backgroundColor"]];
    scene.scaleMode = SKSceneScaleModeAspectFill;
}

// Create a managed scene
+(id)create:(NSDictionary *)options
{
    NSKScene *scene = [[NSKScene alloc] initWithSize:CGSizeMake([[options valueForKey:@"width"] floatValue],
                                                                [[options valueForKey:@"height"] floatValue])];
    [NSKScene updateScene:scene withOptions:options];
    
    return scene;
}

// Update a scene
-(void)updateScene:(NSDictionary*)options
{
    [NSKScene updateScene:self withOptions:options];
}

// called for every turn of the run loop
/*
-(void)update:(NSTimeInterval)currentTime
{
    [super update:currentTime];
}
 */

// Handle touch events
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint positionInScene = [touch locationInNode:self];
    NSKScene *scene = (NSKScene*) self.scene;
    [scene fireEvent:@{@"eventType":@"touch",
                       @"target":@"scene",
                       @"data":@{@"x": [NSNumber numberWithFloat:positionInScene.x],
                                 @"y": [NSNumber numberWithFloat:positionInScene.y]}}];
}

// Fire an event back into JS
-(void)fireEvent:(NSDictionary *)data
{
    JSValue *eventResponder = self.context[@"__eventResponder"];
    [eventResponder callWithArguments:@[data]];
}

@end
