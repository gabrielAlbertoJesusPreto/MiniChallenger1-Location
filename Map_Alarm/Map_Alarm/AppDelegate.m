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
    
    alarms = [ArrayAlarmes instancia];
    

    
    
    locationManager = [[CLLocationManager alloc] init];
    
    [locationManager setDelegate:self];
    
#ifdef __IPHONE_8_0
    if(IS_OS_8_OR_LATER) {
        // Use one or the other, not both. Depending on what you put in info.plist
        [locationManager requestWhenInUseAuthorization];
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
    
    [[NSUserDefaults standardUserDefaults] setObject:[alarms getarray]
                                              forKey:@"alarms"];
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
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
    CLLocationCoordinate2D loc = [[locationManager location] coordinate];
    NSLog(@"%f, %f", loc.latitude, loc.longitude);
    bool b = false;
    for (int i = 0; i < [[alarms count] intValue]; i++) {
        Alarme *a = [alarms alarmeAtIndex:(NSUInteger)i];
        
        CLLocationDistance dist = [[locationManager location] distanceFromLocation:[a destino]];
        NSLog(@"%f", dist);
        if ([a alarmSwitch])
        if (dist <= [[a distance] intValue]) {
            NSLog(@"você esta chegando: %@", [a nome]);
            
            MPMusicPlayerController *musicPlayer = [MPMusicPlayerController applicationMusicPlayer];
            if ([musicPlayer volume] != 1.0f) {
                [musicPlayer setVolume:1.0f];
            }
            
            //[audioPlayer play];
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
            b = true;
        }
    }
    if (!b) {
        [audioPlayer stop];
    }

}

@end
