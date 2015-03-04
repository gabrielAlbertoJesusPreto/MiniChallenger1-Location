//
//  Alarme.m
//  Map_Alarm
//
//  Created by Gabriel Alberto de Jesus Preto on 02/03/15.
//  Copyright (c) 2015 Lidia Chou. All rights reserved.
//

#import "Alarme.h"

@implementation Alarme

@synthesize nome, destino, distance, alarmSwitch;

static Alarme* instancianewalarme = nil;


-(instancetype)init
{
    self = [super init];
    if (self) {
        nome = @"";
        distance = 0;
        alarmSwitch = true;
    }
    return self;
}

-(instancetype)initWithNome:(NSString *)n AndDestino:(CLLocation *)d
{
    self = [super init];
    if (self) {
        nome = n;
        destino = d;
        alarmSwitch = true;
    }
    return self;
}

+ (Alarme *)instanciaNewAlarme
{
    if (instancianewalarme == nil) {
        instancianewalarme = [[Alarme alloc] init];
    }
    return instancianewalarme;
}



@end
