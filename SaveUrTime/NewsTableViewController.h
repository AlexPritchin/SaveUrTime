//
//  NewsTableViewController.h
//  SaveUrTime
//
//  Created by Alex Pritchin on 09/02/18.
//  Copyright © 2018 Alex Pritchin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsTableViewCell.h"
#import "NewsArticlesModel.h"
#import "NewsArticleViewController.h"
#import "Constants.h"

@interface NewsTableViewController : UITableViewController

@property (strong, nonatomic) IBOutlet UITableView *tableViewOutlet;

@end
