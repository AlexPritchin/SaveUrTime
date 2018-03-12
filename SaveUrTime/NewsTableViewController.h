//
//  NewsTableViewController.h
//  SaveUrTime
//
//  Created by Alex Pritchin on 09/02/18.
//  Copyright © 2018 Alex Pritchin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsTableViewCell.h"
#import "NewsArticleViewController.h"
#import "Constants.h"
#import "NewsDataWorker.h"

@interface NewsTableViewController : UITableViewController <NewsDataWorkerDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableViewOutlet;

@end
