//
//  WebViewTableViewCell.m
//  BaseProject
//
//  Created by LeoGeng on 29/06/2017.
//  Copyright © 2017 cc. All rights reserved.
//

#import "WebViewTableViewCell.h"
#import <Masonry/Masonry.h>

@interface WebViewTableViewCell()
@property(retain,atomic) UIWebView *webView;
@property(assign,atomic) int loadTime;
@end

@implementation WebViewTableViewCell
@synthesize url = _url;

-(void) setUrl:(NSString *)url{
    _url = url;
    [self loadWebView:url];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    
    return self;
}

-(void) loadWebView:(NSString *) strUrl{
    if (_webView == nil) {
        _webView = [[UIWebView alloc] init];
        _webView.delegate = self;
        _webView.scrollView.bounces = NO;
        
        [self addSubview:_webView];
        
        [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left);
            make.top.equalTo(self.mas_top);
            make.right.equalTo(self.mas_right);
            make.bottom.equalTo(self.mas_bottom);
        }];
    }
    [_webView loadHTMLString:@"." baseURL:nil];

//    _webView.attributedText = [self getAttributedString:strUrl];
//    NSURL *URL1 = [NSURL URLWithString:@"about:blank"];
//    NSMutableURLRequest *requeset1 = [[NSMutableURLRequest alloc] initWithURL:URL1 cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:3.0];
//
//    NSURL *URL = [NSURL URLWithString:strUrl];
//    NSMutableURLRequest *requeset = [[NSMutableURLRequest alloc] initWithURL:URL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:3.0];
//    [_webView loadRequest:requeset];
}

- (NSAttributedString *)getAttributedString:(NSString *)text {
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[text dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    return attributedString;
}


- (void)webViewDidFinishLoad:(UIWebView *)webView{
    @synchronized (self) {
        _loadTime += 1;
        @try {
            if ([self.delegate respondsToSelector:@selector(WebViewTableViewCell:heightOfCell:)]) {
                CGFloat height = _loadTime == 1? 0:webView.scrollView.contentSize.height ;
                [self.delegate WebViewTableViewCell:self heightOfCell: height];
//                _loadTime = _loadTime > 1?0:_loadTime;
                if (_loadTime < 2) {
                    [_webView loadHTMLString:_url baseURL:nil];
                }else{
                    _loadTime = 0;
                }
            }
        } @catch (NSException *exception) {
            NSLog(@"%@",exception);
        }
    }
    
}

@end
