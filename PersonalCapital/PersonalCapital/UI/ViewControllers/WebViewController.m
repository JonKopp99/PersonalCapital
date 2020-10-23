//
//  WebViewController.m
//  PersonalCapital
//
//  Created by Jonathan Kopp on 10/21/20.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WebViewController.h"
@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = _articleTitle;
    self.view.backgroundColor = UIColor.whiteColor;
}
- (void)viewSafeAreaInsetsDidChange {
    [super viewSafeAreaInsetsDidChange];
    [self setupWebView];
}

/// Update webView size when orientation of device changes
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context)
     {
        self.webView.frame = CGRectMake(0, self.view.safeAreaInsets.top, size.width, size.height - self.view.safeAreaInsets.top);
    } completion:^(id<UIViewControllerTransitionCoordinatorContext> context)
     {
        // Do Nothing
    }];
    
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
}

/// Inits webview using the urlString passed into the view controller
- (void)setupWebView {
    // Check tag to see if we have already initialized webview
    if (_webView.tag != 1) {
        _webView = [[WKWebView alloc] init];
        _webView.frame = CGRectMake(0, self.view.safeAreaInsets.top, self.view.bounds.size.width, self.view.bounds.size.height - self.view.safeAreaInsets.top);
        [_webView setNavigationDelegate: self];
        // Start URLRequest
        NSURL *url = [[NSURL alloc] initWithString:_urlString];
        NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url];
        [self startLoading];
        [_webView loadRequest: urlRequest];
        [self.view addSubview: _webView];
        _webView.tag = 1;
    } else {
        _webView.frame = CGRectMake(0, self.view.safeAreaInsets.top, self.view.bounds.size.width, self.view.bounds.size.height - self.view.safeAreaInsets.top);
    }
}

- (void)startLoading {
    _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleGray];
    _activityIndicator.tintColor = [[UIColor colorNamed:@"PCBlue"]init];
    UIBarButtonItem * barButton = [[UIBarButtonItem alloc] initWithCustomView: _activityIndicator];
    [self navigationItem].rightBarButtonItem = barButton;
    [_activityIndicator startAnimating];
}
- (void)endLoading {
    [self navigationItem].rightBarButtonItem = nil;
    [_activityIndicator startAnimating];
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"Did complete navigation");
    [self endLoading];
}

@end
