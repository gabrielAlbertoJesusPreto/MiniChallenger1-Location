//
//  MapViewController.m
//  Map_Alarm
//
//  Created by Lidia Chou on 3/2/15.
//  Copyright (c) 2015 Lidia Chou. All rights reserved.
//

#import "MapViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface MapViewController ()

@end

@implementation MapViewController{
    CLPlacemark *thePlacemark;
}

@synthesize worldMap;

- (void)viewDidLoad {
    [super viewDidLoad];
    locationManager = [[CLLocationManager alloc] init];
    [locationManager setDelegate:self];
    
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
    
    NSString *path = [NSString stringWithFormat:@"%@/teste.mp3", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl = [NSURL fileURLWithPath:path];
    audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:soundUrl error:nil];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
            
        } break;
        default:{
            NSLog(@"default");
        } break;
    }
}


-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    CLLocation *location = newLocation;
    Alarme *nalarme = [Alarme instanciaNewAlarme];
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
    NSLog(@"%f, %f", tapPoint.latitude, tapPoint.longitude);
    Alarme *nalarme = [Alarme instanciaNewAlarme];
    [nalarme setDestino:location];
    
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"%@ - %@", placemarks,error);
        if(error == nil && [placemarks count] > 0)
        {
            placemark = [placemarks lastObject];
            NSLog(@"%@ %@ \n %@ %@ \n %@ \n %@", placemark.subThoroughfare, placemark.thoroughfare, placemark.postalCode, placemark.locality, placemark.administrativeArea, placemark.country);
        }
    }];

}

- (IBAction)addressSearch:(UITextField *)sender {
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:sender.text completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error){
            NSLog(@"%@", error);
        } else{
            thePlacemark = [placemarks lastObject];
            MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(thePlacemark.location.coordinate, 250, 250);
            [worldMap removeAnnotations:[worldMap annotations]];
            [self.worldMap setRegion:region animated:YES];
            [self addAnnotation:thePlacemark];
        }
        
    }];
    
}


- (void) addAnnotation:(CLPlacemark *)placemark {
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = CLLocationCoordinate2DMake(placemark.location.coordinate.latitude, placemark.location.coordinate.longitude);
    point.title = [placemark.addressDictionary objectForKey:@"Street"];
    point.subtitle = [placemark.addressDictionary objectForKey:@"City"];
    [self.worldMap addAnnotation: point];
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
    return nil;
}

@end
