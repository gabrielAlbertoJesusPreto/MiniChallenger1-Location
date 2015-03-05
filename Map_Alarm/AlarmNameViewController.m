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

@synthesize TextFieldName, buttonNext;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [buttonNext setEnabled:NO];
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
        
    } else{
        [buttonNext setEnabled:NO];
    }
}

- (IBAction)ButtonNameNext:(id)sender {
    
    Alarme *nalarme = [ArrayAlarmes instanciaNewAlarme];
    [nalarme setNome:[TextFieldName text]];
    
}


@end
