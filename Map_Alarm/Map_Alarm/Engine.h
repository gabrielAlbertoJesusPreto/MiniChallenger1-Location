//
//  Engine.h
//  Map_Alarm
//
//  Created by Evandro Remon Pulz Viva on 3/6/15.
//  Copyright (c) 2015 Lidia Chou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "ArrayAlarmes.h"
#import "Alarme.h"
//#import "AlarmTableViewCell.h"

@class UITableView;

@interface Engine : NSObject
{
    UITableView* alarmsTableview;
    Alarme* creatingAlarm;
    CLLocationManager *locationManager;
    ArrayAlarmes* alarms;
    bool editing;
    NSInteger indexEditing;
}

@property (weak, nonatomic) UITableView *alarmsTableView;
@property (nonatomic) Alarme *creatingAlarm;
@property ArrayAlarmes *alarms;
@property CLLocationManager *locationManager;
@property bool editing;
@property NSInteger indexEditing;

+(Engine *) instancia;

+ (Alarme*)instanciaNewAlarme;

@end
