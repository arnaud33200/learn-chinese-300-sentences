//
//  ToggleUIButton.h
//  PinYinTableSound
//
//  Created by Arnaud on 2016-01-20.
//  Copyright © 2016 Arnaud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToggleUIButton : UIButton

@property BOOL isPressed;

- (void)togglePressed;

@end
