//
//  WebViewController.h
//  PersonalCapital
//
//  Created by Jonathan Kopp on 10/21/20.
//
#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
@interface WebViewController: UIViewController <WKNavigationDelegate>

@property (strong, nonatomic) WKWebView *webView;
@property (strong, nonatomic) NSString *urlString;
@property (strong, nonatomic) NSString *articleTitle;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;
@end
