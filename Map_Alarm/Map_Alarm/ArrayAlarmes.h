//
//  ArrayAlarmes.h
//  Map_Alarm
//
//  Created by Gabriel Alberto de Jesus Preto on 02/03/15.
//  Copyright (c) 2015 Lidia Chou. All rights reserved.
//
#import <Foundation/Foundation.h>

@class Alarme;

@interface ArrayAlarmes : NSObject
{
    NSMutableArray *mutableArrayAlarmes;
}

@property NSMutableArray *arrayAlarmes;

-(void)addAlarmes: (NSArray *) alarms;
-(void)addAlarme: (Alarme*)alarme;
-(void)removeAlarmeAtIndex: (NSInteger)i;
-(Alarme*)alarmeAtIndex: (NSInteger)i;
-(NSNumber *)count;

-(NSMutableArray *) getarray;

@end
