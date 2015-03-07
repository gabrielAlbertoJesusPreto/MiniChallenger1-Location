//
//  AppDelegate.h
//  Map_Alarm
//
//  Created by Lidia Chou on 3/2/15.
//  Copyright (c) 2015 Lidia Chou. All rights reserved.
//

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

#import <UIKit/UIKit.h>
#import "ArrayAlarmes.h"
#import "alarme.h"
#import <CoreLocation/CoreLocation.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "Engine.h"
#import "AlarmTableViewCell.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate, UIAlertViewDelegate>
{
    ArrayAlarmes *alarms1;
    CLLocationManager *locationManager;
    AVAudioPlayer *audioPlayer;
    AVPlayer *audioPlayer1;
    UIBackgroundTaskIdentifier *backgroundTask;
    Engine *engine;
}

@property (strong, nonatomic) UIWindow *window;


@end

