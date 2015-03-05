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
    newAlarm = [Alarme instanciaNewAlarme];
    // Do any additional setup after loading the view.
    [buttonSave setEnabled:NO];
    
    
    
    
}

-(void) viewDidAppear:(BOOL)animated{
    [mapImage setMapType:MKMapTypeStandard];
    [mapImage setRegion:MKCoordinateRegionMakeWithDistance([[[Alarme instanciaNewAlarme] destino] coordinate], 250, 250) animated:NO];
    MKPointAnnotation *point1 = [[MKPointAnnotation alloc] init];
    
    point1.coordinate = [[[Alarme instanciaNewAlarme] destino] coordinate];
    
    [mapImage addAnnotation:point1];
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

- (IBAction)TextFieldMeters:(id)sender {
    
    if([TextFieldDistance.text length] != 0){
        
        [buttonSave setEnabled:YES];
        
    } else{
        [buttonSave setEnabled:NO];
    }
}

- (IBAction)ButtonSave:(id)sender {
    [newAlarm setDistance:[NSNumber numberWithInteger:[[TextFieldDistance text] integerValue]]];
    [newAlarm setAddress:placemark.locality];
    [alarms addAlarme: newAlarm];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

@end
