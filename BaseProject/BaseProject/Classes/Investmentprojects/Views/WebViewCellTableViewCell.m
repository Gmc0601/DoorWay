//
//  WebViewCellTableViewCell.m
//  BaseProject
//
//  Created by LeoGeng on 29/06/2017.
//  Copyright © 2017 cc. All rights reserved.
//

#import "WebViewCellTableViewCell.h"
#import <Masonry/Masonry.h>

@implementation WebViewCellTableViewCell
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
    UIWebView *_webView = [[UIWebView alloc] init];
    _webView.delegate = self;
    _webView.scrollView.bounces = NO;
    
    [self addSubview:_webView];
    
    NSURL *URL = [NSURL URLWithString:strUrl];
    NSMutableURLRequest *requeset = [[NSMutableURLRequest alloc] initWithURL:URL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:3.0];
    
    [_webView loadRequest:requeset];
    
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.top.equalTo(self.mas_top);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
    }];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    if ([self.delegate respondsToSelector:@selector(WebViewCellTableViewCell:heightOfCell:)]) {
        [self.delegate WebViewCellTableViewCell:self heightOfCell: webView.scrollView.contentSize.height];
    }
}

@end
