//
//  NewsArticleViewController.h
//  SaveUrTime
//
//  Created by Alex Pritchin on 09/02/18.
//  Copyright © 2018 Alex Pritchin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsArticle.h"
#import "Constants.h"

@interface NewsArticleViewController : UIViewController

@property (strong, nonatomic) NewsArticle *articleToDisplay;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *pubDateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailImageView;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

- (IBAction)urlButtonTouched:(id)sender;

@end
