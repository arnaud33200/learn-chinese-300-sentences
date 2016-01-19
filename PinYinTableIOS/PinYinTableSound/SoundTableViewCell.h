//
//  SoundTableViewCell.h
//  PinYinTableSound
//
//  Created by Arnaud on 2016-01-18.
//  Copyright © 2016 Arnaud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface SoundTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *pinyinLabel;
@property (weak, nonatomic) IBOutlet UILabel *translationLabel;

@property NSInteger tone1;
@property NSInteger tone2;

@property AVAudioPlayer *player;

- (void)setTonesWithFirst:(NSInteger)t1 WithSecond:(NSInteger)t2;

@end
