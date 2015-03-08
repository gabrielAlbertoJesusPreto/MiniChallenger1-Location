//
//  MapViewController.m
//  Map_Alarm
//
//  Created by Lidia Chou on 3/2/15.
//  Copyright (c) 2015 Lidia Chou. All rights reserved.
//

#import "MapViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "DistanceViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController{
    CLPlacemark *thePlacemark;
}

@synthesize worldMap, searchTextField, buttonNext, indicator;

- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    locationManager = [[CLLocationManager alloc] init];
    [locationManager setDelegate:self];
    placemark = [[CLPlacemark alloc] initWithPlacemark:thePlacemark];
    [buttonNext setEnabled:NO];
    [buttonNext.layer setCornerRadius:5];
    [buttonNext.layer setBorderWidth:1];
    [buttonNext.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [buttonNext setTintColor:[UIColor blueColor]];
    
    self.worldMap.delegate = self;
    
    [locationManager startUpdatingLocation];
    
    
    worldMap.showsUserLocation = YES;
    [worldMap setMapType:MKMapTypeStandard];
    
    [worldMap setZoomEnabled:YES];
    [worldMap setScrollEnabled:YES];
    
    Engine *e = [Engine instancia];
    Alarme *n = [e creatingAlarm];
    
    if ([e editing]) {
        MKPointAnnotation *p = [[MKPointAnnotation alloc] init];
        [p setCoordinate:[n destino].coordinate];
        [worldMap removeAnnotations:[worldMap annotations]];
        [worldMap addAnnotation:p];
        [buttonNext setEnabled:YES];
        [buttonNext.layer setBorderColor:[UIColor blueColor].CGColor];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [searchTextField resignFirstResponder];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager*)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    
    switch (status) {
        case kCLAuthorizationStatusNotDetermined: {
        } break;
        case kCLAuthorizationStatusDenied: {
        } break;
        case kCLAuthorizationStatusAuthorizedWhenInUse: {
            CLLocationCoordinate2D loc = [[manager location] coordinate];
            
            MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, 250, 250);
            
            [worldMap setRegion:region animated:YES ];
        } break;
        case kCLAuthorizationStatusAuthorizedAlways: {
            [locationManager startUpdatingLocation];
            CLLocationCoordinate2D loc = [[manager location] coordinate];
            
            MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, 250, 250);
            
            [worldMap setRegion:region animated:YES ];

            
        } break;
        default:{
        } break;
    }
}


-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{


}

- (IBAction)LongPressMapView:(UILongPressGestureRecognizer *)sender {
    CGPoint point = [sender locationInView: self.worldMap];
    
    CLLocationCoordinate2D tapPoint = [self.worldMap convertPoint:point toCoordinateFromView:self.worldMap];
    
    MKPointAnnotation *point1 = [[MKPointAnnotation alloc] init];
    
    point1.coordinate = tapPoint;
    
    [worldMap removeAnnotations:[worldMap annotations]];
    [self.worldMap addAnnotation:point1];
    CLLocation *location = [[CLLocation alloc] initWithLatitude:tapPoint.latitude longitude:tapPoint.longitude];
    Engine *e = [Engine instancia];
    Alarme *n = [e creatingAlarm];
    [n setDestino:location];
    
    [buttonNext setEnabled:YES];
    [buttonNext.layer setBorderColor:[UIColor blueColor].CGColor];



}

- (IBAction)TouchUpButtonNext:(id)sender {
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    Engine *e = [Engine instancia];
    Alarme *n = [e creatingAlarm];
    [geocoder reverseGeocodeLocation: [n destino] completionHandler:^(NSArray *placemarks, NSError *error) {
        if(error == nil && [placemarks count] > 0)
        {
            thePlacemark = [placemarks lastObject];
            NSString *subThoroughfare = thePlacemark.subThoroughfare;
            NSString *thoroughfare = thePlacemark.thoroughfare;
            NSString *locality= thePlacemark.locality;
            if (subThoroughfare == nil)
                subThoroughfare = @"";
            if (thoroughfare == nil)
                thoroughfare = @"";
            if (locality == nil)
                locality = @"";
            
            NSString *completeAddress = [NSString stringWithFormat:@"%@ %@ - %@", subThoroughfare, thoroughfare, locality];
            [n setAddress:completeAddress];
        }
        else
        {
            [n setAddress:@"(Address not found)"];
            NSLog(@"%@ - %@", placemarks,error);
        }
    }];
}

-(void)viewDidAppear:(BOOL)animated
{
    [indicator setHidden:true];
}

- (IBAction)addressSearch:(UITextField *)sender {
    
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    indicator.hidden = NO;
    [indicator startAnimating];
    
    [geocoder geocodeAddressString:sender.text completionHandler:^(NSArray *placemarks, NSError *error) {
    
        
        if (error){
            UIAlertView *alerterror = [[UIAlertView alloc] initWithTitle:@"ERROR" message: error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alerterror show];
            [buttonNext setEnabled:NO];
            [buttonNext.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        } else{
            
            thePlacemark = [placemarks lastObject];
            MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(thePlacemark.location.coordinate, 250, 250);
            Engine *e = [Engine instancia];
            Alarme *n = [e creatingAlarm];
            [n setDestino:thePlacemark.location];
            [worldMap removeAnnotations:[worldMap annotations]];
            [self.worldMap setRegion:region animated:YES];
            [self addAnnotation:thePlacemark];
            [buttonNext setEnabled:YES];
            [buttonNext.layer setBorderColor:[UIColor blueColor].CGColor];
            
            //set address Alarme
            NSString *completeAddress = [NSString stringWithFormat:@"%@ %@ \n %@ %@ \n %@ \n %@", thePlacemark.subThoroughfare, thePlacemark.thoroughfare, thePlacemark.postalCode, thePlacemark.locality, thePlacemark.administrativeArea, thePlacemark.country];
            [n setAddress:completeAddress];
            
        
        }
        
        indicator.hidden = YES;
        [indicator stopAnimating];
    }];
    
    
}

- (void) addAnnotation:(CLPlacemark *)placemark {
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = CLLocationCoordinate2DMake(placemark.location.coordinate.latitude, placemark.location.coordinate.longitude);
    point.title = [placemark.addressDictionary objectForKey:@"Street"];
    point.subtitle = [placemark.addressDictionary objectForKey:@"City"];
    [self.worldMap addAnnotation: point];
    [buttonNext setEnabled:YES];
    [buttonNext.layer setBorderColor:[UIColor blueColor].CGColor];

}


-(MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    if([annotation isKindOfClass:[MKPointAnnotation class]]){
        MKPinAnnotationView *pinView = (MKPinAnnotationView*)[self.worldMap dequeueReusableAnnotationViewWithIdentifier:@"CustomPinAnnotationView"];
        if (!pinView){
            pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CustomPinAnnotationView"];
            pinView.canShowCallout = YES;
        } else {
            pinView.annotation = annotation;
        }
        return pinView;
        
    }
    [buttonNext setEnabled:YES];
    [buttonNext.layer setBorderColor:[UIColor blueColor].CGColor];

    return nil;
}

@end
