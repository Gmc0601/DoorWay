//
//  CCUrl.h
//  CarSticker
//
//  Created by cc on 2017/3/21.
//  Copyright © 2017年 cc. All rights reserved.
//

#ifndef CCUrl_h
#define CCUrl_h
/*
 接口文档
 */
#define TokenKey @"1e56c95504a9a846e4c7043704a20f25"

#define UserToeknAndLogin  0

#define UDID     0

/*****************************测试开关*******************************/

#define HHTest   1      // 1 测试  0 上传

/*****************************测试开关*******************************/

#if HHTest

#define    BaseApi       @"http://139.224.70.219:88/index.php"

#else

#define    BaseApi      @"正式地址"

#endif

#pragma mark - 接口地址 -

#define LoginURL @"_login_001"


#define RegisteCode @"_sms_002"


/*
 *   User Info
 */

#define IsLogin @"islogin"

#define UserToken @"userTOken"


#endif /* CCUrl_h */
