//
//  NSKViewController.m
//  NodeSpriteKit
//
//  Created by Kevin Whinnery on 11/4/13.
//  Copyright (c) 2013 Kevin Whinnery. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

#import "NSKViewController.h"

// Exports
#import "NSKConsole.h"
#import "NSKScene.h"
#import "NSKLabelNode.h"
#import "NSKSpriteNode.h"

@interface NSKViewController () {
    JSContext *_context;
    BOOL _nodeCount;
    BOOL _showFPS;
}

@end

@implementation NSKViewController

// Set up JS context with some standard functions and our SpriteKit exports
-(void)setupContext
{
    // Set up global function that module can override
    [_context evaluateScript:@"var __eventResponder = function() {};"];
    
    // Set some globals for important UI stuff
    _context[@"__height"] = [NSNumber numberWithFloat:self.view.bounds.size.height];
    _context[@"__width"] = [NSNumber numberWithFloat:self.view.bounds.size.width];
    
    // A simple visual alert, set up with a block
    _context[@"alert"] = ^(NSString* message, NSString* title) {
        if (!title || [title isEqualToString:@"undefined"]) {
            title = @"";
        }
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle: @"OK"
                                              otherButtonTitles: nil];
        [alert show];
    };
    
    // More complex object exports
    _context[@"console"] = [NSKConsole class];
    _context[@"__NSKScene"] = [NSKScene class];
    _context[@"__NSKLabelNode"] = [NSKLabelNode class];
    _context[@"__NSKSpriteNode"] = [NSKSpriteNode class];
    
    // Interface to present a constructed scene
    SKView *skView = (SKView*) self.view;
    _context[@"__presentScene"] = ^(NSKScene* scene) {
        [skView presentScene:scene];
    };
}

-(id)initWithNodeCount:(BOOL)nodeCount andFPS:(BOOL)showFPS
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _nodeCount = nodeCount;
        _showFPS = showFPS;
    }
    return self;
}

- (void)loadView
{
    self.view  = [[SKView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Create an SKView to dock in the scene
    SKView *skView = (SKView*) self.view;
    skView.showsFPS = _showFPS;
    skView.showsNodeCount = _nodeCount;
    
    // Create a JS Context to eval JavaScript code
    _context = [[JSContext alloc] init];
    _context.exceptionHandler =  ^void(JSContext *context, JSValue *exception) {
        NSDictionary *d = [exception toDictionary];
        if (d) {
            [NSKConsole error:[NSString stringWithFormat:@"Exception on line %@ of browserified script: %@",
                               [d objectForKey:@"line"],
                               exception]];
            [NSKConsole error:[NSString stringWithFormat:@"Stack: %@", [d objectForKey:@"stack"]]];
        }
    };
    
    // Export SpriteKit and native code
    [self setupContext];
    
    // Load in game JS from bundle
    NSString *srcPath = [[NSBundle mainBundle] pathForResource:@"gamebundle"
                                                        ofType:@"js"];

    NSError *err;
    NSString *src = [NSString stringWithContentsOfFile:srcPath
                                              encoding:NSUTF8StringEncoding
                                                 error:&err];
    
    // Handle any error loading the js code
    if (err) {
        NSLog(@"There was a problem loading the app script from the bundle: %@", err);
    } else {
        // Evaluate actual game code
        [_context evaluateScript:src];
    }
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationPortrait;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
