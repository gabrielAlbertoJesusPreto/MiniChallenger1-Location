//
//  Alarme.h
//  Map_Alarm
//
//  Created by Gabriel Alberto de Jesus Preto on 02/03/15.
//  Copyright (c) 2015 Lidia Chou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AlarmTableViewCell.h"
#import <AVFoundation/AVFoundation.h>
@class CLLocation, AlarmTableViewCell;

@interface Alarme : NSObject
{
    NSString *nome;
    CLLocation *destino;
    NSInteger distance;
    NSString *address;
    bool alarmSwitch;
    bool alertTocou;
    bool disparado;
    float volume;
    AlarmTableViewCell *cell;
    AVAudioPlayer *audioPlayer;
}

@property NSString *nome;
@property CLLocation *destino;
@property NSInteger distance;
@property NSString *address;
@property bool alarmSwitch;
@property bool alertTocou;
@property bool disparado;
@property float volume;
@property AlarmTableViewCell *cell;

-(instancetype) initWithNome: (NSString *) n AndDestino: (CLLocation *) d AndDistance: (NSInteger) dist AndVolume: (float) vol;

-(Alarme *) clone;

-(void) updateDist:(long) dist;
-(void) updateAddress;
-(void) disparar;
-(void) stop;

@end
