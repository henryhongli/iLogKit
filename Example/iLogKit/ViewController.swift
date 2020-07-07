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
        let log = LogInfo(moduleName: "", messionName: "", userTag: "", result: .success, detail: "", logLevel: .lower)
        
        ILog.write(log.self)
        
    }
    ///模拟登录请求报错日志收集
    @IBAction func loginFailLog(_ sender: Any) {
        /// 账号密码
        let phone = "18618379342"
        let pwd = "aa12345"
        /// 假设网络请求错误
        let error = NSError.init(domain: "hhh", code: 1001, userInfo: ["msg":"账号密码错误"])
        
        let log = LogInfo(moduleName: "登录模块",
                          messionName: "登录按钮点击",
                          userTag: "18618379342",
                          result: .fail("\(error)"),
                          detail: "account:\(phone),pwd:\(pwd)",
                         logLevel: .lower)
        
        ILog.write(log.self)
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
        ILog.uploadAllLog{ (state) in
            self.showToastLabel(state ? "日志上传成功":"日志上传失败")
        }
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






