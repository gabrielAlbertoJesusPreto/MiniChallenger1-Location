//
//  AlarmSingleton.h
//  Map_Alarm
//
//  Created by Evandro Remon Pulz Viva on 23/06/15.
//  Copyright (c) 2015 Lidia Chou. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AlarmRealm, Alarme;

@interface AlarmSingleton : NSObject

+ (AlarmSingleton*)sharedInstance;

- (void)salvar:(AlarmRealm *)alarm;
- (void)salvarAlarm:(Alarme *)alarm;
- (void)remover:(Alarme *)alarm;
- (NSArray *)todosAlarmes;


@end
