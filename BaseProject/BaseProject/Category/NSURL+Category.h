//
//  NSURL+Category.h
//  BaseProject
//
//  Created by LeoGeng on 07/07/2017.
//  Copyright © 2017 cc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL(loadImage)
-(void) loadImage:(void(^)(UIImage *)) callBack;
@end
