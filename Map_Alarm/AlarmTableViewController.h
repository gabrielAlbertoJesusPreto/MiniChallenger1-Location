//
//  AlarmTableViewController.h
//  Map_Alarm
//
//  Created by Lidia Chou on 3/2/15.
//  Copyright (c) 2015 Lidia Chou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlarmTableViewCell.h"
#import "ArrayAlarmes.h"
@class Alarme;

@interface AlarmTableViewController : UITableViewController
{
    ArrayAlarmes *alarms;
}

@end
