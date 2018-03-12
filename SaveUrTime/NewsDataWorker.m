//
//  NewsDataWorker.m
//  SaveUrTime
//
//  Created by Alex Pritchin on 04/03/18.
//  Copyright © 2018 Alex Pritchin. All rights reserved.
//

#import "NewsDataWorker.h"

@implementation NewsDataWorker
@synthesize delegate;

-(void)initializeData{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),  ^{
        RSSDownloader *rssDataDownloader = [[RSSDownloader alloc] init];
        rssDataDownloader.delegate = self;
        [rssDataDownloader getRssDataForParse];
    });
}

-(void)didFinishRSSDownloading:(NSData *)rssData{
    RSSParser *rssDataParser = [[RSSParser alloc] init];
    NSArray<NewsArticle *> *parsedRssArray = [rssDataParser parseRssFromData:rssData];
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.delegate respondsToSelector:@selector(didFinishDataInitialization:)]){
            [self.delegate didFinishDataInitialization:parsedRssArray];
        }
    });
}

@end
