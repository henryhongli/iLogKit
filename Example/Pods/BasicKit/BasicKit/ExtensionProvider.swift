//
//  ExtensionProvider.swift
//  BasicKit
//
//  Created by Ray on 2018/12/6.
//  Copyright © 2018 Rex. All rights reserved.
//

/// ExtensionProvider
///
/// - note: `ExtensionProvider` 并不指明谁属于GI,
///          他在于解决在不同的module下的命名冲突等问题,
///          拓展原生方法
public protocol BasicKitExtensionProvider {}
extension BasicKitExtensionProvider {
    
    /// 代理`self`方法
    public var bk: BK<Self> {
        return BK(self)
    }
    
    /// 代理`self`类方法
    public static var bk: BK<Self>.Type {
        return BK<Self>.self
    }
}


public struct BK<Base> {
    
    /// `Base`指明此代理类别
    public let base: Base
    
    /// 创建代理类别
    ///
    /// - parameters:
    ///   - base: 被代理的类别
    fileprivate init(_ base: Base) {
        self.base = base;
    }
}



extension Array: BasicKitExtensionProvider {}

extension String: BasicKitExtensionProvider {}


