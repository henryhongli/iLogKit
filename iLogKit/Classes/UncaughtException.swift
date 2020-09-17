//
//  UncaughtException.swift
//  iLogKit
//
//  Created by Tyrant on 2020/8/17.
//

public class UncaughtException {
    
    private static let `default` = UncaughtException()
    
    var exceptions: String? = ""
}

extension UncaughtException {
    
    private static let KeyForDefaults = "Sentry_ExceptionHandler"
    /// 捕获异常
    static func sentry() {
        writeIfNeeded()
        NSSetUncaughtExceptionHandler { (exception) in
            UncaughtException.synchronize(before: {
                var array = [String]()
                if let reason = exception.reason {
                    array.append(reason)
                }
                array.append(contentsOf: exception.callStackSymbols)
                UserDefaults.standard.set(array, forKey: UncaughtException.KeyForDefaults)
            }, after: nil)
        }
    }
    
    private static func writeIfNeeded() {
        if let exception = UserDefaults.standard.object(forKey: UncaughtException.KeyForDefaults) as? [String] {
            var exceptions = ""
            for e in exception {
                exceptions += e + "\n"
            }
            UncaughtException.default.exceptions = exceptions

            ILog.write(LocalLogType.error.rawValue, exceptions)
            synchronize(before: {
                UserDefaults.standard.removeObject(forKey: UncaughtException.KeyForDefaults)
            }, after: nil)
        }
    }
    
    private static func synchronize(before: () -> Void, after: (() -> Void)?) {
        before()
        UserDefaults.standard.synchronize()
        if let a = after { a() }
    }
    
    public static func doNotTouchTheButton() {
        let exception = NSException(name: NSExceptionName(rawValue: "别按这个按钮！"), reason: "你按了这个按钮", userInfo: nil)
        exception.raise()
    }
    
}
