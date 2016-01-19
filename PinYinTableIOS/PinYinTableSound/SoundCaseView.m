//
//  SoundCaseView.m
//  PinYinTableSound
//
//  Created by Arnaud on 2016-01-18.
//  Copyright © 2016 Arnaud. All rights reserved.
//

#import "SoundCaseView.h"

@implementation SoundCaseView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SoundCaseView" owner:self options:nil];
        [self addSubview:self.view];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        tap.numberOfTapsRequired = 1;
        [self.view addGestureRecognizer:tap];
        
    }
    return self;
}

- (void)setTonesWithFirst:(NSInteger)t1 WithSecond:(NSInteger)t2 {
    self.tone1 = t1;
    self.tone2 = t2;
    NSString *path = [NSString stringWithFormat:@"%d-%d-1", self.tone1, self.tone2];
    self.player = [self setPlayerWithPath:path];
}

- (void)tapAction:(UITapGestureRecognizer *)sender {
    // play the right song
    if (self.player) {
        [self.player play];
    }
    
}

- (AVAudioPlayer *)setPlayerWithPath:(NSString *)path {
    NSString *pathOne = [[NSBundle mainBundle] pathForResource:path ofType:@"mp3"];
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:pathOne] error:NULL];
    [player setNumberOfLoops:0];
    return player;
}

@end
