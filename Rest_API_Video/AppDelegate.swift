//
//  AppDelegate.swift
//  Rest_API_Video
//
//  Created by Admin on 28/05/24.
//

//import UIKit
//
//@UIApplicationMain
//class AppDelegate: UIResponder, UIApplicationDelegate {
//
//    var window: UIWindow?
//
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//
//        let window = UIWindow(frame: UIScreen.main.bounds)
//        self.window = window
//
//        // Создайте экземпляры ваших ViewController
//        let movieViewController = MovieViewController()
//        let secondViewController = SecondViewController()
//        //secondViewController.view.backgroundColor = .white
//        //secondViewController.title = "Second"
//
//        // Создайте экземпляры UINavigationController для каждого ViewController
//        let movieNavigationController = UINavigationController(rootViewController: movieViewController)
//        let secondNavigationController = UINavigationController(rootViewController: secondViewController)
//
//        // Установите заголовки и изображения табов
//        movieNavigationController.tabBarItem = UITabBarItem(title: "Movies", image: UIImage(systemName: "film"), tag: 0)
//        secondNavigationController.tabBarItem = UITabBarItem(title: "Second", image: UIImage(systemName: "star"), tag: 1)
//
//        // Создайте UITabBarController и добавьте UINavigationController в него
//        let tabBarController = UITabBarController()
//        tabBarController.viewControllers = [movieNavigationController, secondNavigationController]
//
//        // Установите tabBarController как корневой контроллер окна
//        window.rootViewController = tabBarController
//        window.makeKeyAndVisible()
//
//        return true
//    }
//}




import UIKit
import SDWebImage

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let downloader = SDWebImageDownloader.shared
            downloader.config.downloadTimeout = 30.0 // Увеличьте тайм-аут до 30 секунд
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

