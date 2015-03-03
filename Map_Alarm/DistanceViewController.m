//
//  DistanceViewController.m
//  Map_Alarm
//
//  Created by Lidia Chou on 3/2/15.
//  Copyright (c) 2015 Lidia Chou. All rights reserved.
//

#import "DistanceViewController.h"


@interface DistanceViewController ()

@end

@implementation DistanceViewController

@synthesize TextFieldDistance;

- (void)viewDidLoad {
    [super viewDidLoad];
    alarms = [ArrayAlarmes instancia];
    newAlarm = [Alarme instanciaNewAlarme];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [TextFieldDistance resignFirstResponder];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)ButtonSave:(id)sender {
    [newAlarm setDistance:[NSNumber numberWithInteger:[[TextFieldDistance text] integerValue]]];
    [alarms addAlarme: newAlarm];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
