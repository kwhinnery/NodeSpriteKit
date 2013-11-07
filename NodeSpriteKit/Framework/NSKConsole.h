//
//  NSKConsole.h
//  NodeSpriteKit
//
//  Created by Kevin Whinnery on 11/4/13.
//  Copyright (c) 2013 Kevin Whinnery. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol NSKConsoleExports <JSExport>

// Interface availble to JS
+(void)log:(NSString*)message;
+(void)error:(NSString*)message;

@end

@interface NSKConsole : NSObject <NSKConsoleExports>

// Native only interface

@end
