//
//  DistanceViewController.h
//  Map_Alarm
//
//  Created by Lidia Chou on 3/2/15.
//  Copyright (c) 2015 Lidia Chou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Alarme.h"
#import "ArrayAlarmes.h"

@interface DistanceViewController : UIViewController
{
    Alarme *newAlarm;
    ArrayAlarmes *alarms;
}
@property (weak, nonatomic) IBOutlet UITextField *TextFieldDistance;
@property (weak, nonatomic) IBOutlet UIButton *buttonSave;

- (IBAction)TextFieldMeters:(id)sender;
- (IBAction)ButtonSave:(id)sender;

@end
