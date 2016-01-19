//
//  SoundTableViewCell.m
//  PinYinTableSound
//
//  Created by Arnaud on 2016-01-18.
//  Copyright © 2016 Arnaud. All rights reserved.
//

#import "SoundTableViewCell.h"

@implementation SoundTableViewCell

- (void)awakeFromNib {
    // Initialization code
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor colorWithRed:0.007 green:0.398 blue:0.533 alpha:1.00];
    [self setSelectedTextColor:[UIColor colorWithRed:0.007 green:0.398 blue:0.533 alpha:1.00]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTonesWithFirst:(NSInteger)t1 WithSecond:(NSInteger)t2 {
    self.tone1 = t1;
    self.tone2 = t2;
    NSString *path = [NSString stringWithFormat:@"%d-%d-1", self.tone1, self.tone2];
    self.player = [self setPlayerWithPath:path];
}

- (AVAudioPlayer *)setPlayerWithPath:(NSString *)path {
    NSString *pathOne = [[NSBundle mainBundle] pathForResource:path ofType:@"mp3"];
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:pathOne] error:NULL];
    [player setNumberOfLoops:0];
    return player;
}

@end
