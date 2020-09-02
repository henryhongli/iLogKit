import XCTest
import iLogKit

class Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        ///启动日志收集服务
//        let dicWrong = ["ivData":"0123456789012345",
//                   "uploadUrl":"http://192.168.1.189:9999/logan/upload.json",
//                    "ifNeedPrint":"1"]
//        ILog.startLogan(dicWrong)
//
//        ///启动日志收集服务
//        let dic = ["keyData":"0123456789012345",
//                   "ivData":"0123456789012345",
//                   "uploadUrl":"http://192.168.1.189:9999/logan/upload.json",
//                    "ifNeedPrint":"1"]
//        ILog.startLogan(dic)
//        ///设置收集级别
//        ILog.iLogLimit(.lower)
//        ///设置是否在控制台打印
//        ILog.ifNeedPrint(true)
//
//
///////////    使用默认格式进行日志收集
//        /// 账号密码
//        let phone = "18618379342"
//        let pwd = "aa12345"
//        /// 假设网络请求错误
//        let error = NSError.init(domain: "hhh", code: 1001, userInfo: ["msg":"账号密码错误"])
//
//        let log = LogInfo(moduleName: "登录模块",
//                          messionName: "登录按钮点击",
//                          userTag: "18618379342",
//                          result: .fail("\(error)"),
//                          detail: "account:\(phone),pwd:\(pwd)",
//                         logLevel: .lower)
//
//        ILog.write(log.self)
//
//////////    使用快捷方式进行日志收集, 自行处理日志内容
//        ILog.write(LocalLogType.lower.rawValue, "登录模块  账号密码登录  (account:18618379342, pwd:123456)")
//
//
///////////   设置日志筛选等级
//        ILog.iLogLimit(.important)
//
//        ILog.write(log.self)
//
//        ILog.write(LocalLogType.lower.rawValue, "登录模块  账号密码登录  (account:18618379342, pwd:123456)")
//
//
//        XCTAssert(true, "Pass")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
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
