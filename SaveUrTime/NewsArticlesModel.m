//
//  NewsArticlesModel.m
//  SaveUrTime
//
//  Created by Alex Pritchin on 09/02/18.
//  Copyright © 2018 Alex Pritchin. All rights reserved.
//

#import "NewsArticlesModel.h"

@implementation NewsArticlesModel

-(void)fillNewsArray{
    self.newsArticlesArray = [[NSArray<NewsArticle *> alloc] init];
    RSSWorker *rss = [[RSSWorker alloc] init];
    self.newsArticlesArray = [rss getRss];
}

-(NSArray<NewsArticle *> *)getNewsArray{
    return self.newsArticlesArray;
}

@end
