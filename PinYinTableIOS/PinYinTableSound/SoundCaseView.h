//
//  SoundCaseView.h
//  PinYinTableSound
//
//  Created by Arnaud on 2016-01-18.
//  Copyright © 2016 Arnaud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface SoundCaseView : UIView

@property (strong, nonatomic) IBOutlet UIView *view;

@property NSInteger tone1;
@property NSInteger tone2;

@property AVAudioPlayer *player;

@end
