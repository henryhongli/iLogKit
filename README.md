# iLogKit

[![build status](http://114.242.31.175:8090/ios-common/common-sdk/badges/master/build.svg)](http://114.242.31.175:8090/ios-common/common-sdk/commits/master)
[![Version](https://img.shields.io/cocoapods/v/iLogKit.svg?style=flat)](https://cocoapods.org/pods/iLogKit)
[![License](https://img.shields.io/cocoapods/l/iLogKit.svg?style=flat)](https://cocoapods.org/pods/iLogKit)
[![Platform](https://img.shields.io/cocoapods/p/iLogKit.svg?style=flat)](https://cocoapods.org/pods/iLogKit)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

# Android 
[Android  日志工具库](https://github.com/sdohubs/ilog.git)[Android  日志工具库](https://github.com/sdohubs/ilog.git)

# iOS Swift


## Installation

iLogKit is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
///已集成Logan服务
pod 'iLogKit', :git => 'https://github.com/henryhongli/iLogKit.git', :tag => '2.4.0'
pod 'iLogKit', :git => 'http://hongli@114.242.31.175:8090/ios-common/common-sdk.git', :tag => '2.4.0'


///原始工具,未封装版本
pod 'iLogKit', :git => 'https://github.com/henryhongli/iLogKit.git', :tag => '1.5.0'
```

## Author

261930323@qq.com, zhang_mao008@163.com

## License

iLogKit is available under the MIT license. See the LICENSE file for more info.

![类图s](https://raw.githubusercontent.com/henryhongli/iLogKit/master/Example/iLogKit/App日志类图.png)


## 一.启动服务
```ruby
///启动日志收集服务
let dic = ["keyData":"0123456789012345",
           "ivData":"0123456789012345",
           "uploadUrl":"http://192.168.1.189:9999/logan/upload.json"]
LoganServer.startLogan(dic)
///设置收集最低级别
LoganServer.iLogLimit(.lower)
///设置是否在控制台打印
LoganServer.ifNeedPrint(true)
```
## 二.实现接口
```ruby
struct LogInfo :ILogServer{
    var moduleName: String

    var messionName: String

    var userTag: String

    var result: iLogMessionResult

    var detail: String

    var logLevel: LocalLogType
    
}
extension ILogServer where Self == LogInfo {
    
}
```
## 三.记录日志
```ruby
let log = LogInfo(moduleName: "登录模块",
               messionName: "登录按钮点击",
               userTag: "18618379342",
               result: .fail("\(error)"),
               detail: "account:\(phone),pwd:\(pwd)",
              logLevel: .lower)

ILog.write(log.self)

//或
ILog.write(1, "label")

```

## 四.上传日志
```ruby
ILog.uploadAllLog{ (state) in
    print(state ? "日志上传成功":"日志上传失败")
}
```
## 五.更多内容可借鉴Exemple示例
