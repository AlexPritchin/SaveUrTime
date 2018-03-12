//
//  TasksDetailViewController.h
//  SaveUrTime
//
//  Created by Alex Pritchin on 22/02/18.
//  Copyright © 2018 Alex Pritchin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"
#import "DBWorkerCoreData.h"
#import "Constants.h"
#import "PlaceholderTextView.h"

@interface TasksDetailViewController : UIViewController

@property (strong, nonatomic) Task *taskToDisplay;
@property (nonatomic, assign) int taskMode;
@property (strong, nonatomic) DBWorkerCoreData *dbWork;

@property (weak, nonatomic) IBOutlet UILabel *modifiedDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet PlaceholderTextView *titleTextView;
@property (weak, nonatomic) IBOutlet PlaceholderTextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editButton;

-(IBAction)saveButtonTouched:(id)sender;
-(IBAction)editButtonTouched:(id)sender;
-(void)setBorderFor:(UITextView *)textView withColor:(UIColor *)color;

@end
