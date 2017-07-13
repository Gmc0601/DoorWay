//
//  NSURL+Category.m
//  BaseProject
//
//  Created by LeoGeng on 07/07/2017.
//  Copyright © 2017 cc. All rights reserved.
//

#import "NSURL+Category.h"

@implementation NSURL(loadImage)
-(void) loadImage:(void(^)(UIImage *)) callBack{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSData *imageData = [NSData dataWithContentsOfURL:self];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // Update the UI
            UIImage *image = [UIImage imageWithData:imageData];
            callBack(image);
        });
    });
}
@end
