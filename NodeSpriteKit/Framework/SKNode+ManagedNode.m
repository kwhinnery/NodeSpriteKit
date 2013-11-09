//
//  SKNode+ManagedNode.m
//  NodeSpriteKit
//
//  Created by Kevin Whinnery on 11/9/13.
//  Copyright (c) 2013 Kevin Whinnery. All rights reserved.
//

#import "SKNode+ManagedNode.h"
#import "NSKScene.h"

@implementation SKNode (ManagedNode)

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSKScene *scene = (NSKScene*)self.scene;
    [scene touchesBegan:touches withEvent:event withTarget:self];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSKScene *scene = (NSKScene*)self.scene;
    [scene touchesMoved:touches withEvent:event withTarget:self];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSKScene *scene = (NSKScene*)self.scene;
    [scene touchesEnded:touches withEvent:event withTarget:self];
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSKScene *scene = (NSKScene*)self.scene;
    [scene touchesCancelled:touches withEvent:event withTarget:self];
}

@end
