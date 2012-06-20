//
//  HSTalker.m
//  TalkToMe
//
//  Created by Chip on 6/18/12.
//  Copyright (c) 2012 __Héctor Sánchez__. All rights reserved.
//

#import "HSTalker.h"

@implementation HSTalker

-(id)init{
    return [self initWithContentsOfFile:NULL andOutputFileName:NULL];
}
-(id)initWithContentsOfFile:(NSString *)filePath andOutputFileName:(NSString *)fileName{
    self = [super init];
    if(self){
        /*Initialize speech synthesizer*/
        speechSynth = [[NSSpeechSynthesizer alloc] initWithVoice:[NSSpeechSynthesizer defaultVoice]];
        [speechSynth setDelegate:self];
        
        /*Separate words into array*/
        NSString *text = [[NSString alloc] initWithContentsOfFile:filePath encoding:4 error:NULL];
        wordsArray = [text componentsSeparatedByString:@" "];
        numberOfWords = 1000;
        numberOfCycles = [wordsArray count]/numberOfWords;
        
        /*Get Desktop Path*/
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDesktopDirectory,NSUserDomainMask, YES);
        desktopPath = [paths objectAtIndex:0];
        outputFileName = fileName;
    }
    return self;
}

-(void)startProcessing{
    [speechSynth startSpeakingString:@"Processing"];
}
- (void)speechSynthesizer:(NSSpeechSynthesizer *)sender didFinishSpeaking:(BOOL)finishedSpeaking{
    NSLog(@"Started Synthesizing");
    NSMutableString *tempString = [[NSMutableString alloc] init];
    if (wordIndex<numberOfCycles) {
        for (int i=0; i<numberOfWords; i++) {
            [tempString appendFormat:@" %@", [wordsArray objectAtIndex:i+numberOfWords*wordIndex]];
        }
        synthesizeToFile(speechSynth, desktopPath, outputFileName, wordIndex, tempString);
    }
    wordIndex++;
    NSLog(@"Finished Synthesizing");
}



@end
