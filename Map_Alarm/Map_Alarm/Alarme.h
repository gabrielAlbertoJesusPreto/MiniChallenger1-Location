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
    NSNumber *distance;
    bool alertTocou;
}

@property NSString *nome;
@property CLLocation *destino;
@property NSNumber *distance;
@property bool alertTocou;

-(instancetype) initWithNome: (NSString *) n AndDestino: (NSString *) d;

+ (Alarme*)instanciaNewAlarme;

@end
