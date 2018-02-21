//
//  Constants.h
//  SaveUrTime
//
//  Created by Alex Pritchin on 14/02/18.
//  Copyright © 2018 Alex Pritchin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Constants : NSObject

extern NSString * const BBC_RSS_URL;
extern NSString * const BBC_RSS_XML_TAG_ITEM;
extern NSString * const BBC_RSS_XML_TAG_MEDIATHUMBNAIL;
extern NSString * const BBC_RSS_XML_TAG_TITLE;
extern NSString * const BBC_RSS_XML_TAG_DESCRIPTION;
extern NSString * const BBC_RSS_XML_TAG_LINK;
extern NSString * const BBC_RSS_XML_TAG_PUBDATE;
extern NSString * const BBC_RSS_XML_DATETIME_FORMAT;
extern NSString * const GMT_ABBREVIATION;
extern NSString * const NEWS_CELL_REUSABLE_IDENTIFIER;
extern NSString * const NEWS_CELL_DATETIME_FORMAT;
extern NSString * const NEWS_ARTICLE_VIEW_DATETIME_FORMAT;
extern NSString * const SEGUE_FROM_NEWS_TABLE_TO_NEWS_ARTICLE_IDENTIFIER;

@end
