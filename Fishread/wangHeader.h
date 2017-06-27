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
#define sousuolishi @"http://"IPAddress"/forum/circle/searchHistory.html?token=%@"
//搜索 get
#define sousuo @"http://"IPAddress"/forum/circle/searchShow.html?token=%@&page=%@&key=%@"
//删除搜索
#define shanchusosuo @"http://"IPAddress"/forum/circle/delSearchHis.html?token=%@&id=%@"
//全部get
#define quanziquanbu @"http://"IPAddress"/forum/index/index.html?token=%@&page=%@&judge=%@"
//讨论圈详情
#define taolunquanxiangqing @"http://"IPAddress"/forum/circle/circleDetail.html?id=%@&page=%@&token=%@&type=%@"
//书圈详情
#define shuquanxiangqing @"http://"IPAddress"/forum/circle/bookCriclDetail.html?id=%@&page=%@&token=%@&type=%@"
//动态详情页面
#define dongtaixiangqing @"http://"IPAddress"/forum/index/detail.html?token=%@&page=%@&id=%@"
//成员管理
#define chengyuanguanli @"http://"IPAddress"/forum/circle/circleManageShow.html?token=%@&id=%@"
//关于我的
#define guanyuwode @"http://"IPAddress"/forum/user/aboutus.html"
//我的界面首页
#define wodeshouye @"http://"IPAddress"/forum/user/index.html?token=%@"
//头像修改 post
#define touxiangxiugai @"http://"IPAddress"/forum/user/userIcon.html"
//昵称修改 get
#define nichengxiugai @"http://"IPAddress"/forum/user/editNickname.html?token=%@&nickname=%@"
//创建圈子 post
#define chuangjianquqnzi @"http://"IPAddress"/forum/circle/createCircle.html"
//返回圈子前页 get
#define fanhuiquanziquanye @"http://"IPAddress"/forum/circle/updataQuitTime.html?token=%@&post_id=%@&"
//意见反馈 post
#define yijianfankui @"http://"IPAddress"/forum/user/opinionFeedback.html"
//常见问题
#define changjianwenti @"http://"IPAddress"/forum/user/commonQuestion.html"
//收藏或取消收藏 get
#define shoucang @"http://"IPAddress"/forum/index/addCollect.html?token=%@&post_id=%@&type=%@&status=%@"
//点赞 get
#define dianzan @"http://"IPAddress"/forum/index/doBookmark.html?token=%@&object_id=%@&type=%@"
//举报 get
#define jubao @"http://"IPAddress"/forum/index/accuse.html?token=%@&to_uid=%@&object_id=%@&object_type=%@&type=%@"
//评论回复 post
#define pinglun @"http://"IPAddress"/forum/index/postComment.html"
//我的收藏
#define wodeshoucang @"http://"IPAddress"/forum/user/myCollect.html?token=%@&page=%@"
//消息通知
#define xiaoxitongzhi @"http://"IPAddress"/forum/user/messageInform.html?token=%@&type=%@&page=%@"
//系统消息 get
#define xitongxiaoxi @"http://"IPAddress"/forum/user/systemInform.html?token=%@&page=%@"
//删除消息 get
#define shanchuxiaoxi2 @"http://www.3a406.cn/forum/user/removeInform.html?token=%@&type=%@&id=%@"
//发帖 post
#define fatie @"http://www.3a406.cn/forum/index/publishPost.html"
//看完返回
#define kanwanfanhui @"http://"IPAddress"/forum/user/returnMsg.html?token=%@&id=%@"
//我的发表
#define wodefabiao @"http://"IPAddress"/forum/user/mytrends.html?token=%@&page=%@&uid=%@"
//查看圈子资料
#define chakanquqnizilian @"http://"IPAddress"/forum/circle/circleData.html?token=%@&id=%@&type=%@"
//圈子成员删除 post
#define quanzichengyuanshanchu @"http://"IPAddress"/forum/circle/circleManageDel.html"
//删除帖子
#define shanchutiezi @"http://"IPAddress"/forum/index/postDelete.html?token=%@&id=%@"
//退出圈子时间 get
#define tuichuquanzishijian @"http://www.3a406.cn/forum/circle/updataQuitTime.html?token=%@&post_id=%@"
//底部菜单栏可见
#define dibucaidanlankejian @"http://www.3a406.cn/forum/circle/begin.html?token=%@"


// 屏幕宽度 高度 (注意，启动的时候窗口的创建不能用这个宏，6plus横屏启动会出错)
#define SCREENWIDTH (MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height))
#define SCREENHEIGHT (MAX([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height))

#endif /* wangHeader_h */
