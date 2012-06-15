//
//  HSText.m
//  TalkToMe
//
//  Created by Chip on 6/14/12.
//  Copyright (c) 2012 __Heimlich Counter-Maneuver__. All rights reserved.
//

#import "HSText.h"

@implementation HSText
@synthesize textString;

-(id)init{
    return [self initWithString:NULL];
}
-(id)initWithString:(NSString *)initializerString{
    self = [super init];
    if (self) {
        textString = [[NSString alloc] initWithString:initializerString];
    }
    return self;
}

@end
