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

@synthesize TextFieldDistance, buttonSave, mapImage, DistanceLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    alarms = [ArrayAlarmes instancia];
    newAlarm = [ArrayAlarmes instanciaNewAlarme];
    
    [buttonSave setEnabled:NO];
    [buttonSave.layer setCornerRadius:5];
    [buttonSave.layer setBorderWidth:1];
    [buttonSave.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [buttonSave setTintColor:[UIColor blueColor]];
    
    [mapImage setDelegate:self];
    
    locationManager = [[CLLocationManager alloc] init];
    [locationManager setDelegate:self];
    [mapImage setShowsUserLocation:TRUE];
    [locationManager startUpdatingLocation];
    
}

-(void) viewDidAppear:(BOOL)animated{
    [mapImage setMapType:MKMapTypeStandard];
    [mapImage setRegion:MKCoordinateRegionMakeWithDistance([[[ArrayAlarmes instanciaNewAlarme] destino] coordinate], 250, 250) animated:NO];
    MKPointAnnotation *point1 = [[MKPointAnnotation alloc] init];
    
    point1.coordinate = [[[ArrayAlarmes instanciaNewAlarme] destino] coordinate];
    
    [mapImage addAnnotation:point1];
}

- (MKOverlayView *)mapView:(MKMapView *)map viewForOverlay:(id <MKOverlay>)overlay
{
    MKCircleView *circleView = [[MKCircleView alloc] initWithOverlay:overlay];
    circleView.strokeColor = [UIColor redColor];
    circleView.fillColor = [[UIColor redColor] colorWithAlphaComponent:0.4];
    return circleView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [TextFieldDistance resignFirstResponder];
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    CLLocationDistance dist = [[userLocation location] distanceFromLocation:[newAlarm destino]];
    [DistanceLabel setText:[NSString stringWithFormat:@"Current Distance: %im", (int)dist]];
}



-(BOOL)isStringNumeric:(NSString *)s
{
    if (s)
        return [s length] && isnumber([s characterAtIndex:0]);
    else
        return NO;
}

- (IBAction)TextFieldMeters:(id)sender {
    [mapImage removeOverlays:[mapImage overlays]];
    if (![self isStringNumeric:TextFieldDistance.text]) {
        [buttonSave setEnabled:NO];
        [buttonSave.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        return;
    }
    if([TextFieldDistance.text length] != 0){
        [buttonSave setEnabled:YES];
        [buttonSave.layer setBorderColor:[UIColor blueColor].CGColor];
        MKCircle *circle = [MKCircle circleWithCenterCoordinate:[[[ArrayAlarmes instanciaNewAlarme] destino] coordinate] radius:[TextFieldDistance.text intValue]];
        [mapImage addOverlay:circle];
        int i = 250;
        if ([TextFieldDistance.text intValue] > 250) {
            i = [TextFieldDistance.text intValue];
        }
        [mapImage setRegion:MKCoordinateRegionMakeWithDistance([[[ArrayAlarmes instanciaNewAlarme] destino] coordinate], i, i) animated:YES];
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
