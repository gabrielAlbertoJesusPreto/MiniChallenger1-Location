//
//  ArrayAlarmes.m
//  Map_Alarm
//
//  Created by Gabriel Alberto de Jesus Preto on 02/03/15.
//  Copyright (c) 2015 Lidia Chou. All rights reserved.
//

#import "ArrayAlarmes.h"
#import "AlarmSingleton.h"
#import "Alarme.h"
#import "AlarmRealm.h"


@implementation ArrayAlarmes

@synthesize arrayAlarmes;

-(instancetype)init{
    self = [super init];
    if(self){
        mutableArrayAlarmes = [[NSMutableArray alloc]init];
    }
    return self;
}

-(void)addAlarmes:(NSArray*)alarms
{
    for (int i = 0; i < (int)[alarms count]; i++) {
        AlarmRealm *b = [alarms objectAtIndex:i];
        Alarme *a = [[Alarme alloc] init];
        a.nome = b.name;
        a.destino = [[CLLocation alloc] initWithLatitude:b.latitude longitude:b.longitude];
        a.volume = b.volume;
        a.address = b.address;
        a.distance = b.distance;
        a.alarmSwitch = false;
        
        [mutableArrayAlarmes addObject:a];
    }
}

-(void)addAlarme: (Alarme*)alarme{
    [mutableArrayAlarmes addObject:alarme];
    [[AlarmSingleton sharedInstance] salvarAlarm: alarme];
}

-(void)removeAlarmeAtIndex: (NSInteger) i {
    Alarme *a = [mutableArrayAlarmes objectAtIndex:i];
    [[AlarmSingleton sharedInstance] remover:a];
    [mutableArrayAlarmes removeObjectAtIndex:i];
    
}

-(Alarme*)alarmeAtIndex: (NSInteger)i{
    return [mutableArrayAlarmes objectAtIndex:i];
}

-(NSNumber *)count{
    return [NSNumber numberWithInteger:[mutableArrayAlarmes count]];
}

-(NSMutableArray *) getarray
{
    return mutableArrayAlarmes;
}



@end
