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
/// 登录模块VM
//struct  iLog_loginVM: BaseModel {
//    static func new(_ mession: messionOfLogin, _ detail: String = "", _ tag: String = "")->iLog_loginVM{
//        let vm = iLog_loginVM()
//        vm.moduleName = .login
//        vm.messionName = mession.rawValue
//        vm.logLevel = LocalLogType(rawValue: mession.level) ?? .lower
//        vm.userTag = tag
//        vm.detail = detail
//        return vm
//    }
//}



///// 登录模块VM
//class iLog_loginVM: iLogbaseModule {
//    static func new(_ mession: messionOfLogin, _ detail: String = "", _ tag: String = "")->iLog_loginVM{
//        let vm = iLog_loginVM()
//        vm.moduleName = .login
//        vm.messionName = mession.rawValue
//        vm.logLevel = LocalLogType(rawValue: mession.level) ?? .lower
//        vm.userTag = tag
//        vm.detail = detail
//        return vm
//    }
//}









