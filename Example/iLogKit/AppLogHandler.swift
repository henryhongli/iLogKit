//
//  LogVM.swift
//  iLogKit_Example
//
//  Created by 洪利 on 2020/6/28.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import iLogKit

/*
 功能模块（具体业务）

 1.登录模块（找回密码,登录）
 
 */

enum AppModules : String {
    case login = "登录模块"
}
/// ------   登录模块 业务点
enum messionOfLogin : String{
    ///important
    case normaLogin =  "账号密码登录"
    case forgotPW = "找回密码"
    var level : UInt{
        switch self {
        case .normaLogin: return LocalLogType.normal.rawValue
        case .forgotPW: return  LocalLogType.normal.rawValue
        }
    }
}


///--------------- 定义基类模型
/// Base
class iLogbaseModule {
    ///模块名称
    var moduleName = AppModules.login
    ///业务点名称
    var messionName = ""
    ///用户标识
    var userTag = ""
    ///操作结果
    var result = iLogMessionResult.success
    ///详情信息
    var detail = ""
    ///日志等级
    var logLevel : UInt = 0
    ///操作结果枚举
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

///--------------- 实现转义
extension iLogbaseModule : ILogServer{
   
    ///协议属性, 转换日志VM
    var iLogVM: ilogViewModel{
        let vm = ilogViewModel()
        /// 日志级别
        vm.logLevel = self.logLevel
        /// 日志内容
        vm.label = logContent()
        return vm
    }
    
    
    ///记录日志
    public func writeLog() {
        self.iLogVM.iLog.write()
    }
    /// 拼接日志内容, 可自定义
    /// "【模块名称】" + "\t" + "【用户身份标识】" + "\t" + "(业务标识,操作结果 + "失败的原因" + "\t" + " 详情信息,成功可打印重要数据(接口返回), 失败时可打印重要参数如接口请求参数"
    ///【登录模块】            【+8618618379342】          (账号密码登录 , 操作成功)        {phone:18618379342,password:ewrtgfdsasdf123}
    ///【登录模块】            【+8618618379342】          (账号密码登录 , 操作失败,原因:账号密码错误)        {phone:18618379342,password:ewrtgfdsasdf123}
    ///【我的账户模块】            【uid:12345】          (获取订单记录 , 操作成功,)        {"\(network respond info)"}
    ///【我的账户模块】            【uid:12345】          (获取账户余额 , 操作失败,原因:"\(network error)")        {date: 2020-06-28}
    public func logContent() -> String {
        let actionAndResult = "(\(self.messionName), \(self.result.description))"
        if self.userTag.isEmpty == true {
            self.userTag = takeUid()
        }
        let label = "【\(self.moduleName)】" + "\t" + "【\(self.userTag)】" + "\t" + actionAndResult + "{\(self.detail)}" + "\t"
        return label
    }
    /// 获取用户ID, 根据App自身情况自由处理
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









