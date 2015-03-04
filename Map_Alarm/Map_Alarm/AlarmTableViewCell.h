//
//  AlarmTableViewCell.h
//  Map_Alarm
//
//  Created by Lidia Chou on 3/2/15.
//  Copyright (c) 2015 Lidia Chou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArrayAlarmes.h"

@interface AlarmTableViewCell : UITableViewCell
{
    NSInteger index;
}

@property NSInteger index;

@property (weak, nonatomic) IBOutlet UILabel *alarmNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
- (IBAction)ChangeSwitch:(UISwitch *)sender;

@end
