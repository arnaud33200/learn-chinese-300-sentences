//
//  ViewController.h
//  PinYinTableSound
//
//  Created by Arnaud on 2016-01-18.
//  Copyright © 2016 Arnaud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SoundCaseView.h"


@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet SoundCaseView *v;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UILabel *playLabel;
@property (weak, nonatomic) IBOutlet UIButton *playButton;

@property NSTimer *playerTimer;
@property NSInteger playSection;
@property NSInteger playRow;

@property NSMutableArray *sounds;
@property NSMutableArray *pinyinLabelTexts;
@property NSMutableArray *translationLabelTexts;

@end

