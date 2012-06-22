//
//  HSTalker.h
//  TalkToMe
//
//  Created by Chip on 6/18/12.
//  Copyright (c) 2012 __Héctor Sánchez__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HSTalkingFunctions.h"

@interface HSTalker : NSObject{
    int wordIndex;
    int numberOfCycles;
    int numberOfWords;
    NSString *desktopPath;
    NSString *folderPath;
    NSString *outputFileName;
    NSArray *wordsArray;
    NSSpeechSynthesizer *speechSynth;
}

-(id)init;
-(id)initWithContentsOfFile:(NSString *)filePath andOutputFileName:(NSString *)fileName andSpeechRate:(int)speechRate andMinutesPerFile:(int)minutesPerFile andSpeechSynthesizer:(NSSpeechSynthesizer *)speechSynthesizer;

-(void)startProcessing;
-(void)synthesizeFiles;

@end
