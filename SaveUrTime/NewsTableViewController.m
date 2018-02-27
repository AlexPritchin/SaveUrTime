//
//  NewsTableViewController.m
//  SaveUrTime
//
//  Created by Alex Pritchin on 09/02/18.
//  Copyright © 2018 Alex Pritchin. All rights reserved.
//

#import "NewsTableViewController.h"

@interface NewsTableViewController ()

@end

@implementation NewsTableViewController

UIActivityIndicatorView *dataDownldActInd;
NewsArticlesModel *newsModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    newsModel = [[NewsArticlesModel alloc] init];
    if (newsModel.newsArticlesArray == nil) {
        dataDownldActInd = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        self.tableViewOutlet.backgroundView = dataDownldActInd;
        self.tableViewOutlet.tableFooterView = [[UIView alloc] init];
        self.tableViewOutlet.rowHeight = UITableViewAutomaticDimension;
        self.tableViewOutlet.estimatedRowHeight = 57;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (newsModel.newsArticlesArray == nil) {
        [dataDownldActInd startAnimating];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),  ^{
            [newsModel fillNewsArray];
            dispatch_async(dispatch_get_main_queue(), ^{
                [dataDownldActInd stopAnimating];
                [self.tableViewOutlet reloadData];
            });
        });
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return newsModel.newsArticlesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NEWS_CELL_REUSABLE_IDENTIFIER forIndexPath:indexPath];
    
    if (cell == nil) {
        return [[UITableViewCell alloc] init];
    }
    
    [cell loadData:newsModel.newsArticlesArray[indexPath.row]];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:SEGUE_IDENTIFIER_FROM_NEWS_TABLE_TO_NEWS_ARTICLE sender:indexPath];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:SEGUE_IDENTIFIER_FROM_NEWS_TABLE_TO_NEWS_ARTICLE]) {
        NewsArticleViewController *nArtViewContr = segue.destinationViewController;
        nArtViewContr.articleToDisplay = newsModel.newsArticlesArray[((NSIndexPath *)(sender)).row];
    }
}


@end
