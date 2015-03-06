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

@synthesize TextFieldDistance, buttonSave, mapImage;

- (void)viewDidLoad {
    [super viewDidLoad];
    alarms = [ArrayAlarmes instancia];
    newAlarm = [ArrayAlarmes instanciaNewAlarme];
    
    [buttonSave setEnabled:NO];
    [buttonSave.layer setCornerRadius:5];
    [buttonSave.layer setBorderWidth:1];
    [buttonSave.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [buttonSave setTintColor:[UIColor blueColor]];
}

-(void) viewDidAppear:(BOOL)animated{
    [mapImage setMapType:MKMapTypeStandard];
    [mapImage setRegion:MKCoordinateRegionMakeWithDistance([[[ArrayAlarmes instanciaNewAlarme] destino] coordinate], 250, 250) animated:NO];
    MKPointAnnotation *point1 = [[MKPointAnnotation alloc] init];
    
    point1.coordinate = [[[ArrayAlarmes instanciaNewAlarme] destino] coordinate];
    
    [mapImage addAnnotation:point1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [TextFieldDistance resignFirstResponder];
}

- (IBAction)TextFieldMeters:(id)sender {
    
    if([TextFieldDistance.text length] != 0){
        [buttonSave setEnabled:YES];
        [buttonSave.layer setBorderColor:[UIColor blueColor].CGColor];
    } else{
        [buttonSave setEnabled:NO];
        [buttonSave.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    }
}

- (IBAction)ButtonSave:(id)sender {
    [newAlarm setDistance:[[TextFieldDistance text] integerValue]];
    [alarms addAlarme: [newAlarm clone]];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
