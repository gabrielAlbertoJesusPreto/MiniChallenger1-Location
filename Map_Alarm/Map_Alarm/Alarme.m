//
//  Alarme.m
//  Map_Alarm
//
//  Created by Gabriel Alberto de Jesus Preto on 02/03/15.
//  Copyright (c) 2015 Lidia Chou. All rights reserved.
//

#import "Alarme.h"

@implementation Alarme

@synthesize nome, destino;

-(instancetype)initWithNome:(NSString *)n AndDestino:(NSString *)d
{
    self = [super init];
    if (self) {
        nome = n;
        destino = d;
    }
    return self;
}

@end
