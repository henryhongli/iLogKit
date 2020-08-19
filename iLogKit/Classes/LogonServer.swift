//
//  LogonServer.swift
//  iLogKit
//
//  Created by Tyrant on 2020/8/18.
//

import Foundation
import Logan


public struct LogonConfig: BasicConfig {
    
    public var level: LocalLogType
    
    public var logInConsole: Bool
    
    public var url: String
    
    public var keyData: Data
    
    public var ivData: Data
    
    static var `default`: BasicConfig {
        return LogonConfig(level: .lower,
                           logInConsole: true,
                           url: "",
                           keyData: Data(),
                           ivData: Data())
    }
}

class LogonServer: Logging {
    
    
    
    func uploadAllLog(complete: ((Bool) -> ())?) {
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
            loganUpload(config.url, date, appId, unionIdStr, device) { (data, resp, error) in
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
    
    
    //    static let `default` = LogonServer()
    
    let config: LogonConfig
    
    
    init(config: LogonConfig) {
        self.config = config
        
        LogonServer.initLogon(config)
        
    }
    
    private static func initLogon(_ config: LogonConfig) {
        ///最大存储量
        let fileMax: uint_fast64_t = 100 * 1024 * 1024
        //日志有效期,1天
        let maxReversedDate: Int32 = 1
        loganInit(config.keyData, config.ivData, fileMax)
        loganSetMaxReversedDate(maxReversedDate)

        
        loganUseASL(config.logInConsole)
        
    }
    
    
    @discardableResult
    func write(level: UInt, info: String) -> Bool {
        logan(level, info)
        return true
    }
    
    //    static func start(config: LogonConfig) {
    //
    //    }
    
}
