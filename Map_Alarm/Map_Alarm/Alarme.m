//
//  Alarme.m
//  Map_Alarm
//
//  Created by Gabriel Alberto de Jesus Preto on 02/03/15.
//  Copyright (c) 2015 Lidia Chou. All rights reserved.
//

#import "Alarme.h"

@implementation Alarme

@synthesize nome, destino, distance, volume, alarmSwitch, alertTocou, address, disparado;

-(instancetype)init
{
    self = [super init];
    if (self) {
        nome = @"";
        distance = 0;
        alarmSwitch = true;
        alertTocou = false;
        disparado = false;
        volume = 1.0f;
    }
    return self;
}

-(instancetype)initWithNome:(NSString *)n AndDestino: (CLLocation *)d AndDistance:(NSInteger) dist AndVolume:(float) vol;
{
    self = [super init];
    if (self) {
        nome = [NSString stringWithString:n];
        destino = d;
        distance = dist;
        alarmSwitch = true;
        volume = vol;
    }
    return self;
}



@end
