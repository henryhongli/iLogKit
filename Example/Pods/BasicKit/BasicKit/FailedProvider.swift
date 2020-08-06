//
//  FailedProvider.swift
//  BasicKit
//
//  Created by Tyrant on 2019/10/31.
//  Copyright © 2019 Rex. All rights reserved.
//

import Foundation


public struct Failable<Value : Decodable> : Decodable {
    
    public let value: Value?
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        do {
            self.value = try container.decode(Value.self)
        }
        catch {
            self.value = nil
        }
    }
}

extension Collection {
    
    public func value<Value>() -> [Value] where Value: Decodable, Element == Failable<Value> {
        return self.compactMap { $0.value }
    }
    
}
