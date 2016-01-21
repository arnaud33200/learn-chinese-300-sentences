//
//  ToggleUIButton.m
//  PinYinTableSound
//
//  Created by Arnaud on 2016-01-20.
//  Copyright © 2016 Arnaud. All rights reserved.
//

#import "ToggleUIButton.h"

@implementation ToggleUIButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)togglePressed {
    [self setIsPressed:!self.isPressed];
}

- (void)setIsPressed:(BOOL)isPressed {
    _isPressed = isPressed;
    if (_isPressed) {
        self.alpha = 1.0;
    } else {
        self.alpha = 0.5;
    }
}

@end
