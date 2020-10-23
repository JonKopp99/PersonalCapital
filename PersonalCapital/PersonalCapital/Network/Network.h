//
//  Network.h
//  PersonalCapital
//
//  Created by Jonathan Kopp on 10/22/20.
//
#import "Article.h"
@interface Network: NSObject

- (void)getArticles:(NSString*)url :(void (^)(Article*))callback;
@end
