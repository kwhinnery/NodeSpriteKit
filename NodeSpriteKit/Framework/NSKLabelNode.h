//
//  NSKLabelNode.h
//  NodeSpriteKit
//
//  Created by Kevin Whinnery on 11/4/13.
//  Copyright (c) 2013 Kevin Whinnery. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol NSKLabelNodeExports <JSExport>

// Interface availble to JS
+(id)create:(NSDictionary*)options;
-(void)update:(NSDictionary*)options;
-(void)addPhysics:(NSDictionary*)options;

@end

@interface NSKLabelNode : SKLabelNode <NSKLabelNodeExports>

@end
