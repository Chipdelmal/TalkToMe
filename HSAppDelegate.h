//
//  HSAppDelegate.h
//  TalkToMe
//
//  Created by Chip on 6/13/12.
//  Copyright (c) 2012 __Héctor Sánchez__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "HSTalkingFunctions.h"
#import "HSTalker.h"

@interface HSAppDelegate : NSObject <NSApplicationDelegate>{
    NSString *desktopPath;
    NSSpeechSynthesizer *speechSynthesizer;
    HSTalker *talker;
    NSArray *voiceList;
    NSMutableArray *quotesArray;
    int remainingCycles;
}

-(IBAction)HSProcessText:(id)sender;
//-(IBAction)HSStopProcessText:(id)sender;
-(IBAction)HSTestSynthesizer:(id)sender;
-(IBAction)HSQuotesToArray:(id)sender;

@property (assign) IBOutlet NSWindow    *window;
@property (weak) IBOutlet NSTextField   *InputFilePathTextField;
@property (weak) IBOutlet NSTextField   *OutputFilesNameTextField;
@property (weak) IBOutlet NSSlider      *SpeechRateSlider;
@property (weak) IBOutlet NSTextField   *SpeechRateLabel;
@property (weak) IBOutlet NSTextField   *TimePerFileTextField;
@property (weak) IBOutlet NSButton      *SynthesizeButton;
@property (weak) IBOutlet NSTextField   *MessagesLabel;
@property (weak) IBOutlet NSProgressIndicator   *ProcessingIndicator;
@property (weak) IBOutlet NSTableView   *VoicesTable;
@property (weak) IBOutlet NSButton      *TestButton;
@property (weak) IBOutlet NSProgressIndicator *ProgressIndicator;

@end
