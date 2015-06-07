//
//  Alarme.m
//  Map_Alarm
//
//  Created by Gabriel Alberto de Jesus Preto on 02/03/15.
//  Copyright (c) 2015 Lidia Chou. All rights reserved.
//

#import "Alarme.h"

@implementation Alarme

@synthesize nome, destino, distance, volume, alarmSwitch, alertTocou, address, disparado, cell;

-(instancetype)init
{
    self = [super init];
    if (self) {
        nome = @"";
        distance = 0;
        alarmSwitch = true;
        alertTocou = false;
        disparado = false;
        volume = 1.0f;
    }
    
    NSString *path = [NSString stringWithFormat:@"%@/teste.mp3", [[NSBundle mainBundle] resourcePath]];
    NSURL *url = [NSURL fileURLWithPath:path];
    
    NSError *error;
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    
    if (audioPlayer == nil) {
        NSLog(@"%@", [error description]);
    }
    return self;
}

-(instancetype)initWithNome:(NSString *)n AndDestino: (CLLocation *)d AndDistance:(NSInteger) dist AndVolume:(float) vol;
{
    self = [self init];
    if (self) {
        nome = [NSString stringWithString:n];
        destino = d;
        distance = dist;
        alarmSwitch = true;
        volume = vol;
    }
    return self;
}

-(Alarme *)clone
{
    Alarme *a = [[Alarme alloc] init];
    [a setNome:nome];
    [a setDestino:destino];
    [a setDistance:distance];
    [a setAddress:address];
    [a setAlarmSwitch:alarmSwitch];
    [a setAlertTocou:alertTocou];
    [a setDisparado:disparado];
    [a setVolume:volume];
    return a;
}

-(void) updateDist: (long) dist
{
    [[cell distanceLabel] setText:[NSString stringWithFormat:@"%lim (%lim)",(long)dist, (long) distance]];
}

-(void) updateAddress{
    [[cell addressLabel] setText:address];
}

-(void) disparar{
    disparado = true;
    [audioPlayer setVolume:volume];
    [audioPlayer prepareToPlay];
    [audioPlayer play];
}

-(void) stop{
    [audioPlayer stop];
    NSLog(@"teste");
}

@end
