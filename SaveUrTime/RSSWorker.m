//
//  RSSWorker.m
//  SaveUrTime
//
//  Created by Alex Pritchin on 11/02/18.
//  Copyright © 2018 Alex Pritchin. All rights reserved.
//

#import "RSSWorker.h"

@implementation RSSWorker

NSMutableArray *rssArray;
NSData *rssData;
NewsArticle *foundItem;
NSString *elemName;
bool isInsideItem = false, isElementEnd = true;

-(nullable NSArray *)getRss{
    rssArray = [[NSMutableArray alloc] init];
    //rssData = [[NSData alloc] init];
    NSURLSessionConfiguration *urlSessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *urlSession = [NSURLSession sessionWithConfiguration:urlSessionConfiguration delegate:self delegateQueue:nil];
    NSURLSessionDataTask *urlSessionDataTask = [urlSession dataTaskWithURL:[NSURL URLWithString:BBC_RSS_URL]];
    //NSURL *bbcRss = [NSURL URLWithString:BBC_RSS_URL];
    [urlSessionDataTask resume];
    while (rssData == nil)
        sleep(2);
    //NSXMLParser *rssParser = [[NSXMLParser alloc] initWithContentsOfURL:bbcRss];
    NSXMLParser *rssParser = [[NSXMLParser alloc] initWithData:rssData];
    [rssParser setDelegate:self];
    [rssParser parse];
    return [rssArray copy];
}

-(void)URLSession: (nonnull NSURLSession *)session dataTask:(nonnull NSURLSessionDataTask *)dataTask didReceiveData:(nullable NSData *)data{
    rssData = data;
}

-(void)parser: (nonnull NSXMLParser *)parser didStartElement:(nonnull NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName attributes:(nonnull NSDictionary<NSString *,NSString *> *)attributeDict{
    elemName = [[NSString alloc] initWithString:elementName];
    if ([elemName isEqualToString:BBC_RSS_XML_TAG_ITEM]) {
        isInsideItem = true;
        isElementEnd = true;
        foundItem = [[NewsArticle alloc] init];
    }
    else
        if ([elemName isEqualToString:BBC_RSS_XML_TAG_MEDIATHUMBNAIL])
            foundItem.thumbnail = [NSData dataWithContentsOfURL:[NSURL URLWithString:attributeDict[@"url"]]];
    else
        isElementEnd = false;
}

-(void)parser: (nonnull NSXMLParser *)parser didEndElement:(nonnull NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName{
    if ([elementName isEqualToString:BBC_RSS_XML_TAG_ITEM]) {
        isInsideItem = false;
        [rssArray addObject:foundItem];
    }
    isElementEnd = true;
}

-(void)parser: (nonnull NSXMLParser *)parser foundCharacters:(nonnull NSString *)string{
    if (isInsideItem) {
        if (!isElementEnd) {
            NSString *trimmedStr = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            if ([elemName isEqualToString:BBC_RSS_XML_TAG_TITLE])
                foundItem.title = trimmedStr;
            else
                if ([elemName isEqualToString:BBC_RSS_XML_TAG_DESCRIPTION])
                    foundItem.descript = trimmedStr;
                else
                    if ([elemName isEqualToString:BBC_RSS_XML_TAG_LINK])
                        foundItem.link = trimmedStr;
                    else
                        if ([elemName isEqualToString:BBC_RSS_XML_TAG_PUBDATE]) {
                            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                            [dateFormat setDateFormat:BBC_RSS_XML_DATETIME_FORMAT];
                            [dateFormat setTimeZone:[NSTimeZone timeZoneWithAbbreviation:GMT_ABBREVIATION]];
                            NSString *trimmedStrWithoutGMT = [trimmedStr substringToIndex:(NSUInteger)[trimmedStr length]-4];
                            foundItem.pubDate = [dateFormat dateFromString:trimmedStrWithoutGMT];
                        }
        }
    }
}

@end
