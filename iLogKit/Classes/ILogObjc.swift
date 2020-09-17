//
//  ILogObjc.swift
//  iLogKit
//
//  Created by 洪利 on 2020/8/6.
//

import UIKit

@objc public class ILogObjc: NSObject {

    /// 启动日志服务
    /// - Parameters:
    ///   - keyData: key
    ///   - ivData: iv
    ///   - uploadUrl: 上传地址
    ///   - ifNeedPrint: 是否需要在控制台实时输出日志内容, 默认false
    public static func startLogan(_ data: [String: String]) {
//        ILog.startLogan(data)
    }
    ///存储日志
    @objc public class func write(level: UInt, label: String) {
        ILog.write(level, label)
    }
    
}
