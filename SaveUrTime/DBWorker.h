//
//  DBWorker.h
//  SaveUrTime
//
//  Created by Alex Pritchin on 22/02/18.
//  Copyright © 2018 Alex Pritchin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"
#import "Task.h"
#import "Constants.h"

@interface DBWorker : NSObject

-(nonnull NSMutableArray<Task *> *)selectTasksForTable;
-(void)add:(nonnull Task *)NewTask;
-(void)update:(nonnull Task *)ExistingTask;
-(void)remove:(int)ExistingTaskId;

@end
