//
//  DBWorkerCoreData.h
//  SaveUrTime
//
//  Created by Alex Pritchin on 10/03/18.
//  Copyright © 2018 Alex Pritchin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Task.h"
#import "Constants.h"
#import <CoreData/CoreData.h>

@interface DBWorkerCoreData : NSObject

-(nonnull NSMutableArray<Task *> *)selectTasksForTable;
-(nonnull NSManagedObject *)selectTask:(nonnull NSString *)taskCreatedDate;
-(void)add:(nonnull Task *)NewTask;
-(void)update:(nonnull Task *)ExistingTask;
-(void)remove:(nonnull NSString *)ExistingTaskCreatedDate;

@end
