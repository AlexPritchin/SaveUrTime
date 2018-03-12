//
//  ImageWorker.h
//  SaveUrTime
//
//  Created by Alex Pritchin on 08/03/18.
//  Copyright © 2018 Alex Pritchin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@interface ImageWorker : NSObject

+(void) checkNewsImages;
+(NSData *) getImageForUrl:(NSURL *) webURL;

@end
