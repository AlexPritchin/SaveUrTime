//
//  TaskTableViewCell.h
//  SaveUrTime
//
//  Created by Alex Pritchin on 22/02/18.
//  Copyright © 2018 Alex Pritchin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"
#import "Constants.h"

@interface TaskTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *modifiedDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

-(void) loadData:(Task *)taskForLoadData;
-(void) setLabelsTextStrikeout;

@end
