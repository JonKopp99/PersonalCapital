//
//  Network.m
//  PersonalCapital
//
//  Created by Jonathan Kopp on 10/22/20.
//

#import <Foundation/Foundation.h>
#import "Network.h"
#import "Article.h"
@implementation Network

/// Fetches artles at a given url
/// @param url location to fetch from
/// @param callback returns articles fetched from locaton
- (void)getArticles:(NSString*)url :(void(^)(Article* result))callback {
    // Create url request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString: url]];
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:
      ^(NSData * _Nullable data,
        NSURLResponse * _Nullable response,
        NSError * _Nullable error) {
        // Decode data into Article model
        NSString* dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        Article *article = [Article fromJSON:dataString encoding: NSUTF8StringEncoding error:&error];
        // Callback with article
        callback(article);
    }] resume];
}

@end
