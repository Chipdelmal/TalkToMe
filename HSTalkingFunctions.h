//
//  HSTalkingFunctions.h
//  TalkToMe
//
//  Created by Chip on 6/18/12.
//  Copyright (c) 2012 __Héctor Sánchez__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HSTalkingFunctions : NSObject

void synthesizeToFile(NSSpeechSynthesizer *synthesizer, NSString *path, NSString *fileName, int fileIndex, NSString *stringToSynthesize);

@end
