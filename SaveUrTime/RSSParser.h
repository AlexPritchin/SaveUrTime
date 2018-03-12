//
//  RSSParser.h
//  SaveUrTime
//
//  Created by Alex Pritchin on 04/03/18.
//  Copyright © 2018 Alex Pritchin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsArticle.h"
#import "Constants.h"

@interface RSSParser : NSObject <NSXMLParserDelegate>

-(nullable NSArray *)parseRssFromData:(nonnull NSData *)rssData;

-(void)parser: (nonnull NSXMLParser *)parser didStartElement:(nonnull NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName attributes:(nonnull NSDictionary<NSString *,NSString *> *)attributeDict;
-(void)parser: (nonnull NSXMLParser *)parser didEndElement:(nonnull NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName;
-(void)parser: (nonnull NSXMLParser *)parser foundCharacters:(nonnull NSString *)string;

@end
