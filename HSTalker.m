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
    return [self initWithContentsOfFile:NULL andOutputFileName:NULL andSpeechRate:0 andMinutesPerFile:0];
}
-(id)initWithContentsOfFile:(NSString *)filePath andOutputFileName:(NSString *)fileName andSpeechRate:(int)speechRate andMinutesPerFile:(int)minutesPerFile{
    self = [super init];
    if(self){
        /*Initialize speech synthesizer*/
        speechSynth = [[NSSpeechSynthesizer alloc] initWithVoice:[NSSpeechSynthesizer defaultVoice]];
        [speechSynth setDelegate:self];
        [speechSynth setRate:speechRate];
        
        /*Separate words into array*/
        NSString *text = [[NSString alloc] initWithContentsOfFile:filePath encoding:4 error:NULL];
        wordsArray = [text componentsSeparatedByString:@" "];
        numberOfWords = minutesPerFile*speechRate;
        numberOfCycles = ([wordsArray count]/numberOfWords)+1;
        wordIndex = 0;
        
        /*Get Desktop Path*/
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDesktopDirectory,NSUserDomainMask, YES);
        desktopPath = [paths objectAtIndex:0];
        outputFileName = fileName;
        
        /*Create Directory*/
        folderPath = [desktopPath stringByAppendingFormat:@"/%@",fileName];
        NSFileManager *filemgr;
        filemgr = [NSFileManager defaultManager];
        NSURL *newDir = [NSURL fileURLWithPath:folderPath];
        [filemgr createDirectoryAtURL:newDir withIntermediateDirectories:YES attributes: nil error:nil];
    }
    return self;
}

-(void)startProcessing{
    [speechSynth startSpeakingString:@"Processing"];
}
- (void)speechSynthesizer:(NSSpeechSynthesizer *)sender didFinishSpeaking:(BOOL)finishedSpeaking{
    NSMutableString *tempString = [[NSMutableString alloc] init];
    if (wordIndex<numberOfCycles) {
        NSLog(@"Started Synthesizing");
        if (([wordsArray count]-wordIndex*numberOfWords)>numberOfWords) {
            for (int i=0; i<numberOfWords; i++) {
                [tempString appendFormat:@" %@", [wordsArray objectAtIndex:i+numberOfWords*wordIndex]];
            }
        }else {
            for (int i=0; i<([wordsArray count]-wordIndex*numberOfWords); i++) {
                [tempString appendFormat:@" %@", [wordsArray objectAtIndex:i+numberOfWords*wordIndex]];
            }
        }
        synthesizeToFile(speechSynth, folderPath, outputFileName, wordIndex, tempString);
        NSLog(@"Finished Synthesizing: %@_%i",outputFileName,wordIndex);
        wordIndex++;  
    }
      
}


@end
