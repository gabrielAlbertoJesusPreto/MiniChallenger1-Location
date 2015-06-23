//
//  AlarmTableViewCell.h
//  Map_Alarm
//
//  Created by Lidia Chou on 3/2/15.
//  Copyright (c) 2015 Lidia Chou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Engine.h"

@interface AlarmTableViewCell : UITableViewCell
{
    NSInteger index;
}

@property NSInteger index;

@property (weak, nonatomic) IBOutlet UILabel *alarmNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UISwitch *statusSwitch;
- (IBAction)ChangeSwitch:(UISwitch *)sender;

@end
