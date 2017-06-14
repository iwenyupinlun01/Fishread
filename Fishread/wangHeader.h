//
//  wangHeader.h
//  Fishread
//
//  Created by 王俊钢 on 2017/6/8.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#ifndef wangHeader_h
#define wangHeader_h

#define WXPatient_App_ID                 @"wx645768d32ba61b12" //您的帐号id信息
#define WXPatient_App_Secret             @"ea33f7c6f5950ee293ab37785e2d6997" //您的帐号secret信息
#define WX_BASE_URL                      @"https://api.weixin.qq.com/sns"
#define WX_ACCESS_TOKEN                  @"access_token"
#define WX_OPEN_ID                       @"openid"
#define WX_REFRESH_TOKEN                 @"refresh_token"
#define WX_SCOPE                         @"snsapi_userinfo"
#define WX_STATE                         @"APP"

#define WXLoginSuccess                   @"WXLoginSuccess"

#define IPAddress @"www.3a406.cn"

//登陆
#define denglu @"http://"IPAddress"/ucenter/member/login.html"
//首页 get
#define shouye @"http://"IPAddress"/forum/index/indexCircle.html?page=%@&token=%@"
//退出登陆 get
#define tuichudenglu @"http://"IPAddress"/forum/user/loginout.html?token=%@"
//圈子之我的 get
#define quanziwode @"http://"IPAddress"/forum/circle/index.html?token=%@"
//圈子类目展示
#define quanzileimu @"http://"IPAddress"/forum/circle/circleType.html?token=%@"
//搜索历史
#define sousuolishi @"http://"IPAddress"/forum/circle/searchHistory.html?token=%@&page=%@"
//搜索 get
#define sousuo @"http://"IPAddress"/forum/circle/searchShow.html?token=%@&page=%@&key=%@"
//删除搜索
#define shanchusosuo @"http://"IPAddress"/circle/delSearchHis.html?token=%@&id=%@"

//全部get
#define quanziquanbu @"http://"IPAddress"/forum/index/index.html?token=%@&page=%@&judge=%@"

#endif /* wangHeader_h */
