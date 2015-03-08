//
//  AlarmTableViewCell.m
//  Map_Alarm
//
//  Created by Lidia Chou on 3/2/15.
//  Copyright (c) 2015 Lidia Chou. All rights reserved.
//

#import "AlarmTableViewCell.h"

@implementation AlarmTableViewCell

@class ArrayAlarmes, Alarme;

@synthesize index;

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)ChangeSwitch:(UISwitch *)sender {
    Engine *e = [Engine instancia];
    ArrayAlarmes *as = [e alarms];
    Alarme *a = [as alarmeAtIndex:index];
    
    [a setAlarmSwitch:sender.on];
    
    if (sender.on) {
        [[e locationManager] setDesiredAccuracy:kCLLocationAccuracyBest];
        [self setBackgroundColor:[UIColor whiteColor]];
        [a setAlertTocou:false];
    }
    else
    {
        [self setBackgroundColor:[UIColor lightGrayColor]];
    }
}
@end
