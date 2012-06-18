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

- (id)init 
{
    self = [super init];
    if (self) {
        /*Initialize speech synthesizer*/
        speechSynth = [[NSSpeechSynthesizer alloc] initWithVoice:[NSSpeechSynthesizer defaultVoice]];
        [speechSynth setDelegate:self];
        
        /*Get Desktop Path*/
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDesktopDirectory,NSUserDomainMask, YES);
        desktopPath = [paths objectAtIndex:0];
        j=0;
    }
    return self;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [InputFilePathTextField setStringValue:desktopPath];
    [OutputFilesNameTextField setStringValue:@"OutputFile"];
}

- (void)speechSynthesizer:(NSSpeechSynthesizer *)sender didFinishSpeaking:(BOOL)finishedSpeaking
{
    NSLog(@"Started Synthesizing");
    int numberOfCycles = [wordsArray count]/1000;
    NSMutableString *tempString = [[NSMutableString alloc] init];
    if (j<numberOfCycles) {
        for (int i=0; i<1000; i++) {
            [tempString appendFormat:@" %@", [wordsArray objectAtIndex:i+1000*j]];
        }
        synthesizeToFile(speechSynth, desktopPath, @"1984", j, tempString);
    }
    j++;
    NSLog(@"Finished Synthesizing");
}

-(IBAction)HSProcessText:(id)sender
{
    NSString *sourcePath = [InputFilePathTextField stringValue];
    NSString *text = [[NSString alloc] initWithContentsOfFile:sourcePath encoding:4 error:NULL];
    wordsArray = [text componentsSeparatedByString:@" "];
    
    [speechSynth startSpeakingString:@"Processing"];
}

@end
