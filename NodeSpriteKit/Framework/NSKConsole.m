//
//  NSKConsole.m
//  NodeSpriteKit
//
//  Created by Kevin Whinnery on 11/4/13.
//  Copyright (c) 2013 Kevin Whinnery. All rights reserved.
//

#import "NSKConsole.h"

@implementation NSKConsole

+(void)log:(NSString *)message
{
    NSLog(@"[JS Log]: %@", message);
}

+(void)error:(NSString *)message
{
    NSLog(@"[JS Error]: %@", message);
}

@end
