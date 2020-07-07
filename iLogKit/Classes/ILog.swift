//
//  ILog.swift
//  Hephaestus
//
//  Created by 洪利 on 2020/6/16.
//  Copyright © 2020 Tyrant. All rights reserved.
//

import Foundation
import Logan

public class ILog {
    
    ///日志筛选等级, 默认不筛选,全量上传
    fileprivate static var logLevelLimit : LocalLogType = .lower
    ///日志上传地址
    private static var loganUploadUrl : String = "http://192.168.1.189:9999/logan/upload.json"
    
    /// 启动日志服务
    /// - Parameters:
    ///   - keyData: key
    ///   - ivData: iv
    ///   - uploadUrl: 上传地址
    ///   - ifNeedPrint: 是否需要在控制台实时输出日志内容, 默认false
    public static func startLogan(_ data: [String:String]){
        let keyData = data["keyData"]!.data(using: .utf8)
        let ivData = data["ivData"]!.data(using: .utf8)

        self.loganUploadUrl = data["uploadUrl"]!
        ///最大存储量
        let fileMax: uint_fast64_t = 100 * 1024 * 1024
        //日志有效期,1天
        let maxReversedDate: Int32 = 1
        loganInit(keyData!, ivData!, fileMax)
        loganSetMaxReversedDate(maxReversedDate)
        loganUseASL(true)
    }

    ///上传日志
    public static func uploadAllLog(complete:((_ state:Bool)->())?){
        
        if let info = Bundle.main.infoDictionary {
            // 获取App的名称
            let appId : String = info["CFBundleName"] as! String
            let sysName = UIDevice.current.systemName //获取系统名称 例如：iPhone OS
            let sysVersion = UIDevice.current.systemVersion //获取系统版本 例如：9.2
            // 设备名称以及系统
            let device = sysName + sysVersion
            let deviceUUID = UIDevice.current.identifierForVendor?.uuid  //获取设备唯一标识符 例如：FBF2306E-A0D8-4F4B-BDED-9333B627D3E6
            ///设备唯一标识
            let unionIdStr = deviceUUID.debugDescription
            ///日志时间
            let now = Date()
            let df = DateFormatter()
            df.dateFormat = "yyyy-MM-dd"
            let date = df.string(from: now)
            loganUpload(loganUploadUrl, date, appId, unionIdStr, device) { (data, resp, error) in
                if error != nil{
                    print("upload error")
                    print(error ?? "unknow error of upload log")
                    complete?(false)
                }else{
                    ///上传成功
                    if let res = resp {
                        print("upload succeed")
                        print(res)
                    }
                    complete?(false)
                    ///上传成功清空所有日志
                    loganClearAllLogs()
                }
            }
        }else{
            complete?(false)
            print("获取本地InfoPlist文件失败")
        }
        
        
    }
    
    /// 设置日志收集等级, 0 全量收集, 1 只收集除 lower之外更高级的, 4 或大于4 的值, 不收集
    public static func iLogLimit(_ type: LocalLogType){
        self.logLevelLimit = type
    }
    /// 设置是否需要在控制台打印日志
    public static func ifNeedPrint(_ ifNeed: Bool){
        loganUseASL(ifNeed)
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


//MARK- 命名空间声明
public protocol ILoganProvider{}


public struct ILOGAN<Base>{
    public let base : Base
    fileprivate init (_ base: Base){
        self.base = base
    }
}


extension ILoganProvider{
    public var iLog: ILOGAN<Self>{
        return ILOGAN(self)
    }
    public static var iLog: ILOGAN<Self>.Type{
        return ILOGAN<Self>.self
    }
}
extension ilogViewModel: ILoganProvider{}

    

/// iLog 模型
open class ilogViewModel:NSObject {
    public var logLevel : LocalLogType
    public var label = ""
    public init(level: LocalLogType, content: String = "") {
        self.logLevel = level
        self.label = content
    }
}
extension ILOGAN where Base ==  ilogViewModel{
    /// 写入日志
    public func write() {
        if base.logLevel.rawValue >= ILog.logLevelLimit.rawValue {
            /// 可以写入
            logan(base.logLevel.rawValue, base.label)
        }
    }
}
/// iLog 模型转换协议
public protocol ILogServer {
//    func makeLabel()->ilogViewModel
    var iLogVM : ilogViewModel { get }
}
///--------------- 定义基类模型
/// Base
open class iLogbaseModule {
    ///模块名称  如 : 登录模块
    public var moduleName = ""
    ///业务点名称 如: 账号密码登录
    public var messionName = ""
    ///用户标识, 例: 手机号, userID等
    public var userTag = ""
    ///操作结果
    public var result = iLogMessionResult.success
    ///详情信息
    public var detail = ""
    ///日志等级
    public var logLevel : LocalLogType = .lower
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
public struct BaseModel{
    ///模块名称  如 : 登录模块
    public var moduleName = ""
    ///业务点名称 如: 账号密码登录
    public var messionName = ""
    ///用户标识, 例: 手机号, userID等
    public var userTag = ""
    ///操作结果
    public var result = iLogMessionResult.success
    ///详情信息
    public var detail = ""
    ///日志等级
    public var logLevel : LocalLogType = .lower
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
    public init(moduleName: String, messionName: String, userTag: String, result: iLogMessionResult, detail: String, logLevel: LocalLogType){
        self.moduleName = moduleName
        self.messionName = messionName
        self.userTag = userTag
        self.result = result
        self.detail = detail
        self.logLevel = logLevel
    }
}
extension BaseModel: ILogServer{
    public var iLogVM: ilogViewModel {
        let vm = ilogViewModel(level: self.logLevel, content: logContent())
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
        let label = "【\(self.moduleName)】" + "\t" + "【\(self.userTag)】" + "\t" + actionAndResult + "{\(self.detail)}" + "\t"
        return label
    }
    
}

///--------------- 实现转义
extension iLogbaseModule : ILogServer{
   
    ///协议属性, 转换日志VM
    public var iLogVM: ilogViewModel{
        let vm = ilogViewModel(level: self.logLevel, content: logContent())
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
        let label = "【\(self.moduleName)】" + "\t" + "【\(self.userTag)】" + "\t" + actionAndResult + "{\(self.detail)}" + "\t"
        return label
    }
}


