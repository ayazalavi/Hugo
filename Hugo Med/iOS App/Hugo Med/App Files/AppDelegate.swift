//
//  AppDelegate.swift
//  Hugo Med
//
//  Created by Miranz  Technologies on 8/27/20.
//  Copyright © 2020 Ayaz Alavi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow();
        print("launching options \(launchOptions)")
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.minimumLineSpacing = 0
//        let payment = Payment(cards: [PaymentCard(type: "VISA", number: "1234")], amount: 15, comission: 5)
//        let details = ReceiptDetails(id: "HPY-SOL-073", date: "12-03-20. 08:00 am", service: "hugoMed", card: payment.cards[0], amount: payment.amount, comission: payment.comission)
//        let invoice = Invoice(receipt: Receipt(with: payment, details: details))
       // let callController = CallSettingsInCall(doctor: doctors[0])
        let controller = UINavigationController(rootViewController: OnBoardingCollection(collectionViewLayout: collectionViewLayout))//OnBoardingCollection(collectionViewLayout: collectionViewLayout))
        
        window?.rootViewController = controller;
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("local notification")
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }



}

