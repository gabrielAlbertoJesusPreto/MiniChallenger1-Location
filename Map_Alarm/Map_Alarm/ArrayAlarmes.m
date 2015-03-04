//
//  ArrayAlarmes.m
//  Map_Alarm
//
//  Created by Gabriel Alberto de Jesus Preto on 02/03/15.
//  Copyright (c) 2015 Lidia Chou. All rights reserved.
//

#import "ArrayAlarmes.h"

@implementation ArrayAlarmes

@synthesize arrayAlarmes;

static ArrayAlarmes *instaciaAlarme = nil;

-(instancetype)init{
    self = [super init];
    if(self){
        arrayAlarmes = [[NSMutableArray alloc]init];
    }
    return self;
}

+(ArrayAlarmes*)instancia{
    if(instaciaAlarme == nil){
        instaciaAlarme = [[ArrayAlarmes alloc]init];
    }
    return instaciaAlarme;
}

-(void)addAlarmes:(NSMutableArray*)alarms
{
    for (int i = 0; i < (int)[alarms count]; i++) {
        [self addAlarme:[alarms objectAtIndex:i]];
    }
}

-(void)addAlarme: (Alarme*)alarme{
    [arrayAlarmes addObject:alarme];
}

-(void)removeAlarmeAtIndex: (NSUInteger)i{
    [arrayAlarmes removeObjectAtIndex:i];
}

-(Alarme*)alarmeAtIndex: (NSUInteger)i{
    return [arrayAlarmes objectAtIndex:i];
}

-(NSNumber *)count{
    return [NSNumber numberWithInteger:[arrayAlarmes count]];
}

-(NSMutableArray *) getarray
{
    return arrayAlarmes;
}

@end
