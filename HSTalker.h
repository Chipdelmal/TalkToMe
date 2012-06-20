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
    NSString *outputFileName;
    NSArray *wordsArray;
    NSSpeechSynthesizer *speechSynth;
}

-(id)init;
-(id)initWithContentsOfFile:(NSString *)filePath andOutputFileName:(NSString *)fileName;

-(void)startProcessing;

@end
