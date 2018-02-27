//
//  DBWorker.m
//  SaveUrTime
//
//  Created by Alex Pritchin on 22/02/18.
//  Copyright © 2018 Alex Pritchin. All rights reserved.
//

#import "DBWorker.h"

@implementation DBWorker

sqlite3 *db;

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSFileManager *manager = [[NSFileManager alloc] init];
        NSURL *fileURL = [manager URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:false error:nil];
        fileURL = [fileURL URLByAppendingPathComponent:@"TasksDatabase.sqlite"];
        //NSLog(@"%@", fileURL.path);
        if (![manager fileExistsAtPath:fileURL.path]){
            sqlite3_open([fileURL.path UTF8String], &db);
            sqlite3_exec(db, "PRAGMA foreign_keys = ON", nil, nil, nil);
            sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS TaskStatuses(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT)", nil, nil, nil);
            sqlite3_stmt *statement;
            sqlite3_prepare(db, "INSERT INTO TaskStatuses (name) VALUES (?)", -1, &statement, nil);
            sqlite3_bind_text(statement, 1, "Active", -1, nil);
            sqlite3_step(statement);
            sqlite3_prepare(db, "INSERT INTO TaskStatuses (name) VALUES (?)", -1, &statement, nil);
            sqlite3_bind_text(statement, 1, "Completed", -1, nil);
            sqlite3_step(statement);
            sqlite3_prepare(db, "INSERT INTO TaskStatuses (name) VALUES (?)", -1, &statement, nil);
            sqlite3_bind_text(statement, 1, "Deleted", -1, nil);
            sqlite3_step(statement);
            sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS Tasks(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT, created TEXT, modified TEXT, status INTEGER, FOREIGN KEY(id) REFERENCES TaskStatuses(id))", nil, nil, nil);
        }
        else {
            sqlite3_open([fileURL.path UTF8String], &db);
        }
    }
    return self;
}

-(nonnull NSMutableArray<Task *> *)selectTasksForTable{
    NSMutableArray<Task *> *resultArray = [[NSMutableArray alloc] init];
    Task *selectedTask;
    sqlite3_stmt *statement;
    sqlite3_prepare(db, "SELECT * FROM Tasks WHERE status <> 3 ORDER BY status, modified", -1, &statement, nil);
    while (sqlite3_step(statement) == SQLITE_ROW) {
        selectedTask = [[Task alloc] init];
        selectedTask.idValue = sqlite3_column_int(statement, 0);
        selectedTask.title = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
        selectedTask.descriptionText = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
        selectedTask.createdDate = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
        selectedTask.modifiedDate = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)];
        selectedTask.status = sqlite3_column_int(statement, 5);
        [resultArray addObject:selectedTask];
    }
    return resultArray;
}

-(void)add:(nonnull Task *)NewTask{
    sqlite3_stmt *statement;
    sqlite3_prepare(db, "INSERT INTO Tasks (title, description, created, modified, status) VALUES (?,?,?,?,?)", -1, &statement, nil);
    sqlite3_bind_text(statement, 1, [NewTask.title UTF8String], -1, nil);
    sqlite3_bind_text(statement, 2, [NewTask.descriptionText UTF8String], -1, nil);
    sqlite3_bind_text(statement, 3, [NewTask.createdDate UTF8String], -1, nil);
    sqlite3_bind_text(statement, 4, [NewTask.modifiedDate UTF8String], -1, nil);
    sqlite3_bind_int(statement, 5, NewTask.status);
    sqlite3_step(statement);
}

-(void)update:(nonnull Task *)ExistingTask{
    sqlite3_stmt *statement;
    sqlite3_prepare(db, "UPDATE Tasks SET title = ?, description = ?, modified = ?, status = ? WHERE id = ?", -1, &statement, nil);
    sqlite3_bind_text(statement, 1, [ExistingTask.title UTF8String], -1, nil);
    sqlite3_bind_text(statement, 2, [ExistingTask.descriptionText UTF8String], -1, nil);
    sqlite3_bind_text(statement, 3, [ExistingTask.modifiedDate UTF8String], -1, nil);
    sqlite3_bind_int(statement, 4, ExistingTask.status);
    sqlite3_bind_int(statement, 5, ExistingTask.idValue);
    sqlite3_step(statement);
}

-(void)remove:(int)ExistingTaskId{
    sqlite3_stmt *statement;
    sqlite3_prepare(db, "UPDATE Tasks SET status = ? WHERE id = ?", -1, &statement, nil);
    sqlite3_bind_int(statement, 1, TASK_STATUS_DELETED);
    sqlite3_bind_int(statement, 2, ExistingTaskId);
    sqlite3_step(statement);
}

@end
