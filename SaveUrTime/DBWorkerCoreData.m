//
//  DBWorkerCoreData.m
//  SaveUrTime
//
//  Created by Alex Pritchin on 10/03/18.
//  Copyright © 2018 Alex Pritchin. All rights reserved.
//

#import "DBWorkerCoreData.h"

@interface DBWorkerCoreData (){
    NSManagedObjectContext *dbContext;
}

@end

@implementation DBWorkerCoreData

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSFileManager *manager = [[NSFileManager alloc] init];
        NSURL *fileURL = [manager URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:false error:nil];
        fileURL = [fileURL URLByAppendingPathComponent:@"TasksDatabaseCoreData.sqlite"];
        NSPersistentStoreCoordinator *storeCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[NSManagedObjectModel mergedModelFromBundles:@[[NSBundle mainBundle]]]];
        [storeCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:fileURL options:@{NSMigratePersistentStoresAutomaticallyOption : @YES} error:nil];
        dbContext = [[NSManagedObjectContext alloc] init];
        dbContext.persistentStoreCoordinator = storeCoordinator;
    }
    return self;
}

-(nonnull NSMutableArray<Task *> *)selectTasksForTable{
    NSMutableArray<Task *> *resultArray = [[NSMutableArray alloc] init];
    Task *selectedTask;
    NSSortDescriptor *sortStatus = [NSSortDescriptor sortDescriptorWithKey:@"status" ascending:true];
    NSSortDescriptor *sortModified = [NSSortDescriptor sortDescriptorWithKey:@"modified" ascending:true];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"status <> %i", TASK_STATUS_DELETED];
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Task"];
    request.predicate = predicate;
    request.sortDescriptors = @[ sortStatus, sortModified ];
    NSArray *tasks = [dbContext executeFetchRequest:request error:nil];
    for (NSManagedObject *task in tasks) {
        selectedTask = [[Task alloc] init];
        selectedTask.title = [task valueForKey:@"title"];
        selectedTask.descriptionText = [task valueForKey:@"taskdescription"];
        selectedTask.createdDate = [task valueForKey:@"created"];
        selectedTask.modifiedDate = [task valueForKey:@"modified"];
        selectedTask.status = ((NSNumber *)([task valueForKey:@"status"])).intValue;
        [resultArray addObject:selectedTask];
    }
    return resultArray;
}

-(nonnull NSManagedObject *)selectTask:(nonnull NSString *)taskCreatedDate{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Task"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"created = %@", taskCreatedDate];
    request.predicate = predicate;
    NSArray *tasks = [dbContext executeFetchRequest:request error:nil];
    return tasks[0];
}

-(void)add:(nonnull Task *)NewTask{
    NSManagedObject *newMOTask = [NSEntityDescription insertNewObjectForEntityForName:@"Task" inManagedObjectContext:dbContext];
    [newMOTask setValue:NewTask.title forKey:@"title"];
    [newMOTask setValue:NewTask.descriptionText forKey:@"taskdescription"];
    [newMOTask setValue:NewTask.createdDate forKey:@"created"];
    [newMOTask setValue:NewTask.modifiedDate forKey:@"modified"];
    [newMOTask setValue:[NSNumber numberWithInt:NewTask.status] forKey:@"status"];
    [dbContext save:nil];
}

-(void)update:(nonnull Task *)ExistingTask{
    NSManagedObject *MOTask = [self selectTask:ExistingTask.createdDate];
    [MOTask setValue:ExistingTask.title forKey:@"title"];
    [MOTask setValue:ExistingTask.descriptionText forKey:@"taskdescription"];
    [MOTask setValue:ExistingTask.modifiedDate forKey:@"modified"];
    [MOTask setValue:[NSNumber numberWithInt:ExistingTask.status] forKey:@"status"];
    [dbContext save:nil];
}

-(void)remove:(nonnull NSString *)ExistingTaskCreatedDate{
    NSManagedObject *MOTask = [self selectTask:ExistingTaskCreatedDate];
    [MOTask setValue:[NSNumber numberWithInt:TASK_STATUS_DELETED] forKey:@"status"];
    [dbContext save:nil];
}

@end
