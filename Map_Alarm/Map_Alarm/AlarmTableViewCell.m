//
//  AlarmTableViewCell.m
//  Map_Alarm
//
//  Created by Lidia Chou on 3/2/15.
//  Copyright (c) 2015 Lidia Chou. All rights reserved.
//

#import "AlarmTableViewCell.h"

@implementation AlarmTableViewCell

@synthesize index;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)ChangeSwitch:(UISwitch *)sender {
    ArrayAlarmes *as = [ArrayAlarmes instancia];
    Alarme *a = [as alarmeAtIndex:index];
    [a setAlarmSwitch:sender.on];
    NSLog(@"index: %li, switch: %i", (long)index, [a alarmSwitch]);
    if (sender.on) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [a setAlertTocou:false];
    }
    else
    {
        [self setBackgroundColor:[UIColor lightGrayColor]];
    }
}
@end
