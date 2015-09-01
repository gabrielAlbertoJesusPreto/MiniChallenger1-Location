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

static const NSString *WORLD_WEATHER_ONLINE_API_KEY = @"123oloco";


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
//    engine = [Engine instancia];
//
//    locationManager = [[CLLocationManager alloc] init];
//    [engine setLocationManager:locationManager];
//    [locationManager setDelegate:self];
//    
//#ifdef __IPHONE_8_0
//    if(IS_OS_8_OR_LATER) {
//        [locationManager requestAlwaysAuthorization];
//    }
//#endif
//    
//    
//    
//    NSString *path = [NSString stringWithFormat:@"%@/teste.mp3", [[NSBundle mainBundle] resourcePath]];
//    NSURL *soundUrl = [NSURL fileURLWithPath:path];
//    audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:soundUrl error:nil];
//
////    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategory error:nil];
//    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback withOptions:AVAudioSessionCategoryOptionDuckOthers error:nil];
//    [AVAudioSession sharedInstance];
//    [[AVAudioSession sharedInstance] setActive: YES error: nil];
////    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
//    
//    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]){
//        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
//    }
//    
//    UILocalNotification *notification = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
//    
//    if (notification) {
//        [self showAlarm:notification.alertBody AndIndex: 0 AndTitle:@"Title"];
//        NSLog(@"AppDelegate didFinishLaunchingWithOptions");
//        application.applicationIconBadgeNumber = 0;
//        
//    }
//    
//    [self.window makeKeyAndVisible];
//    
    
    
    
    
    NSLog(@"didFinishLaunchingWithOptions");
    
    self.shareModel = [LocationShareModel sharedModel];
    self.shareModel.afterResume = NO;
    
    [self addApplicationStatusToPList:@"didFinishLaunchingWithOptions"];
    
    UIAlertView * alert;
    
    //We have to make sure that the Background App Refresh is enable for the Location updates to work in the background.
    if([[UIApplication sharedApplication] backgroundRefreshStatus] == UIBackgroundRefreshStatusDenied){
        
        alert = [[UIAlertView alloc]initWithTitle:@""
                                          message:@"The app doesn't work without the Background App Refresh enabled. To turn it on, go to Settings > General > Background App Refresh"
                                         delegate:nil
                                cancelButtonTitle:@"Ok"
                                otherButtonTitles:nil, nil];
        [alert show];
        
    }else if([[UIApplication sharedApplication] backgroundRefreshStatus] == UIBackgroundRefreshStatusRestricted){
        
        alert = [[UIAlertView alloc]initWithTitle:@""
                                          message:@"The functions of this app are limited because the Background App Refresh is disable."
                                         delegate:nil
                                cancelButtonTitle:@"Ok"
                                otherButtonTitles:nil, nil];
        [alert show];
        
    } else{
        
        // When there is a significant changes of the location,
        // The key UIApplicationLaunchOptionsLocationKey will be returned from didFinishLaunchingWithOptions
        // When the app is receiving the key, it must reinitiate the locationManager and get
        // the latest location updates
        
        // This UIApplicationLaunchOptionsLocationKey key enables the location update even when
        // the app has been killed/terminated (Not in th background) by iOS or the user.
        
        if ([launchOptions objectForKey:UIApplicationLaunchOptionsLocationKey]) {
            NSLog(@"UIApplicationLaunchOptionsLocationKey");
            
            // This "afterResume" flag is just to show that he receiving location updates
            // are actually from the key "UIApplicationLaunchOptionsLocationKey"
            self.shareModel.afterResume = YES;
            
            self.shareModel.anotherLocationManager = [[CLLocationManager alloc]init];
            self.shareModel.anotherLocationManager.delegate = self;
            self.shareModel.anotherLocationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
            self.shareModel.anotherLocationManager.activityType = CLActivityTypeOtherNavigation;
            
            if(IS_OS_8_OR_LATER) {
                [self.shareModel.anotherLocationManager requestAlwaysAuthorization];
            }
            
            [self.shareModel.anotherLocationManager startMonitoringSignificantLocationChanges];
            
            [self addResumeLocationToPList];
        }
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

//- (void)applicationDidEnterBackground:(UIApplication *)application {
//    [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:NULL];
//    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
//}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    NSLog(@"applicationDidBecomeActive");
    
    [self addApplicationStatusToPList:@"applicationDidBecomeActive"];
    
    //Remove the "afterResume" Flag after the app is active again.
    self.shareModel.afterResume = NO;
    
    if(self.shareModel.anotherLocationManager)
        [self.shareModel.anotherLocationManager stopMonitoringSignificantLocationChanges];
    
    self.shareModel.anotherLocationManager = [[CLLocationManager alloc]init];
    self.shareModel.anotherLocationManager.delegate = self;
    self.shareModel.anotherLocationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    self.shareModel.anotherLocationManager.activityType = CLActivityTypeOtherNavigation;
    
    if(IS_OS_8_OR_LATER) {
        [self.shareModel.anotherLocationManager requestAlwaysAuthorization];
    }
    [self.shareModel.anotherLocationManager startMonitoringSignificantLocationChanges];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    ArrayAlarmes *alarms = [engine alarms];
    [[NSUserDefaults standardUserDefaults] setObject:[alarms getarray] forKey:@"alarms"];
}


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"Error", nil)] message:[NSString stringWithFormat:NSLocalizedString(@"Failed to get your location", nil)] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
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
                    localNotification.alertBody = [NSString stringWithFormat:NSLocalizedString(@"Wake up!\n You're getting closer to your destination!", nil)];
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

                [a disparar];
                AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
            }
        } else {
            if ([a disparado]) {
                [a stop];
            }
        }
    }
    
//    if (shortestDistance < 10) {
//        [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
//    } else if (shortestDistance < 100) {
//        [locationManager setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
//    } else if (shortestDistance < 3000) {
//        [locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
//    } else if (shortestDistance < 10000)  {
//        [locationManager setDesiredAccuracy:kCLLocationAccuracyKilometer];
//    } else {
//        [locationManager setDesiredAccuracy:kCLLocationAccuracyThreeKilometers];
//    }
//    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];

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
            [a stop];
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
    NSLog(@"teste1");
}



- (void)applicationDidEnterBackground:(UIApplication *)application
{
    NSLog(@"applicationDidEnterBackground");
    [self.shareModel.anotherLocationManager stopMonitoringSignificantLocationChanges];
    
    if(IS_OS_8_OR_LATER) {
        [self.shareModel.anotherLocationManager requestAlwaysAuthorization];
    }
    [self.shareModel.anotherLocationManager startMonitoringSignificantLocationChanges];
    
    [self addApplicationStatusToPList:@"applicationDidEnterBackground"];
}

-(void)addResumeLocationToPList{
    
    NSLog(@"addResumeLocationToPList");
    UIApplication* application = [UIApplication sharedApplication];
    
    NSString * appState;
    if([application applicationState]==UIApplicationStateActive)
        appState = @"UIApplicationStateActive";
    if([application applicationState]==UIApplicationStateBackground)
        appState = @"UIApplicationStateBackground";
    if([application applicationState]==UIApplicationStateInactive)
        appState = @"UIApplicationStateInactive";
    
    self.shareModel.myLocationDictInPlist = [[NSMutableDictionary alloc]init];
    [self.shareModel.myLocationDictInPlist setObject:@"UIApplicationLaunchOptionsLocationKey" forKey:@"Resume"];
    [self.shareModel.myLocationDictInPlist setObject:appState forKey:@"AppState"];
    [self.shareModel.myLocationDictInPlist setObject:[NSDate date] forKey:@"Time"];
    
    NSString *plistName = [NSString stringWithFormat:@"LocationArray.plist"];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    NSString *fullPath = [NSString stringWithFormat:@"%@/%@", docDir, plistName];
    
    NSMutableDictionary *savedProfile = [[NSMutableDictionary alloc] initWithContentsOfFile:fullPath];
    
    if (!savedProfile){
        savedProfile = [[NSMutableDictionary alloc] init];
        self.shareModel.myLocationArrayInPlist = [[NSMutableArray alloc]init];
    }
    else{
        self.shareModel.myLocationArrayInPlist = [savedProfile objectForKey:@"LocationArray"];
    }
    
    if(self.shareModel.myLocationDictInPlist)
    {
        [self.shareModel.myLocationArrayInPlist addObject:self.shareModel.myLocationDictInPlist];
//        [savedProfile setObject:self.shareModel.myLocationArrayInPlist forKey:@"LocationArray"];
    }
    
    if (![savedProfile writeToFile:fullPath atomically:FALSE] ) {
        NSLog(@"Couldn't save LocationArray.plist" );
    }
}


-(void)addLocationToPList:(BOOL)fromResume{
    NSLog(@"addLocationToPList");
    
    UIApplication* application = [UIApplication sharedApplication];
    
    NSString * appState;
    if([application applicationState]==UIApplicationStateActive)
        appState = @"UIApplicationStateActive";
    if([application applicationState]==UIApplicationStateBackground)
        appState = @"UIApplicationStateBackground";
    if([application applicationState]==UIApplicationStateInactive)
        appState = @"UIApplicationStateInactive";
    
    self.shareModel.myLocationDictInPlist = [[NSMutableDictionary alloc]init];
    [self.shareModel.myLocationDictInPlist setObject:[NSNumber numberWithDouble:self.myLocation.latitude]  forKey:@"Latitude"];
    [self.shareModel.myLocationDictInPlist setObject:[NSNumber numberWithDouble:self.myLocation.longitude] forKey:@"Longitude"];
    [self.shareModel.myLocationDictInPlist setObject:[NSNumber numberWithDouble:self.myLocationAccuracy] forKey:@"Accuracy"];
    
    [self.shareModel.myLocationDictInPlist setObject:appState forKey:@"AppState"];
    
    if(fromResume)
        [self.shareModel.myLocationDictInPlist setObject:@"YES" forKey:@"AddFromResume"];
    else
        [self.shareModel.myLocationDictInPlist setObject:@"NO" forKey:@"AddFromResume"];
    
    [self.shareModel.myLocationDictInPlist setObject:[NSDate date] forKey:@"Time"];
    
    NSString *plistName = [NSString stringWithFormat:@"LocationArray.plist"];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    NSString *fullPath = [NSString stringWithFormat:@"%@/%@", docDir, plistName];
    
    NSMutableDictionary *savedProfile = [[NSMutableDictionary alloc] initWithContentsOfFile:fullPath];
    
    if (!savedProfile){
        savedProfile = [[NSMutableDictionary alloc] init];
        self.shareModel.myLocationArrayInPlist = [[NSMutableArray alloc]init];
    }
    else{
        self.shareModel.myLocationArrayInPlist = [savedProfile objectForKey:@"LocationArray"];
    }
    
    NSLog(@"Dict: %@",self.shareModel.myLocationDictInPlist);
    
    if(self.shareModel.myLocationDictInPlist)
    {
        [self.shareModel.myLocationArrayInPlist addObject:self.shareModel.myLocationDictInPlist];
//        [savedProfile setObject:self.shareModel.myLocationArrayInPlist forKey:@"LocationArray"];
    }
    
    if (![savedProfile writeToFile:fullPath atomically:FALSE] ) {
        NSLog(@"Couldn't save LocationArray.plist" );
    }
}


-(void)addApplicationStatusToPList:(NSString*)applicationStatus{
    
    NSLog(@"addApplicationStatusToPList");
    UIApplication* application = [UIApplication sharedApplication];
    
    NSString * appState;
    if([application applicationState]==UIApplicationStateActive)
        appState = @"UIApplicationStateActive";
    if([application applicationState]==UIApplicationStateBackground)
        appState = @"UIApplicationStateBackground";
    if([application applicationState]==UIApplicationStateInactive)
        appState = @"UIApplicationStateInactive";
    
    self.shareModel.myLocationDictInPlist = [[NSMutableDictionary alloc]init];
    [self.shareModel.myLocationDictInPlist setObject:applicationStatus forKey:@"applicationStatus"];
    [self.shareModel.myLocationDictInPlist setObject:appState forKey:@"AppState"];
    [self.shareModel.myLocationDictInPlist setObject:[NSDate date] forKey:@"Time"];
    
    NSString *plistName = [NSString stringWithFormat:@"LocationArray.plist"];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    NSString *fullPath = [NSString stringWithFormat:@"%@/%@", docDir, plistName];
    
    NSMutableDictionary *savedProfile = [[NSMutableDictionary alloc] initWithContentsOfFile:fullPath];
    
    if (!savedProfile){
        savedProfile = [[NSMutableDictionary alloc] init];
        self.shareModel.myLocationArrayInPlist = [[NSMutableArray alloc]init];
    }
    else{
        self.shareModel.myLocationArrayInPlist = [savedProfile objectForKey:@"LocationArray"];
    }
    
    if(self.shareModel.myLocationDictInPlist)
    {
        [self.shareModel.myLocationArrayInPlist addObject:self.shareModel.myLocationDictInPlist];
//        [savedProfile setObject:self.shareModel.myLocationArrayInPlist forKey:@"LocationArray"];
    }
    
    if (![savedProfile writeToFile:fullPath atomically:FALSE] ) {
        NSLog(@"Couldn't save LocationArray.plist" );
    }
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    NSLog(@"locationManager didUpdateLocations: %@",locations);
    
    for(int i=0;i<locations.count;i++){
        
        CLLocation * newLocation = [locations objectAtIndex:i];
        CLLocationCoordinate2D theLocation = newLocation.coordinate;
        CLLocationAccuracy theAccuracy = newLocation.horizontalAccuracy;
        
        self.myLocation = theLocation;
        self.myLocationAccuracy = theAccuracy;
    }
    
    [self addLocationToPList:self.shareModel.afterResume];
}



@end
