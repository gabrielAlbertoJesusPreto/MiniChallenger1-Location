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

@synthesize TextFieldName, buttonNext, SliderVolume;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [buttonNext setEnabled:NO];
    [buttonNext.layer setCornerRadius:5];
    [buttonNext.layer setBorderWidth:1];
    [buttonNext.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [buttonNext setTintColor:[UIColor blueColor]];
    Engine *e = [Engine instancia];
    Alarme *n = [e creatingAlarm];
    if ([e editing]) {
        [TextFieldName setText:[n nome]];
        [SliderVolume setValue:[n volume]];
        [buttonNext setEnabled:YES];
        [buttonNext.layer setBorderColor:[UIColor blueColor].CGColor];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [TextFieldName resignFirstResponder];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
