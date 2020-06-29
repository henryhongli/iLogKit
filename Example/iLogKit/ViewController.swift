//
//  ViewController.swift
//  iLogKit
//
//  Created by 261930323@qq.com on 06/28/2020.
//  Copyright (c) 2020 261930323@qq.com. All rights reserved.
//

import UIKit
import iLogKit
class ViewController: UIViewController {

    
    @IBOutlet weak var toastLabel: UILabel!
    
    ///模拟登录成功操作
    @IBAction func loginLog(_ sender: Any) {
        let log = iLog_loginVM.new(.normaLogin)
        log.writeLog()
    }
    ///模拟登录请求报错日志收集
    @IBAction func loginFailLog(_ sender: Any) {
        /// 账号密码
        let phone = "18618379342"
        let pwd = "aa12345"
        /// 假设网络请求错误
        let error = NSError.init(domain: "hhh", code: 1001, userInfo: ["msg":"账号密码错误"])
        let log = iLog_loginVM.new(.normaLogin)
        log.result = .fail("\(error)")
        log.detail = "account:\(phone),pwd:\(pwd)"
        log.writeLog()
    }
    ///编辑日志收集级别
    @IBAction func editiLogKit(_ sender: Any) {
        self.present(EditLogRecivetype(), animated: true, completion: nil)
    }
    
    
    
    
    var date: String{
        let now = Date()
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        return df.string(from: now)
    }
    var appId: String{
        return "App_iOS"
    }
    var unionId: String{
        return "123456765432"
    }
    var device : String{
        return "iPhone XS MAX"
    }
    /// 上传日志
    @IBAction func uploadAllLog(_ sender: Any) {
        /// 默认 日志只收集当天的, 如果设置一周或者其他时间, 此处 date 字段需做其他处理
        LoganServer.uploadAllLog{ (state) in
            self.showToastLabel(state ? "日志上传成功":"日志上传失败")
        }
    }
    
    
    
    
    /// lower 级别日志, 设置日志采集级别后   可以   操作此处日志是否被采集
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let log = iLogbaseModule()
        log.logLevel = LocalLogType.lower
        log.moduleName = .login
        log.messionName = "展示登录页"
        log.writeLog()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let log = iLogbaseModule()
        log.logLevel = LocalLogType.lower
        log.moduleName = .login
        log.messionName = "退出登录页"
        log.writeLog()
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toastLabel.alpha = 0
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    
    func showToastLabel(_ content: String){
        guard content.isEmpty == false else {return}
        
        toastLabel.text = content
        
        UIView.animate(withDuration: 0.5, animations: {
            self.toastLabel.alpha = 1
        }) { (_) in
            UIView.animate(withDuration: 1) {
                self.toastLabel.alpha = 0
            }
        }
        
    }

}






