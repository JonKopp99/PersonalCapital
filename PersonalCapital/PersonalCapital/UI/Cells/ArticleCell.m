//
//  ArticleCell.m
//  PersonalCapital
//
//  Created by Jonathan Kopp on 10/21/20.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ArticleCell.h"
#import "UIImageViewDownload.h"
@interface ArticleCell ()

@end

@implementation ArticleCell
/// Reset cell before reuse
- (void)resetCell {
    [[self.contentView subviews]
     makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _isHeader = NO;
    _titleLabel.text = nil;
    _summaryLabel.text = nil;
    _imgView.image = nil;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
}
/// Lays out the views for the article
/// @param title article title
/// @param summary artcle summary
- (void)configureCell:(NSString*)title :(NSString*)summary {
    // Background view
    _backGround = [[UIView alloc]init];
    _backGround.backgroundColor = [UIColor whiteColor];
    if (_isHeader) {
        _backGround.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height - 50);
    } else {
        _backGround.layer.cornerRadius = 10;
        _backGround.frame = CGRectMake(5, 5, self.bounds.size.width - 10, self.bounds.size.height - 10);
    }
    [self.contentView addSubview: _backGround];
    // Image View
    _imgView = [[UIImageView alloc]init];
    _imgView.contentMode = UIViewContentModeScaleAspectFill;
    _imgView.layer.cornerRadius = _backGround.layer.cornerRadius;
    _imgView.clipsToBounds = true;
    _imgView.frame = CGRectMake(0, 0, _backGround.frame.size.width, _backGround.frame.size.height);
    [_imgView downloadImage:_imgUrl];
    [_backGround addSubview: _imgView];
    // Summary Label
    _summaryLabel = [[UILabel alloc]init];
    _summaryLabel.font = [UIFont fontWithName:@"Helvetica" size: 17];
    _summaryLabel.numberOfLines = 2;
    _summaryLabel.textColor = [UIColor whiteColor];
    _summaryLabel.textAlignment = NSTextAlignmentLeft;
    _summaryLabel.frame = CGRectMake(_backGround.frame.origin.x + 5, _backGround.frame.size.height - 50, _backGround.frame.size.width - 10, 40);
    [_backGround addSubview: _summaryLabel];
    // Title label for headers
    if (_isHeader) {
        [self addHeaderSplit];
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size: 22];
        _titleLabel.numberOfLines = 1;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.frame = CGRectMake(_backGround.frame.origin.x + 5, _summaryLabel.frame.origin.y - 24, _backGround.frame.size.width - 10, 22);
        [_backGround addSubview: _titleLabel];
        _summaryLabel.text = summary;
        _titleLabel.text = title;
    } else {
        _summaryLabel.text = title;
    }
    [self addGradient];
}
- (void)addGradient {
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = _imgView.bounds;
    gradient.colors = @[(id)[UIColor clearColor].CGColor, (id)[[UIColor blackColor] colorWithAlphaComponent:0.8].CGColor];
    [_imgView.layer insertSublayer:gradient atIndex:0];
}
/// If  header cell add previous article's label
- (void)addHeaderSplit {
     UILabel* prevArticleLabel = [[UILabel alloc]init];
    prevArticleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size: 22];
    prevArticleLabel.numberOfLines = 1;
    prevArticleLabel.textColor = [UIColor blackColor];
    prevArticleLabel.textAlignment = NSTextAlignmentLeft;
    prevArticleLabel.text = @"Previous Articles";
    prevArticleLabel.frame = CGRectMake(5, _backGround.frame.size.height + 25, _backGround.frame.size.width - 10, 25);
    [self.contentView addSubview: prevArticleLabel];
}

@end
