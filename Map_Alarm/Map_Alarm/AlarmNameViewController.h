//
//  AlarmNameViewController.h
//  Map_Alarm
//
//  Created by Lidia Chou on 3/2/15.
//  Copyright (c) 2015 Lidia Chou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlarmNameViewController : UICollectionViewController
@property (weak, nonatomic) IBOutlet UITextField *nameAlarmTextField;
- (IBAction)nextButton:(id)sender;

@end
