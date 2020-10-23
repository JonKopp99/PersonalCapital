//
//  ArticleCell.h
//  PersonalCapital
//
//  Created by Jonathan Kopp on 10/21/20.
//

#import <UIKit/UIKit.h>
#import "Article.h"
@interface ArticleCell: UICollectionViewCell

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *summaryLabel;
@property (strong, nonatomic) UIImageView *imgView;
@property (strong, nonatomic) UIView *backGround;
@property (strong, nonatomic) NSString *imgUrl;
@property BOOL isHeader;
-(void)configureCell: (NSString*)title :(NSString*)summary;
-(void)resetCell;
@end
