//
//  RSSDownloader.m
//  SaveUrTime
//
//  Created by Alex Pritchin on 04/03/18.
//  Copyright © 2018 Alex Pritchin. All rights reserved.
//

#import "RSSDownloader.h"

@implementation RSSDownloader
@synthesize delegate;

-(void) getRssDataForParse{
    NSURLSessionDataTask *urlSessionDataTask = [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:BBC_RSS_URL] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        if([self.delegate respondsToSelector:@selector(didFinishRSSDownloading:)]){
            [self.delegate didFinishRSSDownloading:data];
        }
    }];
    [urlSessionDataTask resume];
}

@end
