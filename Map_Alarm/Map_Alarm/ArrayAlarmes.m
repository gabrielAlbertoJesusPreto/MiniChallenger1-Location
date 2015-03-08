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

-(instancetype)init{
    self = [super init];
    if(self){
        mutableArrayAlarmes = [[NSMutableArray alloc]init];
    }
    return self;
}

-(void)addAlarmes:(NSMutableArray*)alarms
{
    for (int i = 0; i < (int)[alarms count]; i++) {
        [self addAlarme:[alarms objectAtIndex:i]];
    }
}

-(void)addAlarme: (Alarme*)alarme{
    [mutableArrayAlarmes addObject:alarme];
}

-(void)removeAlarmeAtIndex: (NSInteger)i{
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
