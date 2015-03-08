//
//  AppDelegate.h
//  Map_Alarm
//
//  Created by Lidia Chou on 3/2/15.
//  Copyright (c) 2015 Lidia Chou. All rights reserved.
//

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "Engine.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate, UIAlertViewDelegate>
{
    CLLocationManager *locationManager;
    AVAudioPlayer *audioPlayer;
    AVPlayer *audioPlayer1;
    UIBackgroundTaskIdentifier *backgroundTask;
    CLPlacemark *thePlacemark;
    Engine *engine;
}

@property (strong, nonatomic) UIWindow *window;


@end

