//
//  HomeViewController.m
//  PersonalCapital
//
//  Created by Jonathan Kopp on 10/21/20.
//

#import "HomeViewController.h"
#import "ArticleCell.h"
#import "WebViewController.h"
#import <UIKit/UIKit.h>
#import "Network.h"
#import "Article.h"
@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Personal Capital";
    self.view.backgroundColor = UIColor.whiteColor;
}
- (void)viewSafeAreaInsetsDidChange {
    [super viewSafeAreaInsetsDidChange];
    [self setupCollection];
}
/// Update collection view size when orientation of device changes
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context)
     {
        self.collectionView.frame = CGRectMake(0, self.view.safeAreaInsets.top, size.width, size.height - self.view.safeAreaInsets.top);
    } completion:^(id<UIViewControllerTransitionCoordinatorContext> context)
     {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
    }];
    
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
}

/// Fetches articles from our network & refreshes collectionView
- (void)beginRefreshing {
    Network* network = [[Network alloc] init];
    [network getArticles: @"https://www.personalcapital.com/blog/feed/json": ^(Article* result) {
        self.articles = result;
        // Return to main thread to update UI
        dispatch_async(dispatch_get_main_queue(), ^{
            self.title = result.title;
            [self.collectionView reloadData];
            [self.refreshControl endRefreshing];
        });
    }];
}

#pragma mark - CollectionViewFunctions

- (void)setupCollection {
    // Check tag to see if collectionView has loaded
    if (_collectionView.tag == 1) {
        _collectionView.frame = CGRectMake(0, self.view.safeAreaInsets.top, self.view.bounds.size.width, self.view.bounds.size.height - self.view.safeAreaInsets.top);
        [_collectionView reloadData];
        return;
    }
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    
    _collectionView = [[UICollectionView alloc] initWithFrame: CGRectMake(0, self.view.safeAreaInsets.top, self.view.bounds.size.width, self.view.bounds.size.height - self.view.safeAreaInsets.top) collectionViewLayout: layout];
    [_collectionView setDataSource: self];
    [_collectionView setDelegate: self];
    [_collectionView registerClass:[ArticleCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    
    // Add refresh control & collectionView
    _collectionView.backgroundColor = UIColor.whiteColor;
    _refreshControl = [[UIRefreshControl alloc] init];
    _refreshControl.tintColor = [[UIColor colorNamed:@"PCBlue"]init];
    [_refreshControl addTarget:self action:@selector(beginRefreshing) forControlEvents:UIControlEventValueChanged];
    [_collectionView setRefreshControl: _refreshControl];
    [self.view addSubview:_collectionView];
    [_refreshControl beginRefreshing];
    [self beginRefreshing];
    _collectionView.tag = 1;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ArticleCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    [cell resetCell];
    if (_articles.items.count == 0) {
        return cell;
    }
    cell.imgUrl = _articles.items[indexPath.row].featuredImage;
    // Setup for header cell
    if (indexPath.row == 0) {
        cell.isHeader = YES;
        [cell configureCell: _articles.items[indexPath.row].title :_articles.items[indexPath.row].summary];
    } else { // Not header cell
        [cell configureCell: _articles.items[indexPath.row].title :@""];
    }
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.articles.items.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // Present webView
    if (_articles.items.count > 0) {
        WebViewController * vc = [[WebViewController alloc] init];
        vc.articleTitle = _articles.items[indexPath.row].title;
        vc.urlString = _articles.items[indexPath.row].url;
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style: UIBarButtonItemStylePlain target:nil action:nil];
        self.navigationItem.backBarButtonItem.tintColor = [[UIColor colorNamed:@"PCBlue"]init];
        [self.navigationController pushViewController:vc animated: true];
    }
}

#pragma mark - CollectionViewFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = self.view.bounds.size.width;
    CGFloat screenHeight = self.view.bounds.size.height;
    if (indexPath.row == 0) {
        if (width > screenHeight) {
            return CGSizeMake(width, screenHeight * 0.7);
        } else {
            return CGSizeMake(width, screenHeight * 0.5);
        }
    }
    if (UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        return CGSizeMake(width / 3, width / 3);
    }
    if (width > screenHeight) {
        return CGSizeMake(width / 2, screenHeight / 2);
    } else {
        return CGSizeMake(width / 2, width / 2);
    }
}

@end
