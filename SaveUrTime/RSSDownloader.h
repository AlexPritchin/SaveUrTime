//
//  RSSDownloader.h
//  SaveUrTime
//
//  Created by Alex Pritchin on 04/03/18.
//  Copyright © 2018 Alex Pritchin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@class RSSDownloader;
@protocol RSSDownloaderDelegate <NSObject>

-(void)didFinishRSSDownloading:(NSData *)rssData;

@end

@interface RSSDownloader : NSObject

@property (strong, nonatomic) id <RSSDownloaderDelegate> delegate;

-(void) getRssDataForParse;

@end
