//
//  Alarme.h
//  Map_Alarm
//
//  Created by Gabriel Alberto de Jesus Preto on 02/03/15.
//  Copyright (c) 2015 Lidia Chou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Alarme : NSObject
{
    NSString *nome;
    NSString *destino;
}

@property NSString *nome;
@property NSString *destino;

-(instancetype) initWithNome: (NSString *) n AndDestino: (NSString *) d;

@end
