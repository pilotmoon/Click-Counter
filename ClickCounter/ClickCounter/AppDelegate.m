//
//  AppDelegate.m
//  ClickCounter
//
//  Created by Nicholas Moore on 09/05/2019.
//  Copyright © 2019 Pilotmoon Software. All rights reserved.
//

#import "AppDelegate.h"

static NSString *const kPrefsClicks = @"Clicks";

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTextField *labelClicks;
@property NSUInteger clicks;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    self.window.level=NSFloatingWindowLevel;
    self.clicks = [[NSUserDefaults standardUserDefaults] integerForKey:kPrefsClicks];
    [self updateDisplay];
    CFRetain((__bridge CFTypeRef)([NSEvent addGlobalMonitorForEventsMatchingMask:NSEventMaskLeftMouseUp|NSEventMaskRightMouseUp|NSEventMaskOtherMouseUp handler:^(NSEvent * _Nonnull event) {
        [self countClick];
    }]));
}

- (void)updateClicks:(NSInteger)clicks
{
    self.clicks=clicks;
    [[NSUserDefaults standardUserDefaults] setInteger:self.clicks forKey:kPrefsClicks];
    [self updateDisplay];
}

- (void)countClick
{
    [self updateClicks:self.clicks+1];
}

- (void)updateDisplay
{
    NSString * clicksString=[NSString stringWithFormat:@"%lu", self.clicks];
    [self.labelClicks setStringValue:clicksString];
}

- (IBAction)buttonClearClicked:(id)sender
{
    [self updateClicks:0];
}

@end
