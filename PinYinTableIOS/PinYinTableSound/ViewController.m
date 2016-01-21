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
            AVAudioSectionRowPlayer *player = [self setPlayerWithPath:path];
            player.section = i;
            player.row = j;
            [a addObject:player];
        }
        [self.sounds addObject:a];
    }
    
    self.playList = [[NSMutableArray alloc] init];
    
    [self PopulatePinyinLabelTexts];
    [self PopulateTranslationLabelTexts];
    
    self.playLabel.text = @"";
}

- (AVAudioSectionRowPlayer *)setPlayerWithPath:(NSString *)path {
    NSString *pathOne = [[NSBundle mainBundle] pathForResource:path ofType:@"mp3"];
    AVAudioSectionRowPlayer *player = [[AVAudioSectionRowPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:pathOne] error:NULL];
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
    if (self.playList.count == 0) {
        [self buildPlaylistFromSection:0 ToRow:0];
    }
    
    self.playerTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(playSound:) userInfo:nil repeats:NO];
}

- (void)playSound:(NSTimer *)timer {
    
    if (self.playList.count == 0) {
        [self.playerTimer invalidate];
        self.playerTimer = nil;
        self.playLabel.text = @"";
        if (self.loopButton.isPressed) {
            [self playAllSoundsOnTouchUpInside:nil];
        }
        return;
    } else {
        self.playerTimer = [NSTimer scheduledTimerWithTimeInterval:4.0 target:self selector:@selector(playSound:) userInfo:nil repeats:NO];
    }
    
    AVAudioSectionRowPlayer *player = [self.playList objectAtIndex:0];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:player.row inSection:player.section]
                                  atScrollPosition:UITableViewScrollPositionTop animated:NO];
    
    if (player) {
        [player play];
        self.lastPlayerPlayed = player;
    }
    NSInteger i = player.row + (player.section * 5);
    self.playLabel.text = self.pinyinLabelTexts[i];
    [self.playList removeObjectAtIndex:0];
    
}

- (void)buildPlaylistFromSection:(NSInteger)section ToRow:(NSInteger)row {
    self.playList = [[NSMutableArray alloc] init];
    
    for (NSInteger s=section; s<4; ++s) {
        for (NSInteger r=row; r<5; ++r) {
            [self.playList addObject:self.sounds[s][r]];
        }
    }
    
    if ([self.randomButton isPressed]) {
        NSMutableArray *copyPlaylist = [self.playList mutableCopy];
        self.playList = [[NSMutableArray alloc] init];
        while (copyPlaylist.count > 0) {
            NSInteger randomI = [self getRandomNumberBetween:0 to:copyPlaylist.count-1];
            AVAudioSectionRowPlayer *player = copyPlaylist[randomI];
            [self.playList addObject:player];
            [copyPlaylist removeObjectAtIndex:randomI];
        }
    }
}

-(int)getRandomNumberBetween:(int)from to:(int)to {
    return (int)from + arc4random() % (to-from+1);
}

- (IBAction)randomPressed:(ToggleUIButton *)sender {
    [sender togglePressed];
    
// MAKE THE CURRENT PLAYLIST RANDOM
    if (self.lastPlayerPlayed) {
        NSInteger nextRow = self.lastPlayerPlayed.row + 1;
        NSInteger nextSection = self.lastPlayerPlayed.section;
        if (nextRow > 4) {
            nextRow = 0;
            nextSection++;
            if (nextSection > 3) {
                return;
            }
        }
        [self buildPlaylistFromSection:nextSection ToRow:nextRow];
    }
}

- (IBAction)loopPressed:(ToggleUIButton *)sender {
    [sender togglePressed];
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
    AVAudioSectionRowPlayer *player = self.sounds[indexPath.section][indexPath.row];
    if (player) {
        
        // remake the all playlist
        [self buildPlaylistFromSection:indexPath.section ToRow:indexPath.row];

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
                             @"Jīn Tiān",
                             @"Zhōng Guó",
                             @"Bīng Shuǐ",
                             @"Zhī Dào",
                             @"Zhēn De",
                             @"Míng tiān",
                             @"Míng Nián",
                             @"Pí Jiǔ",
                             @"Róng Yì",
                             @"Shén Me",
                             @"Xǐ Huān",
                             @"Qǐ Chuáng",
                             @"Nǐ Hǎo",
                             @"Chǎo Fàn",
                             @"Wǒ De",
                             @"Miàn Bāo",
                             @"Wèn Tí",
                             @"Zhè Lǐ",
                             @"Zài Jiàn",
                             @"Xiè Xie",
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
