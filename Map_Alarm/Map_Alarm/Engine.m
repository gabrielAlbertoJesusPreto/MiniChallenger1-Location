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

@synthesize alarmsTableView, creatingAlarm;

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


    }
    return self;
}

@end
