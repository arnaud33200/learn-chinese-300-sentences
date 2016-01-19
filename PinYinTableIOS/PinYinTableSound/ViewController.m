//
//  ViewController.m
//  PinYinTableSound
//
//  Created by Arnaud on 2016-01-18.
//  Copyright © 2016 Arnaud. All rights reserved.
//

#import "ViewController.h"
#import "SoundTableViewCell.h"
#import "HeaderTableViewCell.h"

#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
  //  v = [[SoundCaseView alloc] init];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    
    self.sounds = [[NSMutableArray alloc] init];
    for (int i=0; i<4; ++i) {
        NSMutableArray *a = [[NSMutableArray alloc] init];
        for (int j=0; j<5; ++j) {
            NSString *path = [NSString stringWithFormat:@"%d-%d-1", i, j];
            AVAudioPlayer *player = [self setPlayerWithPath:path];
            [a addObject:player];
        }
        [self.sounds addObject:a];
    }
    [self PopulatePinyinLabelTexts];
    [self PopulateTranslationLabelTexts];
    
    self.playLabel.text = @"";
}

- (AVAudioPlayer *)setPlayerWithPath:(NSString *)path {
    NSString *pathOne = [[NSBundle mainBundle] pathForResource:path ofType:@"mp3"];
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:pathOne] error:NULL];
    [player setNumberOfLoops:0];
    return player;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)playAllSoundsOnTouchUpInside:(id)sender {
    
    if (self.playerTimer) {
        [self.playerTimer invalidate];
        self.playerTimer = nil;
        return;
    }
    
    self.playerTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(playSound:) userInfo:nil repeats:NO];
}

- (void)playSound:(NSTimer *)timer {
    
    if (self.playSection > 3 || self.playRow > 4) {
        [self.playerTimer invalidate];
        self.playerTimer = nil;
        self.playRow = 0;
        self.playSection = 0;
        self.playLabel.text = @"";
        return;
    } else {
        self.playerTimer = [NSTimer scheduledTimerWithTimeInterval:4.0 target:self selector:@selector(playSound:) userInfo:nil repeats:NO];
    }
    
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.playRow inSection:self.playSection]
                                  atScrollPosition:UITableViewScrollPositionTop animated:NO];
    
    AVAudioPlayer *player = self.sounds[self.playSection][self.playRow];
    if (player) {
        [player play];
    }
    NSInteger i = self.playRow + (self.playSection * 5);
    self.playLabel.text = self.pinyinLabelTexts[i];
    
    self.playRow++;
    if (self.playRow > 4) {
        self.playRow = 0;
        self.playSection++;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}


 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     SoundTableViewCell *cell = (SoundTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"soundCell" forIndexPath:indexPath];
//     cell.pinyinLabel.text = [NSString stringWithFormat:@"%d-%d", indexPath.section, indexPath.row];
     cell.translationLabel.text = @"";
     NSInteger i = indexPath.row + (indexPath.section * 5);
     cell.pinyinLabel.text = self.pinyinLabelTexts[i];
     cell.translationLabel.text = self.translationLabelTexts[i];
 return cell;
 }

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AVAudioPlayer *player = self.sounds[indexPath.section][indexPath.row];
    if (player) {
        self.playRow = indexPath.row;
        self.playSection = indexPath.section;
        NSInteger i = indexPath.row + (indexPath.section * 5);
        self.playLabel.text = self.pinyinLabelTexts[i];
        [self.playerTimer invalidate];
        self.playerTimer = nil;
        [player play];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    HeaderTableViewCell *cell = (HeaderTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"headerCell"];
    NSString *t = @"";
    switch (section) {
        case 0:
            t = @"First";
            break;
        case 1:
            t = @"Second";
            break;
        case 2:
            t = @"Third";
            break;
        case 3:
            t = @"Fourth";
            break;
        default:
            break;
    }
    cell.titleLabel.text = [NSString stringWithFormat:@"%@ Tone", t];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (void)setPlayerTimer:(NSTimer *)playerTimer {
    _playerTimer = playerTimer;
    if (_playerTimer == nil) {
        [self.playButton setImage:[UIImage imageNamed:@"playButton"] forState:UIControlStateNormal];
    } else {
        [self.playButton setImage:[UIImage imageNamed:@"pauseButton"] forState:UIControlStateNormal];
    }
}

- (void)PopulatePinyinLabelTexts {
    self.pinyinLabelTexts = [[NSMutableArray alloc] initWithObjects:
                             @"Jin Tian",
                             @"Zhong Guo",
                             @"Bing Shui",
                             @"Zhi Dao",
                             @"Zhen de",
                             @"Ming Tian",
                             @"Ming Nian",
                             @"Pi Jiu", 
                             @"Rong yi", 
                             @"Shen Me", 
                             @"Xi Huan", 
                             @"Qi Chuang", 
                             @"Ni Hao", 
                             @"Chao fan", 
                             @"Wo De", 
                             @"Mian Bao", 
                             @"Wen Ti", 
                             @"Zhe Li", 
                             @"Zai Jian", 
                             @"Xie Xie",
                             nil];
}

- (void)PopulateTranslationLabelTexts {
    self.translationLabelTexts = [[NSMutableArray alloc] initWithObjects:
                                  @"Today",
                                  @"China",
                                  @"Ice water",
                                  @"To know",
                                  @"Really",
                                  @"Tomorrow",
                                  @"Next Year", 
                                  @"Beer", 
                                  @"Easy", 
                                  @"What", 
                                  @"To Like", 
                                  @"To get up", 
                                  @"Hello", 
                                  @"Fried Rice", 
                                  @"Mine", 
                                  @"Bread", 
                                  @"Question", 
                                  @"Here", 
                                  @"Bye", 
                                  @"Thanks",
                                  nil];
}

@end
