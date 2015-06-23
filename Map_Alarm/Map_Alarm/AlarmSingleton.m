//
//  AlarmSingleton.m
//  Map_Alarm
//
//  Created by Evandro Remon Pulz Viva on 23/06/15.
//  Copyright (c) 2015 Lidia Chou. All rights reserved.
//

#import "AlarmSingleton.h"
#import "AlarmRealm.h"
#import "Alarme.h"
#import <CoreLocation/CoreLocation.h>


@implementation AlarmSingleton

static AlarmSingleton *SINGLETON = nil;

static bool isFirstAccess = YES;

#pragma mark - Public Method

+ (id)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isFirstAccess = NO;
        SINGLETON = [[super allocWithZone:NULL] init];
    });
    
    return SINGLETON;
}


- (void)salvar:(AlarmRealm *)alarm {
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm addObject:alarm];
    [realm commitWriteTransaction];
}

- (void)remover:(Alarme *)alarm {
    
    RLMResults *resultados = [AlarmRealm allObjects];

    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    
    for (AlarmRealm *b in resultados) {
        NSLog(@"1 %@", b.name);
        NSLog(@"2 %@", alarm.nome);
        if ([b.name isEqualToString: alarm.nome]) {
            if (b.latitude == alarm.destino.coordinate.latitude && b.longitude == alarm.destino.coordinate.longitude) {
                [realm deleteObject: b];
                break;
            }
        }
    }
//    [realm deleteAllObjects];
    [realm commitWriteTransaction];
}

- (void)salvarAlarm:(Alarme *)alarm {
    if (alarm != nil){
    AlarmRealm *a = [[AlarmRealm alloc] init];
    a.name = alarm.nome;
    a.latitude = alarm.destino.coordinate.latitude;
    a.longitude = alarm.destino.coordinate.longitude;
    a.distance = alarm.distance;
    a.address = alarm.address;
    a.volume = alarm.volume;
    
    [self salvar: a];
    }
}


- (NSArray *)todosAlarmes {
    RLMResults *resultados = [AlarmRealm allObjects];
    NSMutableArray *alarms = [[NSMutableArray alloc] initWithCapacity:[resultados count]];
    
    for (AlarmRealm *b in resultados) {
        [alarms addObject:b];
    }
    
    return alarms;
}

@end









