//
//  ILog.swift
//  Hephaestus
//
//  Created by 洪利 on 2020/6/16.
//  Copyright © 2020 Tyrant. All rights reserved.
//

import Foundation
//import Logan

public protocol BasicConfig {
    var url: String { get }
    
    var logInConsole: Bool { get }
    
    var level: LocalLogType { get set  }
}

protocol Logging {
    
    @discardableResult
    func write(level: UInt, info: String) -> Bool
    
    func uploadAllLog(complete:((_ state: Bool) -> Void)? )
}

public class ILog {
    public static let `default` = ILog()
    
    private var config: BasicConfig = LogonConfig.default
    
    ///日志筛选等级, 默认不筛选,全量上传
    fileprivate var logLevelLimit: LocalLogType = .lower
    
    public static func start (data: LogonConfig) {
        
        ILog.default.config = data
        
        ILog.default.log = LogonServer(config: data)
        
        UncaughtException.sentry()
    }
    
    public func iLogLimit(level: LocalLogType) {
        var c = config
        c.level = level
        config = c
    }
    
    static func underLevel(level: LocalLogType) -> Bool {
        return level.rawValue >= ILog.default.config.level.rawValue
    }
    
    fileprivate var log: Logging?

    ///上传日志
    public static func uploadAllLog(complete:((_ state: Bool) -> Void )? ) {
        ILog.default.log?.uploadAllLog(complete: complete)
    }
    
    public static func write(_ level: UInt, _ info: String) {
        ILog.default.log?.write(level: level, info: info)
    }
    
    public static func write <T: ILogServer>(_ info: T) {
        let actionAndResult = "(\(info.messionName), \(info.result.description))"
        let label = "【\(info.moduleName)】" + "\t" + "【\(info.userTag)】" + "\t" + actionAndResult + "{\(info.detail)}" + "\t"
        if underLevel(level: info.logLevel) {
            ILog.write(info.logLevel.rawValue, label)
        } else {
            print("当前日志收集最低级别为: \(ILog.default.config.level.rawValue), 此日志被丢弃 : \(label)")
        }
    }
}
///日志等级
/*
 1->lower: (页面展示, 交互点击事件)
 2->normal:(接口调用, Mpush推送)
 3->important: (异常处理, 如订单过滤, 支付方式过滤, 关键字段为空, 解析错误)
 4->error: (其他重要级别)
 */
public enum LocalLogType: UInt {
    case lower = 1, normal, important, error
}

/// iLog 模型转换协议
public protocol ILogServer {

    ///模块名称  如 : 登录模块
    var moduleName: String { get set }
    ///业务点名称 如: 账号密码登录
    var messionName: String { get set }
    ///用户标识, 例: 手机号, userID等
    var userTag: String { get }
    ///操作结果
    var result: iLogMessionResult { get set }
    ///详情信息
    var detail: String { get set }
    ///日志等级
    var logLevel: LocalLogType { get set }
    
}
///操作结果枚举
public enum iLogMessionResult {
    case success
    case fail(String)
    var description: String {
        switch self {
        case .success: return "操作成功"
        case .fail(let reason): return "操作失败, 原因:\(reason)"
        }
    }
}
