//
//  HSAppDelegate.m
//  TalkToMe
//
//  Created by Chip on 6/13/12.
//  Copyright (c) 2012 __Héctor Sánchez__. All rights reserved.
//

#import "HSAppDelegate.h"

@implementation HSAppDelegate

@synthesize window = _window;
@synthesize InputFilePathTextField;
@synthesize OutputFilesNameTextField;
@synthesize SpeechRateSlider;
@synthesize SpeechRateLabel;
@synthesize TimePerFileTextField;
@synthesize SynthesizeButton;
@synthesize MessagesLabel;
@synthesize ProcessingIndicator;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDesktopDirectory,NSUserDomainMask, YES);
    desktopPath = [paths objectAtIndex:0];
    
    [InputFilePathTextField setStringValue:[desktopPath stringByAppendingFormat:@"/1984.txt"]];
    [OutputFilesNameTextField setStringValue:@"1984"];
    [TimePerFileTextField setIntValue:10];
}

-(IBAction)HSProcessText:(id)sender{
    NSString *sourcePath = [InputFilePathTextField stringValue];
    HSTalker *talker = [[HSTalker alloc] initWithContentsOfFile:sourcePath 
                                              andOutputFileName:[OutputFilesNameTextField stringValue] 
                                                  andSpeechRate:[SpeechRateSlider intValue] 
                                              andMinutesPerFile:[TimePerFileTextField intValue]];
    [talker startProcessing];
}

@end
