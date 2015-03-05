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
    
    alarms1 = [ArrayAlarmes instancia];
    
    locationManager = [[CLLocationManager alloc] init];
    
    [locationManager setDelegate:self];
    
#ifdef __IPHONE_8_0
    if(IS_OS_8_OR_LATER) {
        [locationManager requestAlwaysAuthorization];
        
        [locationManager startUpdatingLocation];
    }
#endif
    
    NSString *path = [NSString stringWithFormat:@"%@/teste.mp3", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl = [NSURL fileURLWithPath:path];
    audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:soundUrl error:nil];

    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance] setActive: YES error: nil];
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [audioPlayer setVolume:1.0];
    
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
    
    [[NSUserDefaults standardUserDefaults] setObject:[alarms1 getarray] forKey:@"alarms"];
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
    //NSLog(@"%f, %f", loc.latitude, loc.longitude);
    bool b = false;
    for (NSInteger i = 0; i < [[alarms1 count] intValue]; i++) {
        Alarme *a = [alarms1 alarmeAtIndex: i];
        NSLog(@"index %lu,, name: %@ switch: %i", (unsigned long)i, [a nome], [a alarmSwitch]);
        CLLocationDistance dist = [newLocation distanceFromLocation:[a destino]];
        if ([a alarmSwitch])
        if (dist <= [a distance]) {
            [a setDisparado:true];
            if (![a alertTocou])
            {
                UIAlertView *message = [[UIAlertView alloc] initWithTitle:[a nome] message:@"Você chegou ao seu destino." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            message.tag = i+100;
            
                [message show];
                [a setAlertTocou:true];
            }
            MPMusicPlayerController *musicPlayer = [MPMusicPlayerController applicationMusicPlayer];
            if ([musicPlayer volume] != 0.4f) {
                [musicPlayer setVolume:0.4f];
            }

            [audioPlayer play];
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
        }
        else
        {
            [a setAlarmSwitch:true];
        }
        if ([a disparado]) {
            b = true;
        }
    }
    
    if (!b) {
        [audioPlayer stop];
    }

}


-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    if (alertView.tag >= 100) {
        if (buttonIndex == 0) {
            Alarme *a = [alarms1 alarmeAtIndex: alertView.tag-100];
            [audioPlayer stop];
            AudioServicesPlayAlertSound(0);
            [a setDisparado:false];
            [a setAlarmSwitch:false];
            NSLog(@"%li",alertView.tag-100);
        }
    }
}




@end
