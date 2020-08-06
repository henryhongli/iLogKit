//
//  Studio.swift
//  GIKit
//
//  Created by Tyrant on 2019/5/7.
//  Copyright © 2019 Rex. All rights reserved.
//

import Foundation

import AudioToolbox

public final class Studio {
    
    private init() { }
    
    
    /// 默认
    public static let `default` = Studio()
    
    
    /// 最近一次播放的音频
    lazy var latestPaly: SystemSoundID? = 0
    
    public enum Audio {
        
        case caf(_ file: String), aill(_ file: String), wav(_ file: String)
        
        case system(UInt32)
        
        public var type: String {
            switch self {
            case .caf, .system: return "caf"
            case .aill: return "aill"
            case .wav: return "wav"
            }
        }
        
        public var name: String {
            switch self {
            case let .aill(file), let .caf(file), let .wav(file): return file
            case .system: return ""
            }
        }
        
        public var path: String? {
            return Bundle.main.path(forResource: name, ofType: type)
        }
        
        public var url: URL? {
            guard let path = path else { return nil }
            return URL(string: path)
        }
        
        func systemSoundID(playid: inout SystemSoundID) {
            switch self {
            case .system(let id): playid = id
            default:
                guard let url = self.url else { return }
                let u = url as CFURL
                AudioServicesCreateSystemSoundID(u, &playid)
            }
        }
    }
}

//MARK: Play
extension Studio {
    
    /// 播放
    ///
    /// - Parameter audio: 音频
    @discardableResult public func play(_ audio: Audio) -> Bool {
        
        Studio.endPlay()
        
        guard var id = latestPaly else { return false }
        
        audio.systemSoundID(playid: &id)
        
        AudioServicesPlaySystemSound(id)
        
        latestPaly = id
        
        return true
    }
    
    /// 播放
    ///
    /// - Parameter audio: 音频
    public static func play(_ audio: Audio) {
        Studio.default.play(audio)
    }

}

//MARK: End Play
extension Studio {
    
    /// 终止最后一次播放
    public static func endPlay() {
        guard let id = Studio.default.latestPaly else { return }
        AudioServicesDisposeSystemSoundID(id)
    }
    
}




extension BK where Base == String {
    
    /// caf音频
    public var caf: Studio.Audio {
        return .caf(self.base)
    }
    
    
    /// aill音频
    public var aill: Studio.Audio {
        return .aill(self.base)
    }
    
    
    /// wav音频
    public var wav: Studio.Audio {
        return .wav(self.base)
    }
    
}

