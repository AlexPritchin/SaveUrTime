//
//  TaskTableViewCell.m
//  SaveUrTime
//
//  Created by Alex Pritchin on 22/02/18.
//  Copyright © 2018 Alex Pritchin. All rights reserved.
//

#import "TaskTableViewCell.h"

@implementation TaskTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) prepareForReuse{
    [super prepareForReuse];
    self.modifiedDateLabel.text = @"";
    self.titleLabel.text = @"";
}

-(void) loadData:(Task *)taskForLoadData{
    
    self.modifiedDateLabel.text = taskForLoadData.modifiedDate;
    self.titleLabel.text = taskForLoadData.title;
    
    if (taskForLoadData.status == TASK_STATUS_COMPLETED){
        [self setLabelsTextStrikeout];
    }
}

-(void) setLabelsTextStrikeout{
    NSMutableAttributedString *strikeoutTextDate = [[NSMutableAttributedString alloc] initWithString:self.modifiedDateLabel.text];
    [strikeoutTextDate addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [strikeoutTextDate length])];
    [self.modifiedDateLabel setAttributedText:strikeoutTextDate];
    NSMutableAttributedString *strikeoutTextTitle = [[NSMutableAttributedString alloc] initWithString:self.titleLabel.text];
    [strikeoutTextTitle addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [strikeoutTextTitle length])];
    [self.titleLabel setAttributedText:strikeoutTextTitle];
}

@end
