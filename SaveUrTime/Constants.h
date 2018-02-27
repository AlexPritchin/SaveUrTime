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
extern NSString * const SEGUE_IDENTIFIER_FROM_NEWS_TABLE_TO_NEWS_ARTICLE;
extern NSString * const TASK_DATETIME_FORMAT;
extern NSString * const TASK_CELL_REUSABLE_IDENTIFIER;
extern NSString * const SEGUE_IDENTIFIER_FROM_TASK_TABLE_TO_TASK_DETAIL;
extern NSString * const TASK_STATUS_ACTIVE_STR;
extern NSString * const TASK_STATUS_COMPLETED_STR;
extern NSString * const TASK_STATUS_DELETED_STR;

typedef NS_ENUM(int, TaskStatus){
    TASK_STATUS_ACTIVE = 1,
    TASK_STATUS_COMPLETED = 2,
    TASK_STATUS_DELETED = 3
};

typedef NS_ENUM(int, TaskWorkMode){
    TASK_WORK_MODE_NEW = 0,
    TASK_WORK_MODE_VIEW = 1,
    TASK_WORK_MODE_EDIT = 2,
};

@end
