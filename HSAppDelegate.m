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
@synthesize VoicesTable;

-(id)init{
    self = [super init];
    if (self) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDesktopDirectory,NSUserDomainMask, YES);
        desktopPath = [paths objectAtIndex:0];
        
        speechSynthesizer = [[NSSpeechSynthesizer alloc] initWithVoice:[NSSpeechSynthesizer defaultVoice]];
        [speechSynthesizer setDelegate:self];
        voiceList = [NSSpeechSynthesizer availableVoices];
        
        NSLog(@"%@",voiceList);
    }
    return self;
}
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification{
    [InputFilePathTextField setStringValue:[desktopPath stringByAppendingFormat:@"/1984.txt"]];
    [OutputFilesNameTextField setStringValue:@"1984"];
    [TimePerFileTextField setIntValue:10];
}

-(IBAction)HSProcessText:(id)sender{
    NSString *sourcePath = [InputFilePathTextField stringValue];
    talker = [[HSTalker alloc] initWithContentsOfFile:sourcePath 
                                              andOutputFileName:[OutputFilesNameTextField stringValue] 
                                                  andSpeechRate:[SpeechRateSlider intValue] 
                                              andMinutesPerFile:[TimePerFileTextField intValue]
                                           andSpeechSynthesizer:speechSynthesizer ];
    [talker startProcessing];
}
-(void)speechSynthesizer:(NSSpeechSynthesizer *)sender didFinishSpeaking:(BOOL)finishedSpeaking{
    [talker synthesizeFiles];
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)VoicesTable{
    return (NSInteger)[voiceList count];
}
- (id)tableView:(NSTableView *)VoicesTable objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    NSString *v = [voiceList objectAtIndex:row];
    NSDictionary *dict = [NSSpeechSynthesizer attributesForVoice:v]; return [dict objectForKey:NSVoiceName];
}
- (void)tableViewSelectionDidChange:(NSNotification *)notification{
    NSInteger row = [VoicesTable selectedRow];
    if (row == -1) {
        return; 
    }
    NSString *selectedVoice = [voiceList objectAtIndex:row];
    [speechSynthesizer setVoice:selectedVoice];
    NSLog(@"new voice = %@", selectedVoice);
}

@end
