//
//  Alarme.m
//  Map_Alarm
//
//  Created by Gabriel Alberto de Jesus Preto on 02/03/15.
//  Copyright (c) 2015 Lidia Chou. All rights reserved.
//

#import "Alarme.h"

@implementation Alarme

@synthesize nome, destino, distance, alarmSwitch, alertTocou, address, disparado;

-(instancetype)init
{
    self = [super init];
    if (self) {
        nome = @"";
        distance = 0;
        alarmSwitch = true;
        alertTocou = false;
        disparado = false;
    }
    return self;
}

-(instancetype)initWithNome:(NSString *)n AndDestino: (CLLocation *)d AndDistance:(NSInteger) dist
{
    self = [super init];
    if (self) {
        nome = [NSString stringWithString:n];
        destino = d;
        distance = dist;
        alarmSwitch = true;
    }
    return self;
}



@end
