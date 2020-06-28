//
//  LoganServer.swift
//  Hephaestus
//
//  Created by 洪利 on 2020/6/16.
//  Copyright © 2020 Tyrant. All rights reserved.
//

import Foundation
import Logan
public class LoganServer {
    ///日志筛选等级, 默认不筛选,全量上传
    public static var logLevelLimit : UInt = 0
    ///日志上传地址
    public static var loganUploadUrl : String = "http://192.168.1.189:9999/logan/upload.json"
    
    
    /// 启动日志服务
    /// - Parameters:
    ///   - keyData: key
    ///   - ivData: iv
    ///   - fileMax: 设置最大存储量, 达到阈值后不再存储, 默认100MB
    ///   - maxReversedDate: 日志有效期,默认1天
    ///   - ifNeedPrint: 是否需要在控制台实时输出日志内容, 默认false
    public static func startLogan(_ keyData: String = "0123456789012345", _ ivData:String = "0123456789012345", _ fileMax:uint_fast64_t = 100 * 1024 * 1024, _ maxReversedDate: Int32 = 1, _ ifNeedPrint: Bool = false){
         let keyData = keyData.data(using: .utf8)
         let ivData = ivData.data(using: .utf8)

        loganInit(keyData!, ivData!, fileMax)
        loganSetMaxReversedDate(maxReversedDate)
        loganUseASL(ifNeedPrint)
        
    }
    public static func uploadAllLog(date: String, appId: String, unionId: String, device: String, complete:((_ state:Bool)->())?){
        loganUpload(loganUploadUrl, date, appId, unionId, device) { (data, resp, error) in
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
    public var logLevel : UInt = 1
    public var label = ""
}
extension ILOGAN where Base ==  ilogViewModel{
    /// 写入日志
    public func write() {
        if base.logLevel > LoganServer.logLevelLimit {
            /// 可以写入
            logan(base.logLevel, base.label)
        }
    }
}
/// iLog 模型转换协议
public protocol ILogServer {
//    func makeLabel()->ilogViewModel
    var iLogVM : ilogViewModel { get }
}



