//
//  NewsArticlesModel.h
//  SaveUrTime
//
//  Created by Alex Pritchin on 09/02/18.
//  Copyright © 2018 Alex Pritchin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsArticle.h"
#import "RSSWorker.h"

@interface NewsArticlesModel : NSObject

@property (strong, nonatomic) NSArray<NewsArticle *> *newsArticlesArray;

-(void)fillNewsArray;
-(NSArray<NewsArticle *> *)getNewsArray;

@end
