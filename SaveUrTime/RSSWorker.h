//
//  RSSWorker.h
//  SaveUrTime
//
//  Created by Alex Pritchin on 11/02/18.
//  Copyright © 2018 Alex Pritchin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsArticle.h"
#import "Constants.h"

@interface RSSWorker : NSObject <NSXMLParserDelegate, NSURLSessionDelegate, NSURLSessionDataDelegate>

-(nullable NSArray *)getRss;

-(void)parser: (nonnull NSXMLParser *)parser didStartElement:(nonnull NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName attributes:(nonnull NSDictionary<NSString *,NSString *> *)attributeDict;
-(void)parser: (nonnull NSXMLParser *)parser didEndElement:(nonnull NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName;
-(void)parser: (nonnull NSXMLParser *)parser foundCharacters:(nonnull NSString *)string;

-(void)URLSession: (nonnull NSURLSession *)session dataTask:(nonnull NSURLSessionDataTask *)dataTask didReceiveData:(nullable NSData *)data;

@end
