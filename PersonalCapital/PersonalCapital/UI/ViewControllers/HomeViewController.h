//
//  HomeViewController.h
//  PersonalCapital
//
//  Created by Jonathan Kopp on 10/21/20.
//

#import <UIKit/UIKit.h>
#import "Article.h"
@interface HomeViewController: UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) Article *articles;
@property (strong, nonatomic) UIRefreshControl *refreshControl;

@end

