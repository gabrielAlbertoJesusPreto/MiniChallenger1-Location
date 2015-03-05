//
//  AlarmTableViewController.m
//  Map_Alarm
//
//  Created by Lidia Chou on 3/2/15.
//  Copyright (c) 2015 Lidia Chou. All rights reserved.
//

#import "AlarmTableViewController.h"

@interface AlarmTableViewController ()

@end

@implementation AlarmTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    alarms = [ArrayAlarmes instancia];
    
    UILabel *label = [[UILabel alloc] init];
    [label setTextColor:[UIColor lightGrayColor]];
    [label setText:@"No alarms found.\nTo add one press '+'"];
    label.numberOfLines = 2;
    [label sizeToFit];
    label.frame = CGRectMake((self.tableView.bounds.size.width - label.bounds.size.width) / 2.0f,
                             (self.tableView.bounds.size.width - label.bounds.size.height) / 2.0f,
                             label.bounds.size.width,
                             label.bounds.size.height);
    [self.tableView insertSubview:label atIndex:0];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AlarmTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"alarmTableCell" forIndexPath:indexPath];
    
    [[cell alarmNameLabel] setText: [[alarms alarmeAtIndex:indexPath.row] nome]];
    [[cell addressLabel] setText: [[alarms alarmeAtIndex:indexPath.row] address]];
    [cell setIndex: indexPath.row];

    
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //remove the deleted object from your data source.
        //If your data source is an NSMutableArray, do this
        //NSIndexPath *myIndexPath = [self.tableView indexPathForSelectedRow];
        [alarms removeAlarmeAtIndex:indexPath.row];
        [tableView deselectRowAtIndexPath:indexPath animated:UITableViewRowAnimationLeft];
        [tableView reloadData]; // tell table to refresh now
    }
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


- (IBAction)editButton:(id)sender {
    
    if(self.editing)
    {
        [super setEditing:NO animated:NO];
        [self refreshControl];
        
    }
    else
    {
        [super setEditing:YES animated:YES];
        [self  refreshControl];
    }
    
}

@end
