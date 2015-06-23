//
//  AlarmRealm.h
//  Map_Alarm
//
//  Created by Evandro Remon Pulz Viva on 23/06/15.
//  Copyright (c) 2015 Lidia Chou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Realm/Realm.h>

@interface AlarmRealm: RLMObject

@property (nonatomic) NSString *name;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;
@property (nonatomic) NSInteger distance;
@property (nonatomic) NSString *address;
@property (nonatomic) float volume;



@end
