//
//  NewsDataWorker.h
//  SaveUrTime
//
//  Created by Alex Pritchin on 04/03/18.
//  Copyright © 2018 Alex Pritchin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsArticle.h"
#import "RSSDownloader.h"
#import "RSSParser.h"

@class NewsDataWorker;
@protocol NewsDataWorkerDelegate <NSObject>

-(void)didFinishDataInitialization:(NSArray<NewsArticle *> *)rssDataArray;

@end

@interface NewsDataWorker : NSObject <RSSDownloaderDelegate>

@property (weak, nonatomic) id <NewsDataWorkerDelegate> delegate;

-(void)initializeData;

@end
