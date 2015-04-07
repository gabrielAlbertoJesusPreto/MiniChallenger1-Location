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

@synthesize TextFieldDistance, buttonSave, mapImage, numericDistLabel, distLabel, howFarLabel, metersLabel, currDistLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [distLabel setText:[NSString stringWithFormat:NSLocalizedString(@"Distance", nil)]];
    [howFarLabel setText:[NSString stringWithFormat:NSLocalizedString(@"How far from there to sound the alarm?", nil)]];
    [metersLabel setText:[NSString stringWithFormat:NSLocalizedString(@"(Meters)", nil)]];
    [buttonSave setTitle:[NSString stringWithFormat:NSLocalizedString(@"Save", nil)] forState:UIControlStateNormal];
    [currDistLabel setText:[NSString stringWithFormat:NSLocalizedString(@"Current distance:", nil)]];
    
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
    Engine *e = [Engine instancia];
    Alarme *n = [e creatingAlarm];
    [mapImage setMapType:MKMapTypeStandard];
    [mapImage setRegion:MKCoordinateRegionMakeWithDistance([[n destino] coordinate], 250, 250) animated:NO];
    MKPointAnnotation *point1 = [[MKPointAnnotation alloc] init];
    
    point1.coordinate = [[n destino] coordinate];
    
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
    Engine *e = [Engine instancia];
    Alarme *n = [e creatingAlarm];
    CLLocationDistance dist = [[userLocation location] distanceFromLocation:[n destino]];
    [numericDistLabel setText:[NSString stringWithFormat:@"%im", (int)dist]];
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
    Engine *e = [Engine instancia];
    Alarme *n = [e creatingAlarm];
    if (![self isStringNumeric:TextFieldDistance.text]) {
        [buttonSave setEnabled:NO];
        [buttonSave.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        return;
    }
    if([TextFieldDistance.text length] != 0){
        [buttonSave setEnabled:YES];
        [buttonSave.layer setBorderColor:[UIColor blueColor].CGColor];
        int i = 250;
        if ([TextFieldDistance.text intValue] > 250) {
            i = [TextFieldDistance.text intValue];
        }
        if ([TextFieldDistance.text intValue] < 2800000)
        {
            MKCircle *circle = [MKCircle circleWithCenterCoordinate:[[n destino] coordinate] radius:[TextFieldDistance.text intValue]];
            [mapImage addOverlay:circle];
            [mapImage setRegion:MKCoordinateRegionMakeWithDistance([[n destino] coordinate], i, i) animated:YES];
        }
    } else{
        [buttonSave setEnabled:NO];
        [buttonSave.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    }
}

- (IBAction)ButtonSave:(id)sender {
    Engine *e = [Engine instancia];
    Alarme *n = [e creatingAlarm];
    ArrayAlarmes *as = [e alarms];
    [n setDistance:[[TextFieldDistance text] integerValue]];
    [as addAlarme: [n clone]];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
