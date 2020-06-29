# iLogKit

[![CI Status](https://img.shields.io/travis/261930323@qq.com/iLogKit.svg?style=flat)](https://travis-ci.org/261930323@qq.com/iLogKit)
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
pod 'iLogKit', :git => 'https://github.com/henryhongli/iLogKit.git', :tag => '2.0.0'

///原始工具,未封装版本
pod 'iLogKit', :git => 'https://github.com/henryhongli/iLogKit.git', :tag => '1.5.0'
```

## Author

261930323@qq.com, zhang_mao008@163.com

## License

iLogKit is available under the MIT license. See the LICENSE file for more info.

![类图s](https://raw.githubusercontent.com/henryhongli/iLogKit/master/Example/App日志类图.png)


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
class iLogbaseModule {
   .....
}
///--------------- 实现转义
extension iLogbaseModule : ILogServer{
    ///协议属性, 转换日志VM
    var iLogVM: ilogViewModel{
        let vm = ilogViewModel()
        /// 日志级别
        vm.logLevel = LocalLogType.lower.rawValue
        /// 日志内容
        vm.label = "这是一条操作日志"
        return vm
    }
    ///记录日志
    public func writeLog() {
        self.iLogVM.iLog.write()
    }
}
```
## 三.记录日志
```ruby
let log = iLogbaseModule()
...
此处可以根据编辑log,完善日志内容
...
log.writeLog()
```

## 四.上传日志
```ruby
LoganServer.uploadAllLog{ (state) in
    print(state ? "日志上传成功":"日志上传失败")
}
```
## 五.更多内容可借鉴Exemple示例
