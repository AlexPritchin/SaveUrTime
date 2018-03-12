//
//  TasksTableViewController.h
//  SaveUrTime
//
//  Created by Alex Pritchin on 22/02/18.
//  Copyright © 2018 Alex Pritchin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskTableViewCell.h"
#import "Task.h"
#import "TasksDetailViewController.h"
#import "DBWorkerCoreData.h"
#import "Constants.h"

@interface TasksTableViewController : UITableViewController <UIGestureRecognizerDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableViewOutlet;

- (IBAction)NewTaskButtonTouched:(id)sender;

@end
