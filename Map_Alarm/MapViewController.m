//
//  MapViewController.m
//  Map_Alarm
//
//  Created by Lidia Chou on 3/2/15.
//  Copyright (c) 2015 Lidia Chou. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

@synthesize worldMap;

- (void)viewDidLoad {
    [super viewDidLoad];
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

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"erro %@", error);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"erro" message:@"Erro em buscar a localização" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
    [alert show];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    CLLocation *location = newLocation;
    
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
@end
