//
//  TasksTableViewController.m
//  SaveUrTime
//
//  Created by Alex Pritchin on 22/02/18.
//  Copyright © 2018 Alex Pritchin. All rights reserved.
//

#import "TasksTableViewController.h"

@interface TasksTableViewController ()

@end

@implementation TasksTableViewController

NSMutableArray<Task *> *tasksArray;
DBWorker *dataBase;
int taskMode;

- (void)viewDidLoad {
    [super viewDidLoad];
    tasksArray = [[NSMutableArray alloc] init];
    dataBase = [[DBWorker alloc] init];
    taskMode = -1;
    self.tableViewOutlet.tableFooterView = [[UIView alloc] init];
    self.tableViewOutlet.rowHeight = UITableViewAutomaticDimension;
    self.tableViewOutlet.estimatedRowHeight = 57;
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    UISwipeGestureRecognizer *rightSwipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipe:)];
    rightSwipeRecognizer.delegate = self;
    [rightSwipeRecognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.tableViewOutlet addGestureRecognizer:rightSwipeRecognizer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    tasksArray = [dataBase selectTasksForTable];
    [self.tableViewOutlet reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tasksArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TASK_CELL_REUSABLE_IDENTIFIER forIndexPath:indexPath];
    
    if (cell == nil) {
        return [[UITableViewCell alloc] init];
    }
    
    [cell loadData:tasksArray[indexPath.row]];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    taskMode = TASK_WORK_MODE_VIEW;
    [self performSegueWithIdentifier:SEGUE_IDENTIFIER_FROM_TASK_TABLE_TO_TASK_DETAIL sender:indexPath];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:SEGUE_IDENTIFIER_FROM_TASK_TABLE_TO_TASK_DETAIL]) {
        TasksDetailViewController *nTaskViewContr = segue.destinationViewController;
        if (taskMode == TASK_WORK_MODE_VIEW) {
            nTaskViewContr.taskToDisplay = tasksArray[((NSIndexPath *)(sender)).row];
        }
        else {
            nTaskViewContr.taskToDisplay = nil;
        }
        nTaskViewContr.dbWork = dataBase;
        nTaskViewContr.taskMode = taskMode;
    }
}

- (IBAction)NewTaskButtonTouched:(id)sender {
    taskMode = TASK_WORK_MODE_NEW;
    [self performSegueWithIdentifier:SEGUE_IDENTIFIER_FROM_TASK_TABLE_TO_TASK_DETAIL sender:sender];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [dataBase remove:tasksArray[indexPath.row].idValue];
        [tasksArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)rightSwipe:(UISwipeGestureRecognizer *)gestureRecognizer{
    CGPoint location = [gestureRecognizer locationInView:self.tableViewOutlet];
    NSIndexPath *indexPath = [self.tableViewOutlet indexPathForRowAtPoint:location];
    tasksArray[indexPath.row].status = TASK_STATUS_COMPLETED;
    [dataBase update:tasksArray[indexPath.row]];
    [self.tableViewOutlet reloadData];    
}

@end
