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
@synthesize TestButton;
@synthesize ProgressIndicator;


-(id)init{
    self = [super init];
    if (self) {
        remainingCycles = 0;
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDesktopDirectory,NSUserDomainMask, YES);
        desktopPath = [paths objectAtIndex:0];
        
        speechSynthesizer = [[NSSpeechSynthesizer alloc] initWithVoice:[NSSpeechSynthesizer defaultVoice]];
        [speechSynthesizer setDelegate:self];
        voiceList = [NSSpeechSynthesizer availableVoices];
        
        NSLog(@"%@",voiceList);
    }
    return self;
}
-(void)applicationDidFinishLaunching:(NSNotification *)aNotification{
    [ProcessingIndicator setHidden:TRUE];
    [ProgressIndicator setHidden:TRUE];
    
    [InputFilePathTextField setStringValue:desktopPath];
    //[InputFilePathTextField setStringValue:[desktopPath stringByAppendingFormat:@"/1984.txt"]];
    [OutputFilesNameTextField setStringValue:@"Output"];
    [TimePerFileTextField setIntValue:10];
    
    [self HSQuotesToArray:self];
    //[StopButton setEnabled:FALSE];
}
-(void)awakeFromNib{
    // When the table view appears on screen, the default voice
    // should be selected
    NSString *defaultVoice = [NSSpeechSynthesizer defaultVoice];
    NSInteger defaultRow = [voiceList indexOfObject:defaultVoice];
    NSIndexSet *indices = [NSIndexSet indexSetWithIndex:defaultRow];
    [VoicesTable selectRowIndexes:indices byExtendingSelection:NO];
    [VoicesTable scrollRowToVisible:defaultRow];
}

-(IBAction)HSQuotesToArray:(id)sender{
    /*Converts a txt file placed in the app's resources into an array of strings separated by the "\n" symbol*/
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"TestQuotes" ofType:@"txt"];  
    NSString *quotes = [[NSMutableString alloc] initWithContentsOfFile:filePath encoding:4 error:NULL]; 
    NSArray *sentencesArray = [[NSArray alloc] initWithArray:[quotes componentsSeparatedByString:@"\n"]];
    NSMutableArray *sentencesCleanArray = [[NSMutableArray alloc] init];
    for (int i=0; i<[sentencesArray count]; i++) {
        NSMutableString *tempString = [[NSMutableString alloc] initWithString:[[sentencesArray objectAtIndex:i] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
        [tempString appendString:@"."];
        [sentencesCleanArray addObject:tempString];
    }
    quotesArray = sentencesCleanArray;
    NSLog(@"Quotes Array:\n%@",quotesArray); 
}
-(IBAction)HSProcessText:(id)sender{
    NSString *sourcePath = [InputFilePathTextField stringValue];
    talker = [[HSTalker alloc] initWithContentsOfFile:sourcePath 
                                    andOutputFileName:[OutputFilesNameTextField stringValue] 
                                        andSpeechRate:[SpeechRateSlider intValue] 
                                    andMinutesPerFile:([TimePerFileTextField intValue]-3)
                                 andSpeechSynthesizer:speechSynthesizer ];
    [ProgressIndicator setMinValue:0];
    [ProgressIndicator setMaxValue:[talker numberOfCycles]];
    [ProgressIndicator setDoubleValue:0];
    [ProgressIndicator setHidden:FALSE];
    [talker startProcessing];
}
-(IBAction)HSTestSynthesizer:(id)sender{
    int randomNumber = arc4random() % [quotesArray count];
    [speechSynthesizer startSpeakingString:[quotesArray objectAtIndex:randomNumber]];
    [ProgressIndicator setDoubleValue:0];
}
-(void)speechSynthesizer:(NSSpeechSynthesizer *)sender didFinishSpeaking:(BOOL)finishedSpeaking{
    [talker synthesizeFiles];
    remainingCycles = [talker remainingCycles];
    [ProgressIndicator incrementBy:1];
    if (remainingCycles>0) {
        [ProcessingIndicator setHidden:FALSE];
        [ProcessingIndicator startAnimation:self];
        [MessagesLabel setStringValue:@"Processing! Your files will be saved on your desktop."];
        [VoicesTable setEnabled:FALSE];
        [SynthesizeButton setEnabled:FALSE];
        [InputFilePathTextField setEnabled:FALSE];
        [OutputFilesNameTextField setEnabled:FALSE];
        [SpeechRateSlider setEnabled:FALSE];
        [TimePerFileTextField setEnabled:FALSE];
        [TestButton setEnabled:FALSE];
    }else{
        [ProcessingIndicator setHidden:TRUE];
        [ProcessingIndicator stopAnimation:self];
        [MessagesLabel setStringValue:@"Finished Synthesizing."];
        [VoicesTable setEnabled:TRUE];
        [SynthesizeButton setEnabled:TRUE];
        [InputFilePathTextField setEnabled:TRUE];
        [OutputFilesNameTextField setEnabled:TRUE];
        [SpeechRateSlider setEnabled:TRUE];
        [TimePerFileTextField setEnabled:TRUE];
        [TestButton setEnabled:TRUE];
        [ProgressIndicator setHidden:TRUE];
    }
}

-(IBAction)sliderChange:(id)sender{
    [speechSynthesizer setRate:[SpeechRateSlider intValue]];
}
-(NSInteger)numberOfRowsInTableView:(NSTableView *)VoicesTable{
    return (NSInteger)[voiceList count];
}
-(id)tableView:(NSTableView *)VoicesTable objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    NSString *v = [voiceList objectAtIndex:row];
    NSDictionary *dict = [NSSpeechSynthesizer attributesForVoice:v]; return [dict objectForKey:NSVoiceName];
}
-(void)tableViewSelectionDidChange:(NSNotification *)notification{
    NSInteger row = [VoicesTable selectedRow];
    if (row == -1) {
        return; 
    }
    NSString *selectedVoice = [voiceList objectAtIndex:row];
    [speechSynthesizer setVoice:selectedVoice];
    //NSLog(@"new voice = %@", selectedVoice);
}

@end
