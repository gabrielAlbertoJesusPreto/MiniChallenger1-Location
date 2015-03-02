//
//  DistanceViewController.h
//  Map_Alarm
//
//  Created by Lidia Chou on 3/2/15.
//  Copyright (c) 2015 Lidia Chou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DistanceViewController : UICollectionViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageMap;
@property (weak, nonatomic) IBOutlet UITextField *distanceMeters;
- (IBAction)saveButton:(id)sender;

@end
