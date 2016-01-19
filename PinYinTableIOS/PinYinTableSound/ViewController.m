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
     switch (indexPath.section) {
         case 0:
             switch (indexPath.row) {
                 case 0:
                     cell.pinyinLabel.text = @"Jin Tian";
                     cell.translationLabel.text = @"Today";
                     break;
                 case 1:
                     cell.pinyinLabel.text = @"Zhong Guo";
                     cell.translationLabel.text = @"China";
                     break;
                 case 2:
                     cell.pinyinLabel.text = @"Bing Shui";
                     cell.translationLabel.text = @"Ice water";
                     break;
                 case 3:
                     cell.pinyinLabel.text = @"Zhi Dao";
                     cell.translationLabel.text = @"To know";
                     break;
                 case 4:
                     cell.pinyinLabel.text = @"Zhen Me";
                     cell.translationLabel.text = @"Really";
                     break;
             }
             break;
         case 1:
             switch (indexPath.row) {
                 case 0:
                     cell.pinyinLabel.text = @"Ming Tian";
                     cell.translationLabel.text = @"Tomorrow";
                     break;
                 case 1:
                     cell.pinyinLabel.text = @"Ming Nia";
                     cell.translationLabel.text = @"Next Year";
                     break;
                 case 2:
                     cell.pinyinLabel.text = @"Pi Jiu";
                     cell.translationLabel.text = @"Beer";
                     break;
                 case 3:
                     cell.pinyinLabel.text = @"Rong yi";
                     cell.translationLabel.text = @"Easy";
                     break;
                 case 4:
                     cell.pinyinLabel.text = @"Shen Me";
                     cell.translationLabel.text = @"What";
                     break;
             }
             break;
         case 2:
             switch (indexPath.row) {
                 case 0:
                     cell.pinyinLabel.text = @"Xi Huan";
                     cell.translationLabel.text = @"To Like";
                     break;
                 case 1:
                     cell.pinyinLabel.text = @"Qi Chuang";
                     cell.translationLabel.text = @"To get up";
                     break;
                 case 2:
                     cell.pinyinLabel.text = @"Ni Hao";
                     cell.translationLabel.text = @"Hello";
                     break;
                 case 3:
                     cell.pinyinLabel.text = @"Chao fan";
                     cell.translationLabel.text = @"Fried Rice";
                     break;
                 case 4:
                     cell.pinyinLabel.text = @"Wo De";
                     cell.translationLabel.text = @"Mine";
                     break;
             }
             break;
         case 3:
             switch (indexPath.row) {
                 case 0:
                     cell.pinyinLabel.text = @"Mian Bao";
                     cell.translationLabel.text = @"Bread";
                     break;
                 case 1:
                     cell.pinyinLabel.text = @"Wen Ti";
                     cell.translationLabel.text = @"Question";
                     break;
                 case 2:
                     cell.pinyinLabel.text = @"Zhe Li";
                     cell.translationLabel.text = @"Here";
                     break;
                 case 3:
                     cell.pinyinLabel.text = @"Zai Jian";
                     cell.translationLabel.text = @"Bye";
                     break;
                 case 4:
                     cell.pinyinLabel.text = @"Xie Xiel";
                     cell.translationLabel.text = @"Thanks";
                     break;
             }
             break;
     }
//     [cell setTonesWithFirst:indexPath.section WithSecond:indexPath.row];
 // Configure the cell...
//     UITableViewCell *cell = [[UITableViewCell alloc] init];
 return cell;
 }

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AVAudioPlayer *player = self.sounds[indexPath.section][indexPath.row];
    if (player) {
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

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
