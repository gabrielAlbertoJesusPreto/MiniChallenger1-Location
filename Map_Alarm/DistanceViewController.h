//
//  DistanceViewController.h
//  Map_Alarm
//
//  Created by Lidia Chou on 3/2/15.
//  Copyright (c) 2015 Lidia Chou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "Alarme.h"
#import "ArrayAlarmes.h"
#import <AVFoundation/AVFoundation.h>

@interface DistanceViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate>
{
    CLLocationManager *locationManager;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
        
    Alarme *newAlarm;
    ArrayAlarmes *alarms;
}
@property (weak, nonatomic) IBOutlet UITextField *TextFieldDistance;
@property (weak, nonatomic) IBOutlet UIButton *buttonSave;
@property (weak, nonatomic) IBOutlet MKMapView *mapImage;

- (IBAction)TextFieldMeters:(id)sender;
- (IBAction)ButtonSave:(id)sender;

@end
