//
//  XCodeKnows.swift
//  GIKit
//
//  Created by Tyrant on 2019/10/31.
//

import Foundation

public protocol XCodeKnows {
    
    associatedtype TARGET
    
    associatedtype ENVIRONMENT
    
    /// 当前XCode target
    static var target: TARGET { get }
    
    /// 当前XCode编译环境
    static var environment: ENVIRONMENT { get }
    
    /// 是否是开发环境
    static var isDebug: Bool { get }
    
    /// 是否是生产环境
    static var isRelease: Bool { get }
    
}
