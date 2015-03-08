//
//  AlarmNameViewController.h
//  Map_Alarm
//
//  Created by Lidia Chou on 3/2/15.
//  Copyright (c) 2015 Lidia Chou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Engine.h"

@interface AlarmNameViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *TextFieldName;
@property (weak, nonatomic) IBOutlet UIButton *buttonNext;
@property (weak, nonatomic) IBOutlet UISlider *SliderVolume;
- (IBAction)textFieldChanged:(id)sender;

- (IBAction)ButtonNameNext:(id)sender;

@end
