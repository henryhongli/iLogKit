//
//  EditLogRecivetype.swift
//  iLogKit_Example
//
//  Created by 洪利 on 2020/6/28.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import iLogKit
class EditLogRecivetype: UIViewController {

    private let firstBtn = UIButton()
    private let secondBtn = UIButton()
    private let thirdBtn = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configSubviews()
        
    }
    

    @objc func selectedAllDroped(){
        /// 设置为error级别, 或者任意大于 4 的 整数
        ILog.default.iLogLimit(level: .error)
        UserDefaults.standard.set(iLogReciveType.allDroped.description, forKey: iLogReciveTypeKey)
        self.dismiss(animated: true, completion: nil)
    }
    @objc func selectedImportant(){
        /// 大于 lower 级别的日志将被收集
        ILog.default.iLogLimit(level: .lower)
        UserDefaults.standard.set(iLogReciveType.importantInfo.description, forKey: iLogReciveTypeKey)
        self.dismiss(animated: true, completion: nil)
    }
    @objc func selectedAll(){
        ILog.default.iLogLimit(level: .lower)
        UserDefaults.standard.set(iLogReciveType.all.description, forKey: iLogReciveTypeKey)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    private func configSubviews(){
        firstBtn.frame = CGRect(x: 50, y: 100, width: 250, height: 30)
        firstBtn.setTitle(iLogReciveType.allDroped.description, for: .normal)
        firstBtn.setTitleColor(.black, for: .normal)
        firstBtn.setTitleColor(.red, for: .selected)
        
        secondBtn.frame = CGRect(x: 50, y: 180, width: 250, height: 30)
        secondBtn.setTitle(iLogReciveType.importantInfo.description, for: .normal)
        secondBtn.setTitleColor(.black, for: .normal)
        secondBtn.setTitleColor(.red, for: .selected)
        
        thirdBtn.frame = CGRect(x: 50, y: 260, width: 250, height: 30)
        thirdBtn.setTitle(iLogReciveType.all.description, for: .normal)
        thirdBtn.setTitleColor(.black, for: .normal)
        thirdBtn.setTitleColor(.red, for: .selected)
        view.addSubview(firstBtn)
        view.addSubview(secondBtn)
        view.addSubview(thirdBtn)
        
        
        firstBtn.isSelected = iLog.default.type == .allDroped ? true:false
        secondBtn.isSelected = iLog.default.type == .importantInfo ? true:false
        thirdBtn.isSelected = iLog.default.type == .all ? true:false
        
        
        firstBtn.addTarget(self, action: #selector(selectedAllDroped), for: .touchUpInside)
        secondBtn.addTarget(self, action: #selector(selectedImportant), for: .touchUpInside)
        thirdBtn.addTarget(self, action: #selector(selectedAll), for: .touchUpInside)
    }
    

}
/// 日志收集管理 本地设置
let iLogReciveTypeKey = "iLogReciveType"
///日志收集管理
enum iLogReciveType {
    
    case allDroped   ///不收集,全部放弃
    case importantInfo /// 只收集重要的, 级别 大于 1的
    case all /// 全量收集
    
    var description : String{
        switch self {
        case .allDroped: return "不收集"
        case .importantInfo: return "只看重要的(级别大于 normal)"
        case .all: return "全部"
        }
    }
}
class iLog {
    var type : iLogReciveType {
        let result1 = UserDefaults.standard.string(forKey: iLogReciveTypeKey) ?? iLogReciveType.all.description
        if result1 == iLogReciveType.all.description {
            return .all
        }
        if result1 == iLogReciveType.importantInfo.description {
            return .importantInfo
        }
        return .allDroped
    }
    static let `default` = iLog()
    
}
