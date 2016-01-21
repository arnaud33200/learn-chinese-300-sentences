//
//  AVAudioSectionRowPlayer.h
//  PinYinTableSound
//
//  Created by Arnaud on 2016-01-20.
//  Copyright © 2016 Arnaud. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

@interface AVAudioSectionRowPlayer : AVAudioPlayer

@property NSInteger section;
@property NSInteger row;

@end
