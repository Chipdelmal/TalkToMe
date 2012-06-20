//
//  HSTalkingFunctions.m
//  TalkToMe
//
//  Created by Chip on 6/18/12.
//  Copyright (c) 2012 __Héctor Sánchez__. All rights reserved.
//

#import "HSTalkingFunctions.h"

@implementation HSTalkingFunctions

void synthesizeToFile(NSSpeechSynthesizer *synthesizer, NSString *path, NSString *fileName, int fileIndex, NSString *stringToSynthesize){
    NSString *fileNameLocal;
    if (fileIndex<10) {
        fileNameLocal = [[NSString alloc] initWithFormat:@"%@_0%i.aiff", fileName, fileIndex];
    }else {
        fileNameLocal = [[NSString alloc] initWithFormat:@"%@_%i.aiff", fileName, fileIndex];
    }
        
    NSString *outputFullPath = [[NSString alloc] initWithFormat:@"%@/%@",path, fileNameLocal];
    [synthesizer startSpeakingString:stringToSynthesize toURL:[NSURL URLWithString:outputFullPath]];
}

@end
