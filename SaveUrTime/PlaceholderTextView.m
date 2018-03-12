//
//  PlaceholderTextView.m
//  SaveUrTime
//
//  Created by Alex Pritchin on 12/03/18.
//  Copyright © 2018 Alex Pritchin. All rights reserved.
//

#import "PlaceholderTextView.h"

@interface PlaceholderTextView()

@property (nonatomic, retain) UILabel *placeholder;

@end

@implementation PlaceholderTextView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
#if !(__has_feature(objc_arc))
    [self.placeholder release];
    self.placeholder = nil;
    [self.placeholderColor release];
    self.placeholderColor = nil;
    [self.placeholderText release];
    self.placeholderText = nil;
    [super dealloc];
#endif
}

-(void)awakeFromNib{
    [super awakeFromNib];
    
    if (!self.placeholderText) {
        self.placeholderText = @"";
    }
    if (!self.placeholderColor) {
        self.placeholderColor = [UIColor lightGrayColor];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
}

-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.placeholderText = @"";
        self.placeholderColor = [UIColor lightGrayColor];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

-(void)textChanged:(NSNotification *)notification{
    if (self.placeholderText.length == 0) {
        return;
    }
    
    [UIView animateWithDuration:PLACEHOLDER_TEXT_VIEW_TEXT_CHANGED_ANIMATION_DURATION animations:^{
        if (self.text.length == 0){
            [self viewWithTag:999].alpha = 1;
        }
        else {
            [self viewWithTag:999].alpha = 0;
        }
    }];
}

-(void)setText:(NSString *)text{
    [super setText:text];
    [self textChanged:nil];
}

-(void)drawRect:(CGRect)rect{
    if (self.placeholderText.length > 0) {
        if (self.placeholder == nil) {
            self.placeholder = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, self.bounds.size.width - 16,0)];
            self.placeholder.lineBreakMode = NSLineBreakByWordWrapping;
            self.placeholder.numberOfLines = 0;
            self.placeholder.font = self.font;
            self.placeholder.backgroundColor = [UIColor clearColor];
            self.placeholder.textColor = self.placeholderColor;
            self.placeholder.alpha = 0;
            self.placeholder.tag = 999;
            [self addSubview:self.placeholder];
        }
        self.placeholder.text = self.placeholderText;
        [self.placeholder sizeToFit];
        [self sendSubviewToBack:self.placeholder];
    }
    if ((self.text.length == 0) && (self.placeholderText.length > 0)) {
        [self viewWithTag:999].alpha = 1;
    }
    [super drawRect:rect];
}

@end
