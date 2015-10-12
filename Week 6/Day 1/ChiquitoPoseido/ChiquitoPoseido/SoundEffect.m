//
//  SoundEffect.m
//  ChiquitoPoseido
//
//  Created by Diego Freniche Brito on 09/07/14.
//  Copyright (c) 2014 freniche. All rights reserved.
//

#import "SoundEffect.h"
#import <AVFoundation/AVFoundation.h>

@interface SoundEffect () <AVAudioPlayerDelegate>
@property (nonatomic, strong) AVAudioPlayer *player;

@end

@implementation SoundEffect

- (void)play:(NSString *)soundFileName {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:soundFileName ofType:@"wav"];
    NSError *err = nil;
    NSData *soundData = [[NSData alloc] initWithContentsOfFile:filePath options:NSDataReadingMapped error:&err];
    
    self.player = [[AVAudioPlayer alloc] initWithData:soundData error:&err];
    self.player.numberOfLoops = 0;
    
    self.player.delegate = self;
    [self.player play];

}

- (void)stop {
    [self.player stop];
}

#pragma mark -

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    if ([self.delegate respondsToSelector:@selector(soundEffectDidFinishPlaying:)]) {
        [self.delegate soundEffectDidFinishPlaying:self];
    }
}

@end
