//
//  Alarme.h
//  Map_Alarm
//
//  Created by Gabriel Alberto de Jesus Preto on 02/03/15.
//  Copyright (c) 2015 Lidia Chou. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CLLocation;

@interface Alarme : NSObject
{
    NSString *nome;
    CLLocation *destino;
    NSInteger distance;
    NSString *address;
    bool alarmSwitch;
    bool alertTocou;
}

@property NSString *nome;
@property CLLocation *destino;
@property NSInteger distance;
@property NSString *address;
@property bool alarmSwitch;
@property bool alertTocou;

-(instancetype) initWithNome: (NSString *) n AndDestino: (CLLocation *) d AndDistance: (NSInteger) dist;

@end
