//
//  ArrayAlarmes.h
//  Map_Alarm
//
//  Created by Gabriel Alberto de Jesus Preto on 02/03/15.
//  Copyright (c) 2015 Lidia Chou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Alarme.h"

@interface ArrayAlarmes : NSObject
{
    NSMutableArray *arrayAlarmes;
}

@property NSMutableArray *arrayAlarmes;

-(void)addAlarme: (Alarme*)alarme;
-(void)removeAlarmeAtIndex: (NSUInteger)i;
-(Alarme*)alarmeAtIndex: (NSUInteger)i;
-(NSNumber *)count;

@end
