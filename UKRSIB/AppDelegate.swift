//
//  AppDelegate.swift
//  UKRSIB
//
//  Created by Valerii Sohlaiev on 30.09.2020.
//

import UIKit
import AppUIKit
import BackgroundTasks

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let identifierFeatch  = "ua.nbukurs.featch"
    let identifierRefresh = "ua.nbukurs.refresh"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let identifier = CurrencyList.stringName
        let storyboard = UIStoryboard(name: identifier, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: identifier) as? CurrencyList
        let navigationController = UINavigationController(rootViewController: vc!)
        navigationController.setNavigationBarHidden(false, animated: false)
        window?.rootViewController = navigationController
        // Register background task
        BGTaskScheduler.shared.register(forTaskWithIdentifier: identifierRefresh, using: nil) { task in
            self.handleAppRefresh(task as! BGAppRefreshTask)
        }
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Schedule a new refresh task
        scheduleAppRefresh()
    }
    
}

// MARK: Background task
extension AppDelegate {
    
    private func handleAppRefresh(_ task: BGAppRefreshTask) {
        // Schedule a new refresh task
        scheduleAppRefresh()
        
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        queue.addOperation {
            ExchangeApi.currency { _,_,_  in
                task.setTaskCompleted(success: true)
                UserDefaults.standard.set("Updated: \(Date().ddMMyyyyTime)", forKey: "LastUpdate")
            }
        }
        task.expirationHandler = {
            queue.cancelAllOperations()
        }
    }
    
    private func scheduleAppRefresh() {
        do {
            let request = BGProcessingTaskRequest(identifier: identifierRefresh)
            request.requiresNetworkConnectivity = true
            request.requiresExternalPower = false
            request.earliestBeginDate = Date(timeIntervalSinceNow: 60 * 60)
            try BGTaskScheduler.shared.submit(request)
        } catch {
            print(error)
        }
    }
    
}
