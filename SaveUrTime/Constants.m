//
//  Constants.m
//  SaveUrTime
//
//  Created by Alex Pritchin on 14/02/18.
//  Copyright © 2018 Alex Pritchin. All rights reserved.
//

#import "Constants.h"

@implementation Constants

NSString * const BBC_RSS_URL = @"http://feeds.bbci.co.uk/news/world/rss.xml#";
NSString * const BBC_RSS_XML_TAG_ITEM = @"item";
NSString * const BBC_RSS_XML_TAG_MEDIATHUMBNAIL = @"media:thumbnail";
NSString * const BBC_RSS_XML_TAG_TITLE = @"title";
NSString * const BBC_RSS_XML_TAG_DESCRIPTION = @"description";
NSString * const BBC_RSS_XML_TAG_LINK = @"link";
NSString * const BBC_RSS_XML_TAG_PUBDATE = @"pubDate";
NSString * const BBC_RSS_XML_DATETIME_FORMAT = @"ccc, d MMM yyyy H:mm:ss";
NSString * const GMT_ABBREVIATION = @"GMT";
NSString * const NEWS_CELL_REUSABLE_IDENTIFIER = @"NewsCell";
NSString * const NEWS_CELL_DATETIME_FORMAT = @"dd/MM/yyyy";
NSString * const NEWS_ARTICLE_VIEW_DATETIME_FORMAT = @"ccc, d MMM yyyy H:mm:ss";
NSString * const SEGUE_FROM_NEWS_TABLE_TO_NEWS_ARTICLE_IDENTIFIER = @"ToDetails";

@end
