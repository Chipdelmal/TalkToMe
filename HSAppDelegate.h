//
//  HSAppDelegate.h
//  TalkToMe
//
//  Created by Chip on 6/13/12.
//  Copyright (c) 2012 __Heimlich Counter-Maneuver__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface HSAppDelegate : NSObject <NSApplicationDelegate>{
    NSString *desktopPath;
    NSSpeechSynthesizer *speechSynth;
}

@property (assign) IBOutlet NSWindow *window;

@end
