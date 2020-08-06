//
//  Format.swift
//  Foundation_Swift
//
//  Created by Ray on 2018/11/16.
//

import XKit

extension BK where Base == String {
    
    /// 字符串+hello, moto 的 md5
    public var md5: String {
        return (self.base + "hello, moto").x.md5
    }
}
