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
@property(assign,nonatomic) int loadTime;
@end

@implementation WebViewTableViewCell
-(NSString *) url{
    return self.url;
}

-(void) setUrl:(NSString *)url{
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
    
    NSURL *URL1 = [NSURL URLWithString:@"about:blank"];
    NSMutableURLRequest *requeset1 = [[NSMutableURLRequest alloc] initWithURL:URL1 cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:3.0];
    [_webView loadRequest:requeset1];
    
    NSURL *URL = [NSURL URLWithString:strUrl];
    NSMutableURLRequest *requeset = [[NSMutableURLRequest alloc] initWithURL:URL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:3.0];
    [_webView loadRequest:requeset];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView{
    _loadTime += 1;
    
    
    @try {
        if ([self.delegate respondsToSelector:@selector(WebViewTableViewCell:heightOfCell:)]) {
            CGFloat height = _loadTime > 1 ? webView.scrollView.contentSize.height : 0;
            [self.delegate WebViewTableViewCell:self heightOfCell: height];
            _loadTime = _loadTime > 1?0:_loadTime;
        }
    } @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
    
}

@end
