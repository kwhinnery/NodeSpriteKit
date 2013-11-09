//
//  NSKScene.m
//  NodeSpriteKit
//
//  Created by Kevin Whinnery on 11/4/13.
//  Copyright (c) 2013 Kevin Whinnery. All rights reserved.
//

#import "NSKScene.h"
#import "NSKUtils.h"

@interface NSKScene()
{
    
}

@property (nonatomic, strong) NSMutableArray *eventQueue;

@end

@implementation NSKScene

// Update managed properties on a scene, given the options specified
+(void)updateScene:(NSKScene*)scene
       withOptions:(NSDictionary*)options
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
    scene.eventQueue = [[NSMutableArray alloc] init];
    [NSKScene updateScene:scene withOptions:options];
    return scene;
}

// Update a scene
-(void)updateScene:(NSDictionary*)options
{
    [NSKScene updateScene:self withOptions:options];
}

// called for every turn of the run loop to allow JS to act (if needed)
-(void)update:(NSTimeInterval)currentTime
{
    [super update:currentTime];
    [self.eventQueue addObject:@{@"eventType":@"update",
                            @"target":@"scene",
                            @"currentTime":[NSNumber numberWithDouble:currentTime]}];
    
    JSValue *eventResponder = self.context[@"__eventResponder"];
    [eventResponder callWithArguments:@[self.eventQueue]];
    [self.eventQueue removeAllObjects];
}

// Deal with touch events, and queue them up for deliver to JavaScript on the next run loop pass
-(void)touchesBegan:(NSSet *)touches
          withEvent:(UIEvent *)event
         withTarget:(SKNode*)target
{
    // Set up event data
    NSMutableDictionary *eventData = [[NSMutableDictionary alloc] init];
    [eventData setObject:@"touch" forKey:@"eventType"];
    
    // Set the target for consumption in JavaScript
    if (target) {
        [eventData setObject:target.name forKey:@"target"];
    } else {
        [eventData setObject:@"scene" forKey:@"target"];
    }
    
    // Grab some default values for the first touch we get
    BOOL firstTouch = YES;
    NSMutableArray *touchesData = [[NSMutableArray alloc] init];
    
    // go through all touches and grab their data
    for (UITouch *touch in touches) {
        // Set the global touch location for the first touch
        if (firstTouch) {
            CGPoint location = [touch locationInNode:self];
            [eventData setObject:[NSNumber numberWithFloat:location.x]
                          forKey:@"x"];
            [eventData setObject:[NSNumber numberWithFloat:location.y]
                          forKey:@"y"];
            
            // Get relative touch info, if needed
            if (target) {
                CGPoint location = [touch locationInNode:target];
                [eventData setObject:[NSNumber numberWithFloat:location.x]
                              forKey:@"localX"];
                [eventData setObject:[NSNumber numberWithFloat:location.y]
                              forKey:@"localY"];
            }
            firstTouch = NO;
        } else {
            // Add all additional touches to an array, should the developer need/want them
            NSMutableDictionary *touchData = [[NSMutableDictionary alloc] init];
            CGPoint location = [touch locationInNode:self];
            [touchData setObject:[NSNumber numberWithFloat:location.x]
                          forKey:@"x"];
            [touchData setObject:[NSNumber numberWithFloat:location.y]
                          forKey:@"y"];
            
            // Get relative touch info, if needed
            if (target) {
                CGPoint location = [touch locationInNode:target];
                [touchData setObject:[NSNumber numberWithFloat:location.x]
                              forKey:@"localX"];
                [touchData setObject:[NSNumber numberWithFloat:location.y]
                              forKey:@"localY"];
            }
            
            [touchesData addObject:touchData];
        }
    }
    
    // Assign touch events array to event
    [eventData setObject:touchesData forKey:@"touches"];
    
    // Add event to the queue
    [self.eventQueue addObject:eventData];
}

-(void)touchesMoved:(NSSet *)touches
          withEvent:(UIEvent *)event
         withTarget:(SKNode*)target
{
    //derp
}

-(void)touchesEnded:(NSSet *)touches
          withEvent:(UIEvent *)event
         withTarget:(SKNode*)target
{
    //derp
}

-(void)touchesCancelled:(NSSet *)touches
              withEvent:(UIEvent *)event
             withTarget:(SKNode*)target
{
    //derp
}

// Handle touch events
-(void)touchesBegan:(NSSet *)touches
          withEvent:(UIEvent *)event
{
    [self touchesBegan:touches
             withEvent:event
            withTarget:nil];
}

-(void)touchesMoved:(NSSet *)touches
          withEvent:(UIEvent *)event
{
    [self touchesMoved:touches
             withEvent:event
            withTarget:nil];
}

-(void)touchesEnded:(NSSet *)touches
          withEvent:(UIEvent *)event
{
    [self touchesEnded:touches
             withEvent:event
            withTarget:nil];
}

-(void)touchesCancelled:(NSSet *)touches
              withEvent:(UIEvent *)event
{
    [self touchesCancelled:touches
                 withEvent:event
                withTarget:nil];
}

@end
