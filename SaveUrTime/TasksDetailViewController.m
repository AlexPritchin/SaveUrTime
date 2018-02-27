//
//  TasksDetailViewController.m
//  SaveUrTime
//
//  Created by Alex Pritchin on 22/02/18.
//  Copyright © 2018 Alex Pritchin. All rights reserved.
//

#import "TasksDetailViewController.h"

@interface TasksDetailViewController ()

@end

@implementation TasksDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.taskMode == TASK_WORK_MODE_NEW){
        self.saveButton.enabled = true;
        self.editButton.enabled = false;
        self.modifiedDateLabel.hidden = true;
        self.statusLabel.hidden = true;
        self.titleTextView.text = @"Title";
        self.descriptionTextView.text = @"Description";
        [self setBorderFor:self.titleTextView withColor:[UIColor grayColor]];
        [self setBorderFor:self.descriptionTextView withColor:[UIColor grayColor]];
    }
    else if (self.taskMode == TASK_WORK_MODE_VIEW){
        self.modifiedDateLabel.text = self.taskToDisplay.modifiedDate;
        switch (self.taskToDisplay.status) {
            case TASK_STATUS_ACTIVE: self.statusLabel.text = TASK_STATUS_ACTIVE_STR;
                break;
            case TASK_STATUS_COMPLETED: self.statusLabel.text = TASK_STATUS_COMPLETED_STR;
                                        self.editButton.enabled = false;
                break;
            default:
                break;
        }
        self.titleTextView.text = self.taskToDisplay.title;
        self.descriptionTextView.text = self.taskToDisplay.descriptionText;
        self.titleTextView.editable = false;
        self.descriptionTextView.editable = false;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveButtonTouched:(id)sender {
    [self setBorderFor:self.titleTextView withColor:[UIColor grayColor]];
    [self setBorderFor:self.descriptionTextView withColor:[UIColor grayColor]];
    if ([self.titleTextView.text isEqualToString:@""] || [self.descriptionTextView.text isEqualToString:@""]){
        if ([self.titleTextView.text isEqualToString:@""]) {
            [self setBorderFor:self.titleTextView withColor:[UIColor redColor]];
        }
        if ([self.descriptionTextView.text isEqualToString:@""]) {
            [self setBorderFor:self.descriptionTextView withColor:[UIColor redColor]];
        }
        return;
    }
    if (self.taskMode == TASK_WORK_MODE_NEW){
        Task *newTask = [[Task alloc] init];
        newTask.title = self.titleTextView.text;
        newTask.descriptionText = self.descriptionTextView.text;
        NSDateFormatter *dtFormat = [[NSDateFormatter alloc] init];
        [dtFormat setDateFormat:TASK_DATETIME_FORMAT];
        newTask.createdDate = [dtFormat stringFromDate:[NSDate date]];
        newTask.modifiedDate = newTask.createdDate;
        newTask.status = TASK_STATUS_ACTIVE;
        [self.dbWork add:newTask];
    }
    else if (self.taskMode == TASK_WORK_MODE_EDIT){
        self.taskToDisplay.title = self.titleTextView.text;
        self.taskToDisplay.descriptionText = self.descriptionTextView.text;
        NSDateFormatter *dtFormat = [[NSDateFormatter alloc] init];
        [dtFormat setDateFormat:TASK_DATETIME_FORMAT];
        self.taskToDisplay.modifiedDate = [dtFormat stringFromDate:[NSDate date]];
        [self.dbWork update:self.taskToDisplay];
    }
    [self.navigationController popToRootViewControllerAnimated:true];
}

- (IBAction)editButtonTouched:(id)sender {
    self.taskMode = TASK_WORK_MODE_EDIT;
    self.editButton.enabled = false;
    self.saveButton.enabled = true;
    self.titleTextView.editable = true;
    self.descriptionTextView.editable = true;
    [self setBorderFor:self.titleTextView withColor:[UIColor grayColor]];
    [self setBorderFor:self.descriptionTextView withColor:[UIColor grayColor]];
}

-(void)setBorderFor:(UITextView *)textView withColor:(UIColor *)color{
    textView.layer.borderColor = color.CGColor;
    textView.layer.borderWidth = 1.0;
}

@end
