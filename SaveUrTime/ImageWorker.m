//
//  ImageWorker.m
//  SaveUrTime
//
//  Created by Alex Pritchin on 08/03/18.
//  Copyright © 2018 Alex Pritchin. All rights reserved.
//

#import "ImageWorker.h"

@implementation ImageWorker

+(void) checkNewsImages{
    NSFileManager *manager = [[NSFileManager alloc] init];
    NSURL *dirURL = [manager URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:false error:nil];
    dirURL = [dirURL URLByAppendingPathComponent:NEWS_IMAGES_DIR_NAME];
    //NSLog(@"%@", fileURL.path);
    if (![manager fileExistsAtPath:dirURL.path]){
        [manager createDirectoryAtURL:dirURL withIntermediateDirectories:false attributes:nil error:nil];
    }
    else {
        NSDirectoryEnumerator *imgDirectoryEnumerator = [manager enumeratorAtPath:dirURL.path];
        NSString *fileName;
        NSURL *filePath;
        NSDate *minImageCreationDate = [[NSDate date] dateByAddingTimeInterval:-2*24*60*60];;
        while (fileName = [imgDirectoryEnumerator nextObject]) {
            filePath = [dirURL URLByAppendingPathComponent:[NSString stringWithFormat:@"%@%@", @"/", fileName]];
            NSDate *fileCreationDate = [manager attributesOfItemAtPath:filePath.path error:nil].fileCreationDate;
            if ([fileCreationDate compare:minImageCreationDate] == NSOrderedAscending){
                [manager removeItemAtPath:filePath.path error:nil];
            }
        }
    }
}

+(NSData *) getImageForUrl:(NSURL *) webURL{
    NSString *imageName = [NSString stringWithString:webURL.lastPathComponent];
    NSFileManager *manager = [[NSFileManager alloc] init];
    NSURL *imagePathURL = [manager URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:false error:nil];
    imagePathURL = [imagePathURL URLByAppendingPathComponent:[NSString stringWithFormat:@"%@%@%@",NEWS_IMAGES_DIR_NAME,@"/",imageName]];
    //NSLog(@"%@", fileURL.path);
    NSData *imageData;
    if (![manager fileExistsAtPath:imagePathURL.path]){
        imageData = [NSData dataWithContentsOfURL:webURL];
        [imageData writeToFile:imagePathURL.path atomically:true];
        return imageData;
    }
    imageData = [NSData dataWithContentsOfFile:imagePathURL.path];
    return imageData;
}

@end
