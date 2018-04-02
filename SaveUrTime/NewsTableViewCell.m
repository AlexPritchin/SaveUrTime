//
//  NewsTableViewCell.m
//  SaveUrTime
//
//  Created by Alex Pritchin on 09/02/18.
//  Copyright © 2018 Alex Pritchin. All rights reserved.
//

#import "NewsTableViewCell.h"

@implementation NewsTableViewCell

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
    self.pubDateLabel.text = @"";
    self.titleLabel.text = @"";
    self.thumbnailImageView.image = nil;
}

-(void) loadData:(NewsArticle *)articleForLoadData{
    
    NSDateFormatter *dtFormat = [[NSDateFormatter alloc] init];
    [dtFormat setDateFormat:NEWS_CELL_DATETIME_FORMAT];
    
    self.pubDateLabel.text = [dtFormat stringFromDate:articleForLoadData.pubDate];
    self.titleLabel.text = articleForLoadData.title;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),  ^{
        __block UIImage *image = [UIImage imageWithData:[ImageWorker getImageForUrl:articleForLoadData.thumbnail]];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.thumbnailImageView.image = image;
        });
    });
}

@end
