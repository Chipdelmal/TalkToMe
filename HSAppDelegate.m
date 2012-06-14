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
    //file to save to
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDesktopDirectory,NSUserDomainMask, YES);
    NSString *desktopPath = [paths objectAtIndex:0];
	NSString *path = [[NSString alloc] initWithString:desktopPath];
    NSString *fullPath = [[NSString alloc] initWithFormat:@"%@/%@", path,@"test.aiff"];
	NSLog(@"%@",fullPath);
    
    //file to open
    NSString *sourcePath = [[NSString alloc] initWithFormat:@"%@/%@", path,@"1984_Chapter1.txt"];
    
    //text to speak
	NSString *text = [[NSString alloc] initWithContentsOfFile:sourcePath encoding:4 error:NULL];
    NSLog(@"%@",text);
    
    
	NSSpeechSynthesizer *speechSynth = [[NSSpeechSynthesizer alloc] initWithVoice:[NSSpeechSynthesizer defaultVoice]];
	
	//synthesizes text into a sound (AIFF) file
	[speechSynth startSpeakingString:text toURL:[NSURL URLWithString:fullPath]];
	
}

@end
