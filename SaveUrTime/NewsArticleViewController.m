//
//  NewsArticleViewController.m
//  SaveUrTime
//
//  Created by Alex Pritchin on 09/02/18.
//  Copyright © 2018 Alex Pritchin. All rights reserved.
//

#import "NewsArticleViewController.h"

@interface NewsArticleViewController ()

@end

@implementation NewsArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDateFormatter *dtFormat = [[NSDateFormatter alloc] init];
    [dtFormat setDateFormat:NEWS_ARTICLE_VIEW_DATETIME_FORMAT];
    
    self.titleLabel.text = self.articleToDisplay.title;
    self.pubDateLabel.text = [dtFormat stringFromDate:self.articleToDisplay.pubDate];
    self.thumbnailImageView.image = [UIImage imageWithData:self.articleToDisplay.thumbnail];
    self.descriptionLabel.text = self.articleToDisplay.descript;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)urlButtonTouched:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.articleToDisplay.link]];
}

@end
