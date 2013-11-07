//
//  NSKUtils.m
//  NodeSpriteKit
//
//  Created by Kevin Whinnery on 11/4/13.
//  Copyright (c) 2013 Kevin Whinnery. All rights reserved.
//

#import "NSKUtils.h"

@implementation NSKUtils

// Create a UI Color from a hex string. RGB values mean nothing to me...
+ (UIColor*)colorForHex:(NSString*) hex {
    float red, green, blue, alpha;
    
    NSString *cleanString = [hex stringByReplacingOccurrencesOfString:@"#" withString:@""];
    if([cleanString length] == 3) {
        cleanString = [NSString stringWithFormat:@"%@%@%@%@%@%@",
                       [cleanString substringWithRange:NSMakeRange(0, 1)],
                       [cleanString substringWithRange:NSMakeRange(0, 1)],
                       [cleanString substringWithRange:NSMakeRange(1, 1)],
                       [cleanString substringWithRange:NSMakeRange(1, 1)],
                       [cleanString substringWithRange:NSMakeRange(2, 1)],
                       [cleanString substringWithRange:NSMakeRange(2, 1)]];
    }
    if([cleanString length] == 6) {
        cleanString = [cleanString stringByAppendingString:@"ff"];
    }
    
    unsigned int baseValue;
    [[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue];
    
    red = ((baseValue >> 24) & 0xFF)/255.0f;
    green = ((baseValue >> 16) & 0xFF)/255.0f;
    blue = ((baseValue >> 8) & 0xFF)/255.0f;
    alpha = ((baseValue >> 0) & 0xFF)/255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

@end
