//
//  Engine.h
//  Map_Alarm
//
//  Created by Evandro Remon Pulz Viva on 3/6/15.
//  Copyright (c) 2015 Lidia Chou. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UITableView, Alarmes, Alarme;

@interface Engine : NSObject
{
    UITableView* alarmsTableview;
    Alarme* creatingAlarm;
}

@property (weak, nonatomic) UITableView *alarmsTableView;
@property (nonatomic) Alarme *creatingAlarm;

+(Engine *) instancia;

@end
