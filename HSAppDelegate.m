//
//  HSAppDelegate.m
//  TalkToMe
//
//  Created by Chip on 6/13/12.
//  Copyright (c) 2012 __Heimlich Counter-Maneuver__. All rights reserved.
//

#import "HSAppDelegate.h"

@implementation HSAppDelegate

@synthesize window = _window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // text to speak
	NSString *text = [[NSString alloc] initWithString:@"This is only a test"];
	
	// file to save to
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDesktopDirectory,NSUserDomainMask, YES);
    NSString *desktopPath = [paths objectAtIndex:0];
	NSString *path = [[NSString alloc] initWithString:desktopPath];
    NSString *fullPath = [[NSString alloc] initWithFormat:@"%@/%@", path,@"test.aiff"];
	NSLog(@"%@",fullPath);
    
	NSSpeechSynthesizer *speechSynth = [[NSSpeechSynthesizer alloc] initWithVoice:[NSSpeechSynthesizer defaultVoice]];
	
	// synthesizes text into a sound (AIFF) file
	[speechSynth startSpeakingString:text toURL:[NSURL URLWithString:fullPath]];
	
}

@end
