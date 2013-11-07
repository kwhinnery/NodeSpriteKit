//
//  NSKSpriteNode.h
//  NodeSpriteKit
//
//  Created by Kevin Whinnery on 11/5/13.
//  Copyright (c) 2013 Kevin Whinnery. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol NSKSpriteNodeExports <JSExport>

// Interface availble to JS
+(id)create:(NSDictionary*)options;
-(void)update:(NSDictionary*)options;
-(void)addPhysics:(NSDictionary*)options;

@end

@interface NSKSpriteNode : SKSpriteNode <NSKSpriteNodeExports>

@end
