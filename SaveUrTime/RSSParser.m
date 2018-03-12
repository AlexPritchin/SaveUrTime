//
//  RSSParser.m
//  SaveUrTime
//
//  Created by Alex Pritchin on 04/03/18.
//  Copyright © 2018 Alex Pritchin. All rights reserved.
//

#import "RSSParser.h"

@interface RSSParser (){
    NSMutableArray *rssArray;
    NewsArticle *foundItem;
    NSString *elemName;
    bool isInsideItem, isElementEnd;
}

@end

@implementation RSSParser

- (instancetype)init
{
    self = [super init];
    if (self) {
        isInsideItem = false;
        isElementEnd = true;
    }
    return self;
}

-(nullable NSArray *)parseRssFromData:(nonnull NSData *)rssData{
    rssArray = [[NSMutableArray alloc] init];
    
    NSXMLParser *rssParser = [[NSXMLParser alloc] initWithData:rssData];
    [rssParser setDelegate:self];
    [rssParser parse];
    return [rssArray copy];
}

-(void)parser: (nonnull NSXMLParser *)parser didStartElement:(nonnull NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName attributes:(nonnull NSDictionary<NSString *,NSString *> *)attributeDict{
    elemName = [[NSString alloc] initWithString:elementName];
    if ([elemName isEqualToString:BBC_RSS_XML_TAG_ITEM]) {
        isInsideItem = true;
        isElementEnd = true;
        foundItem = [[NewsArticle alloc] init];
    }
    else if ([elemName isEqualToString:BBC_RSS_XML_TAG_MEDIATHUMBNAIL]) {
            foundItem.thumbnail = [NSURL URLWithString:attributeDict[@"url"]];
    }
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
            if ([elemName isEqualToString:BBC_RSS_XML_TAG_TITLE]) {
                foundItem.title = trimmedStr;
            }
            else if ([elemName isEqualToString:BBC_RSS_XML_TAG_DESCRIPTION]) {
                     foundItem.descript = trimmedStr;
            }
            else if ([elemName isEqualToString:BBC_RSS_XML_TAG_LINK]) {
                     foundItem.link = trimmedStr;
            }
            else if ([elemName isEqualToString:BBC_RSS_XML_TAG_PUBDATE]) {
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
