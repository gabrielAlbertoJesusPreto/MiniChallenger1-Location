//
//  Engine.m
//  Map_Alarm
//
//  Created by Evandro Remon Pulz Viva on 3/6/15.
//  Copyright (c) 2015 Lidia Chou. All rights reserved.
//

#import "Engine.h"



@implementation Engine

static Engine * instanciaEngine = nil;

@synthesize alarmsTableView, creatingAlarm, alarms, locationManager, editing, indexEditing;

static Alarme* instancianewalarme = nil;

+(Engine *) instancia
{
    if (instanciaEngine == nil) {
        instanciaEngine = [[Engine alloc] init];
    }
    return instanciaEngine;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        alarms = [[ArrayAlarmes alloc] init];
        creatingAlarm = [[Alarme alloc] init];
        editing = false;

    }
    return self;
}

+ (Alarme *)instanciaNewAlarme
{
    if (instancianewalarme == nil) {
//        instancianewalarme = [[Alarme alloc] init];
    }
    return instancianewalarme;
}


@end
