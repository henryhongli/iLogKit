//
//  AppDelegate.swift
//  iLogKit
//
//  Created by 261930323@qq.com on 06/28/2020.
//  Copyright (c) 2020 261930323@qq.com. All rights reserved.
//

import UIKit
import iLogKit
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        ///启动日志收集服务
        let dic = ["keyData":"0123456789012345",
                   "ivData":"0123456789012345",
                   "uploadUrl":"https://tclogan.jfgame.cloud/logan/upload.json",
                    "ifNeedPrint":"1"]
        ILog.startLogan(dic)
        ///设置收集最低级别
        ILog.iLogLimit(.lower)
        ///设置是否在控制台打印
        ILog.ifNeedPrint(true)
        
        
        
        
        
//        let a = [1,2]
//        print(a[3])
        
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

