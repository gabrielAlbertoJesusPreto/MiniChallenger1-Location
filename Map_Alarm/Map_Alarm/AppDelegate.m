//
//  AppDelegate.m
//  Map_Alarm
//
//  Created by Lidia Chou on 3/2/15.
//  Copyright (c) 2015 Lidia Chou. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    engine = [Engine instancia];
    
    locationManager = [[CLLocationManager alloc] init];
    [engine setLocationManager:locationManager];
    [locationManager setDelegate:self];
    
#ifdef __IPHONE_8_0
    if(IS_OS_8_OR_LATER) {
        [locationManager requestAlwaysAuthorization];
    }
#endif
    
    
    
    NSString *path = [NSString stringWithFormat:@"%@/teste.mp3", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl = [NSURL fileURLWithPath:path];
    audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:soundUrl error:nil];

    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance] setActive: YES error: nil];
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [audioPlayer setVolume:1.0];
    
    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]){
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
    }
    
    UILocalNotification *notification = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    
    if (notification) {
        [self showAlarm:notification.alertBody AndIndex: 0 AndTitle:@"Title"];
        NSLog(@"AppDelegate didFinishLaunchingWithOptions");
        application.applicationIconBadgeNumber = 0;
        
    }
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:NULL];
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    ArrayAlarmes *alarms = [engine alarms];
    [[NSUserDefaults standardUserDefaults] setObject:[alarms getarray] forKey:@"alarms"];
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
        } break;
        case kCLAuthorizationStatusAuthorizedAlways: {
            [locationManager startUpdatingLocation]; //Will update location immediately
            
        } break;
        default:{
            NSLog(@"default");
        } break;
    }
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    Engine *e = [Engine instancia];
    ArrayAlarmes *as = [e alarms];
    if ([[as count] intValue] == 0)
    {
        [locationManager setDesiredAccuracy:kCLLocationAccuracyThreeKilometers];
        return;
    }
    
    long shortestDistance = LONG_MAX;
    bool b = false;
    for (NSInteger i = 0; i < [[as count] intValue]; i++) {
        Alarme *a = [as alarmeAtIndex: i];
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        if ([[a address] isEqualToString:@"(Address not found)"])
        [geocoder reverseGeocodeLocation: [a destino] completionHandler:^(NSArray *placemarks, NSError *error) {
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
                [a setAddress:completeAddress];
                [a updateAddress];
            }
        }];
        
        CLLocationDistance dist = [newLocation distanceFromLocation:[a destino]];
        
        [a updateDist:dist];
        
        if ([a alertTocou] && dist > [a distance]){
            [a setAlarmSwitch:true];
            [a setAlertTocou:false];
        }
        if ([a alarmSwitch]){
            if (dist < shortestDistance) {
                shortestDistance = dist - [a distance];
            }
            if (dist <= [a distance]) {
                [a setDisparado:true];
                if (![a alertTocou])
                {
                    
                    [[UIApplication sharedApplication] cancelAllLocalNotifications];
                    
                    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
                    
                    NSDate *now = [NSDate date];
                    NSDate *dateToFire = [now dateByAddingTimeInterval:0];
                    
                    localNotification.fireDate = dateToFire;
                    localNotification.alertBody = @"Wake up!\n You're getting closer to your destination!";
                    localNotification.soundName =UILocalNotificationDefaultSoundName;
                    localNotification.applicationIconBadgeNumber = 1; // increment
                    
                    NSDictionary *infoDict = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:(100 + i)], @"index", [a nome], @"title", nil];
                    localNotification.userInfo = infoDict;
                    
                    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
                    
                    
                    MPMusicPlayerController *musicPlayer = [MPMusicPlayerController applicationMusicPlayer];
                    if ([musicPlayer volume] != [a volume]) {
                        [musicPlayer setVolume:[a volume]];
                    }
                    
                    [a setAlertTocou:true];
                }

                [audioPlayer play];
                AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
            }
        }
        if ([a disparado]) {
            b = true;
        }
    }
    
    if (!b) {
        [audioPlayer stop];
    }
    
    if (shortestDistance < 10) {
        [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    } else if (shortestDistance < 100) {
        [locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    } else if (shortestDistance < 3000) {
        [locationManager setDesiredAccuracy:kCLLocationAccuracyKilometer];
    } else {
        [locationManager setDesiredAccuracy:kCLLocationAccuracyThreeKilometers];
    }

}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    ArrayAlarmes *alarms = [engine alarms];
    if (alertView.tag >= 100) {
        if (buttonIndex == 0) {
            Alarme *a = [alarms alarmeAtIndex: alertView.tag-100];
            [audioPlayer stop];
            AudioServicesPlayAlertSound(0);
            [a setDisparado:false];
            [a setAlarmSwitch:false];
        }
    }
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    NSNumber *i = [notification.userInfo objectForKey:@"index"];
    [self showAlarm:notification.alertBody AndIndex: [i integerValue] AndTitle:[notification.userInfo objectForKey:@"title"]];
    application.applicationIconBadgeNumber = 0;
}

- (void)showAlarm:(NSString *)text AndIndex: (NSInteger) index AndTitle: (NSString *) t {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:t
                                                        message:text delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    alertView.tag = index;
    [alertView show];
}



@end
