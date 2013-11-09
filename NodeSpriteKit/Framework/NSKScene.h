//
//  NSKScene.h
//  NodeSpriteKit
//
//  Created by Kevin Whinnery on 11/4/13.
//  Copyright (c) 2013 Kevin Whinnery. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol NSKSceneExports <JSExport>

// Interface availble to JS
+(id)create:(NSDictionary*)options;
-(void)updateScene:(NSDictionary*)options;
-(void)addChild:(SKNode*)node; // expose underlying superclass method

@end

@interface NSKScene : SKScene <NSKSceneExports>

// Handle on the current JS context
@property (nonatomic) JSContext *context;

// Native only interface
-(void)touchesBegan:(NSSet *)touches
          withEvent:(UIEvent *)event
         withTarget:(SKNode*)target;

-(void)touchesMoved:(NSSet *)touches
          withEvent:(UIEvent *)event
         withTarget:(SKNode*)target;

-(void)touchesEnded:(NSSet *)touches
          withEvent:(UIEvent *)event
         withTarget:(SKNode*)target;

-(void)touchesCancelled:(NSSet *)touches
              withEvent:(UIEvent *)event
             withTarget:(SKNode*)target;

@end
