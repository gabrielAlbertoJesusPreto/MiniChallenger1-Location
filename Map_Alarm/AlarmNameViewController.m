//
//  AlarmNameViewController.m
//  Map_Alarm
//
//  Created by Lidia Chou on 3/2/15.
//  Copyright (c) 2015 Lidia Chou. All rights reserved.
//

#import "AlarmNameViewController.h"
#import "ArrayAlarmes.h"

@interface AlarmNameViewController ()

@end

@implementation AlarmNameViewController

@synthesize TextFieldName, buttonNext, SliderVolume, nameAlarmLabel, volumeLabel, nextOutlet;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationItem setTitle:[NSString stringWithFormat:NSLocalizedString(@"Name", nil)]];
    
    [nameAlarmLabel setText:[NSString stringWithFormat:NSLocalizedString(@"Name your alarm:", nil)]];
    [volumeLabel setText:[NSString stringWithFormat:NSLocalizedString(@"Volume:", nil)]];
    [nextOutlet setTitle:[NSString stringWithFormat:NSLocalizedString(@"Next", nil)] forState:UIControlStateNormal];
    
    [buttonNext setEnabled:NO];
    [buttonNext.layer setCornerRadius:5];
    [buttonNext.layer setBorderWidth:1];
    [buttonNext.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [buttonNext setTintColor:[UIColor blueColor]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [TextFieldName resignFirstResponder];
}


- (IBAction)textFieldChanged:(id)sender {
    if([TextFieldName.text length] != 0){
        
        [buttonNext setEnabled:YES];
        [buttonNext.layer setBorderColor:[UIColor blueColor].CGColor];
        
    } else{
        [buttonNext setEnabled:NO];
        [buttonNext.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    }
}

- (IBAction)ButtonNameNext:(id)sender {
    Engine *e = [Engine instancia];
    Alarme *n = [e creatingAlarm];
    [n setNome:[TextFieldName text]];
    [n setVolume:[SliderVolume value]];
}


@end
