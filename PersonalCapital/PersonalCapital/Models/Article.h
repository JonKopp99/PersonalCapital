//
//  Article.h
//  PersonalCapital
//
//  Created by Jonathan Kopp on 10/22/20.
//

#import <Foundation/Foundation.h>

@class Article;
@class Item;

NS_ASSUME_NONNULL_BEGIN
/// Contains items and a title for the articles
@interface Article : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSArray<Item *> *items;
+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;

@end
/// Article Item
@interface Item : NSObject

@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *featuredImage;
@property (nonatomic, copy) NSString *summary;
@property (nonatomic, copy) NSString *datePublished;

@end

NS_ASSUME_NONNULL_END
