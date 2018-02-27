//
//  Task.h
//  SaveUrTime
//
//  Created by Alex Pritchin on 22/02/18.
//  Copyright © 2018 Alex Pritchin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Task : NSObject

@property (nonatomic, assign) int idValue;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *descriptionText;
@property (strong, nonatomic) NSString *createdDate;
@property (strong, nonatomic) NSString *modifiedDate;
@property (nonatomic, assign) int status;

@end
