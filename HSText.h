//
//  HSText.h
//  TalkToMe
//
//  Created by Chip on 6/14/12.
//  Copyright (c) 2012 __Heimlich Counter-Maneuver__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HSText : NSObject{
    NSString *textString;
}
-(id)init;
-(id)initWithString:(NSString *)initializerString;

@property (strong, readonly) NSString *textString;

@end
