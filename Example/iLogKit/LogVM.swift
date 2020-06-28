//
//  LogVM.swift
//  iLogKit_Example
//
//  Created by 洪利 on 2020/6/28.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import iLogKit

/// Base
class iLogbaseModule {
    var moduleName = AppModules.none
    var messionName = ""
    var userTag = ""
    var result = iLogMessionResult.success
    var reason = ""
    var detail = ""
    var logLevel : UInt = 0
    public enum iLogMessionResult {
        case success
        case fail(String)
        var description : String{
            switch self {
            case .success: return "操作成功"
            case .fail(let reason): return "操作失败, 原因:\(reason)"
            }
        }
    }
}


/// 实现转义
extension iLogbaseModule : ILogServer{
   
    
    var iLogVM: ilogViewModel{
        let vm = ilogViewModel()
        vm.logLevel = self.logLevel
        vm.label = logContent()
        return vm
    }
    
    
    public func writeLog() {
        self.iLogVM.iLog.write()
        print("log droped : \(self.logContent())")
    }
    /// 拼接日志内容
    public func logContent() -> String {
        let actionAndResult = "(\(self.messionName), \(self.result.description))"
        if self.userTag.isEmpty == true {
            self.userTag = takeUid()
        }
        let label = "【\(self.moduleName)】" + "\t" + "【\(self.userTag)】" + "\t" + actionAndResult + "{\(self.detail)}" + "\t"
        return label
    }
    /// 获取商户ID
    func takeUid() -> String{
        return "aa1861813"
    }
}


/// 登录模块VM
class iLog_loginVM: iLogbaseModule {
    static func new(_ mession: messionOfLogin, _ detail: String = "", _ tag: String = "")->iLog_loginVM{
        let vm = iLog_loginVM()
        vm.moduleName = .login
        vm.messionName = mession.rawValue
        vm.logLevel = mession.level
        vm.userTag = tag
        vm.detail = detail
        return vm
    }
}

/// ------   账户模块
class iLog_accountVM :iLogbaseModule {
    static func new(_ mession: messionOfAccount, _ detail: String = "", _ tag: String = "")->iLog_accountVM{
        let vm = iLog_accountVM()
        vm.moduleName = .account
        vm.messionName = mession.rawValue
        vm.logLevel = mession.level
        vm.userTag = tag
        vm.detail = detail
        return vm
    }
}

/// 日志收集管理 本地设置
let iLogReciveTypeKey = "iLogReciveType"


///日志收集管理
enum iLogReciveType {
    case noNeed
    case importantInfo
    case all
    
    var description : String{
        switch self {
        case .noNeed: return "无情拒绝"
        case .importantInfo: return "只给你看重要的"
        case .all: return "都给你吧"
        }
    }
}


    /*
     功能模块（具体业务）

     1.登录模块（找回密码，切换线路，生物识别，快捷登录）
     2.账户模块（收款管理,银行卡管理,下单详情（商家一键买卖币））
     3.我的团队（团队转账,领取佣金）
     4.设置模块（线路切换,修改密码,实名认证 -> 获取业务结果的请求,绑定邮箱 -> 获取业务结果的请求,退出登录）
     5.抢单接单 (开始接单/停止接单,设置收款码,订单拉取,抢单（买/卖币订单  成功移除/失败移除/失败不移除）,买卖币开关,接单详情（抢单）,进行中订单,定时回传)
     6.抢单风控 (获取基本配置,高频抢单,久不接单,订单过滤（一分钟内曾经取消展示顶订单）,订单取消展示)
     7.推送模块 (收到源数据,消息解析,解析异常,发送消息（那种消息 消息类型）,连接状态)
     8.验证码模块 (getauthen接口, send接口)
     
     */

enum AppModules : String {
    case none = "未声明模块"
    case login = "登录模块"
    case account = "【账户模块】"
}


/// ------   登录模块 业务点
enum messionOfLogin : String{
    ///important
    case normaLogin =  "账号密码登录"
    case bioLogin = "生物识别登录"
    case noVerifyLogin = "快捷登录"
    case goLogin = "发起登录"
    case forgotPW = "找回密码"
    var level : UInt{
        switch self {
        case .normaLogin: return LocalLogType.normal.rawValue
        case .bioLogin: return LocalLogType.normal.rawValue
        case .noVerifyLogin: return LocalLogType.normal.rawValue
        case .goLogin: return LocalLogType.normal.rawValue
        case .forgotPW: return  LocalLogType.normal.rawValue
        }
    }
}


/// ------   账户模块 业务点
enum messionOfAccount :String {
    case buy_bankCard = "银行卡充值"
    case buy_preferential = "限时优惠充值"
    case buy_digc = "数字货币充值"
    case sell = "卖币"
    case fee = "银行卡充值费率"
    case feePreferential = "限时优惠充值费率"
    case paymentManager = "收款管理"
    case addPayWay = "添加"
    case rule = "支付宝群收款规则说明"
    case quotaMoney = "码金额获取"
    case needVerify = "验证方式获取"
    case orderCheck = "查看订单详情"
    var level : UInt{
        switch self {
        case .buy_bankCard: return LocalLogType.normal.rawValue
        case .buy_preferential: return LocalLogType.normal.rawValue
        case .buy_digc: return LocalLogType.normal.rawValue
        case .sell: return LocalLogType.normal.rawValue
        case .fee: return LocalLogType.normal.rawValue
        case .feePreferential: return LocalLogType.normal.rawValue
        case .paymentManager: return LocalLogType.normal.rawValue
        case .addPayWay: return LocalLogType.normal.rawValue
        case .rule: return LocalLogType.normal.rawValue
        case .quotaMoney: return LocalLogType.normal.rawValue
        case .needVerify: return LocalLogType.normal.rawValue
        case .orderCheck: return LocalLogType.normal.rawValue
        
        }
    }
}

class iLog {
    private func takeUid() -> String{
        
        return "123456"
    }
    var type : iLogReciveType {
        let result1 = UserDefaults.standard.string(forKey: iLogReciveTypeKey) ?? iLogReciveType.all.description
        if result1 == iLogReciveType.all.description {
            return .all
        }
        if result1 == iLogReciveType.importantInfo.description {
            return .importantInfo
        }
        return .noNeed
    }
    static let `default` = iLog()
    
    
    
}



