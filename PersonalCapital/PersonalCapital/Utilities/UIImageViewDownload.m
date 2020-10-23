//
//  UIImageViewDownload.m
//  PersonalCapital
//
//  Created by Jonathan Kopp on 10/22/20.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@implementation UIImageView (UIImageViewDownload)
/// Downloads an image from given url
/// @param url  location of the image to download
  - (void)downloadImage:(NSString *)url {
      // Add acitivty indicator
      UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleWhiteLarge];
      activityIndicator.frame = self.frame;
      [self addSubview: activityIndicator];
      [activityIndicator startAnimating];
      // Create url get request
      NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
      [request setHTTPMethod:@"GET"];
      [request setURL:[NSURL URLWithString: url]];
      [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:
        ^(NSData * _Nullable data,
          NSURLResponse * _Nullable response,
          NSError * _Nullable error) {
          if (data != nil) {
              // Return to main thread to set image and stop activity indicator
              dispatch_async(dispatch_get_main_queue(), ^{
                  self.image = [UIImage imageWithData:data];
                  [activityIndicator stopAnimating];
                  [activityIndicator removeFromSuperview];
              });
          }
      }] resume];
  }
@end
