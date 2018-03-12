//
//  PlaceholderTextView.h
//  SaveUrTime
//
//  Created by Alex Pritchin on 12/03/18.
//  Copyright © 2018 Alex Pritchin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

IB_DESIGNABLE
@interface PlaceholderTextView : UITextView

@property (nonatomic, retain) IBInspectable NSString *placeholderText;
@property (nonatomic, retain) IBInspectable UIColor *placeholderColor;

-(void) textChanged:(NSNotification*)notification;

@end
