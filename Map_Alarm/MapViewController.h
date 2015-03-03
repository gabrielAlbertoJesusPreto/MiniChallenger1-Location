//
//  MapViewController.h
//  Map_Alarm
//
//  Created by Lidia Chou on 3/2/15.
//  Copyright (c) 2015 Lidia Chou. All rights reserved.
//

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "Alarme.h"
#import <AudioToolbox/AudioToolbox.h>
//@class Alarme;

@interface MapViewController : UIViewController <CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
}
@property (weak, nonatomic) IBOutlet MKMapView *worldMap;
- (IBAction)LongPressMapView:(UILongPressGestureRecognizer *)sender;


@end

