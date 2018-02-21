//
//  NewsArticle.h
//  SaveUrTime
//
//  Created by Alex Pritchin on 09/02/18.
//  Copyright © 2018 Alex Pritchin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsArticle : NSObject

@property (strong, atomic) NSString *title;
@property (strong, atomic) NSString *descript;
@property (strong, atomic) NSString *link;
@property (strong, atomic) NSDate *pubDate;
@property (strong, atomic) NSData *thumbnail;

@end
