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

- (id)init {
    self = [super init];
    if (self) {
        NSLog(@"init");
        //Initialize speech synthesizer
        speechSynth = [[NSSpeechSynthesizer alloc] initWithVoice:[NSSpeechSynthesizer defaultVoice]];
        [speechSynth setDelegate:self];
        //Get Desktop Path
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDesktopDirectory,NSUserDomainMask, YES);
        desktopPath = [paths objectAtIndex:0];
    }
    return self;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    //Set path to write int
	NSString *path = [[NSString alloc] initWithString:desktopPath];
    //NSString *outputPath = [[NSString alloc] initWithFormat:@"%@/%@", path,@"test.aiff"];
	//NSLog(@"%@",outputPath);
    //Get file
    NSString *sourcePath = [[NSString alloc] initWithFormat:@"%@/%@", path,@"1984_Chapter1.txt"];
    
    //Initialize text to be spoken
	NSString *text = [[NSString alloc] initWithContentsOfFile:sourcePath encoding:4 error:NULL];
    //int numberOfWords = [[NSSpellChecker sharedSpellChecker] countWordsInString:text language:nil];
    //NSLog(@"%@:: \nNumber of Words: %i", text, numberOfWords);
    
    //Separate words
    NSArray *wordsArray = [text componentsSeparatedByString:@" "];
    int numberOfCycles = [wordsArray count]/1000;
    NSMutableString *tempString = [[NSMutableString alloc] init];
    for (int j=0; j<numberOfCycles; j++) {
        for (int i=0; i<1000; i++) {
            [tempString appendFormat:@" %@", [wordsArray objectAtIndex:i+1000*j]];
        }
        //NSLog(@"%@", tempString);
        //NSLog(@"-----");
        NSString *fileName = [[NSString alloc] initWithFormat:@"test%i.aiff",j];
        NSString *outputFullPath = [[NSString alloc] initWithFormat:@"%@/%@", path, fileName];
        [speechSynth startSpeakingString:tempString toURL:[NSURL URLWithString:outputFullPath]];
        [tempString setString:@""];
    }
    
    
	//Write speech to a file
	//[speechSynth startSpeakingString:text toURL:[NSURL URLWithString:outputPath]];
}

- (void)speechSynthesizer:(NSSpeechSynthesizer *)sender didFinishSpeaking:(BOOL)finishedSpeaking
{
    NSLog(@"Finished");
}

@end
