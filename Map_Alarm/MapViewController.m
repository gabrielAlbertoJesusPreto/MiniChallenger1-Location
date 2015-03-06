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
    
#ifdef __IPHONE_8_0
    if(IS_OS_8_OR_LATER) {
        // Use one or the other, not both. Depending on what you put in info.plist
        [locationManager requestWhenInUseAuthorization];
        [locationManager requestAlwaysAuthorization];
        
        [locationManager startUpdatingLocation];
        
        
        worldMap.showsUserLocation = YES;
        [worldMap setMapType:MKMapTypeStandard];
        [worldMap setZoomEnabled:YES];
        [worldMap setScrollEnabled:YES];
        
    }
#endif
    
    // Do any additional setup after loading the view.
    
    NSLog(@"lOCALITY%@", placemark.locality);
    
//    [self performSelector:@selector(addressSearch)withObject:nil afterDelay:5.0];
    
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
            NSLog(@"User still thinking..");
        } break;
        case kCLAuthorizationStatusDenied: {
            NSLog(@"User hates you");
        } break;
        case kCLAuthorizationStatusAuthorizedWhenInUse: {
            NSLog(@"kCLAuthorizationStatusAuthorizedWhenInUse");
            //Encontrar as coordenadas de localização atual
            CLLocationCoordinate2D loc = [[manager location] coordinate];
            
            //Determinar região com as coordenadas de localização atual e os limites N/S e L/O no zoom em metros
            MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, 250, 250);
            
            //Mudar a região atual para visualização de forma animada
            [worldMap setRegion:region animated:YES ];
        } break;
        case kCLAuthorizationStatusAuthorizedAlways: {
            NSLog(@"kCLAuthorizationStatusAuthorizedAlways");
            [locationManager startUpdatingLocation]; //Will update location immediately
            //Encontrar as coordenadas de localização atual
            CLLocationCoordinate2D loc = [[manager location] coordinate];
            
            //Determinar região com as coordenadas de localização atual e os limites N/S e L/O no zoom em metros
            MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, 250, 250);
            
            //Mudar a região atual para visualização de forma animada
            [worldMap setRegion:region animated:YES ];

            
        } break;
        default:{
            NSLog(@"default");
        } break;
    }
}


-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    CLLocation *location = newLocation;
    Alarme *nalarme = [ArrayAlarmes instanciaNewAlarme];
    if ([nalarme destino] != nil) {
        CLLocationDistance dist = [newLocation distanceFromLocation:[nalarme destino]];
        if (dist < 500) {
//            [audioPlayer play];
//            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
            
        } else
        {
//            [audioPlayer stop];
        }
//        NSLog(@"distancia: %f",dist);

    }
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"%@ - %@", placemarks,error);
        if(error == nil && [placemarks count] > 0)
        {
            placemark = [placemarks lastObject];
            NSLog(@"%@ %@ \n %@ %@ \n %@ \n %@", placemark.subThoroughfare, placemark.thoroughfare, placemark.postalCode, placemark.locality, placemark.administrativeArea, placemark.country);
            [buttonNext setEnabled:YES];
            [buttonNext.layer setBorderColor:[UIColor blueColor].CGColor];

        }
    }];
}

- (IBAction)LongPressMapView:(UILongPressGestureRecognizer *)sender {
    CGPoint point = [sender locationInView: self.worldMap];
    
    CLLocationCoordinate2D tapPoint = [self.worldMap convertPoint:point toCoordinateFromView:self.worldMap];
    
    MKPointAnnotation *point1 = [[MKPointAnnotation alloc] init];
    
    point1.coordinate = tapPoint;
    
    [worldMap removeAnnotations:[worldMap annotations]];
    [self.worldMap addAnnotation:point1];
    CLLocation *location = [[CLLocation alloc] initWithLatitude:tapPoint.latitude longitude:tapPoint.longitude];
//    NSLog(@"%f, %f", tapPoint.latitude, tapPoint.longitude);
    Alarme *nalarme = [ArrayAlarmes instanciaNewAlarme];
    [nalarme setDestino:location];
    
    [buttonNext setEnabled:YES];
    [buttonNext.layer setBorderColor:[UIColor blueColor].CGColor];



}

- (IBAction)TouchUpButtonNext:(id)sender {
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    Alarme *nalarme = [ArrayAlarmes instanciaNewAlarme];
    [geocoder reverseGeocodeLocation: [nalarme destino] completionHandler:^(NSArray *placemarks, NSError *error) {
        if(error == nil && [placemarks count] > 0)
        {
            thePlacemark = [placemarks lastObject];
            NSString *completeAddress = [NSString stringWithFormat:@"%@ %@ - %@ - %@ - %@", thePlacemark.subThoroughfare, thePlacemark.thoroughfare, thePlacemark.locality, thePlacemark.administrativeArea, thePlacemark.country];
            [nalarme setAddress:completeAddress];
        }
        else
        {
            NSLog(@"%@ - %@", placemarks,error);
        }
    }];
}

- (IBAction)addressSearch:(UITextField *)sender {
    
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:sender.text completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error){
            NSLog(@"%@", error);
            [buttonNext setEnabled:NO];
            [buttonNext.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        } else{
            thePlacemark = [placemarks lastObject];
            MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(thePlacemark.location.coordinate, 250, 250);
            Alarme *nalarme = [ArrayAlarmes instanciaNewAlarme];
            [nalarme setDestino:thePlacemark.location];
            [worldMap removeAnnotations:[worldMap annotations]];
            [self.worldMap setRegion:region animated:YES];
            [self addAnnotation:thePlacemark];
            [buttonNext setEnabled:YES];
            [buttonNext.layer setBorderColor:[UIColor blueColor].CGColor];
            
            //set address Alarme
            NSString *completeAddress = [NSString stringWithFormat:@"%@ %@ \n %@ %@ \n %@ \n %@", thePlacemark.subThoroughfare, thePlacemark.thoroughfare, thePlacemark.postalCode, thePlacemark.locality, thePlacemark.administrativeArea, thePlacemark.country];
            [nalarme setAddress:completeAddress];
            
        
        }
        
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
