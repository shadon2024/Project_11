//
//  SceneDelegate.swift
//  Rest_API_Video
//
//  Created by Admin on 28/05/24.
//

import UIKit
import SDWebImage

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        //guard let _ = (scene as? UIWindowScene) else { return }
        
//        guard let windowScene = (scene as? UIWindowScene) else { return }
//        let window = UIWindow(windowScene: windowScene)
//        window.rootViewController = UINavigationController(rootViewController: MovieViewController())
//        self.window = window
//        self.window?.makeKeyAndVisible()
        
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        
        
        
        //экземпляры  ViewController
        let movieViewController = MovieViewController()
        let secondViewController = SecondViewController()
        //secondViewController.view.backgroundColor = .red
        //secondViewController.title = "Second"
        movieViewController.title = "Popular Films"
        secondViewController.title = "Popular Peopls"
        
        
        // экземпляры UINavigationController для каждого ViewController
        let movieNavigationController = UINavigationController(rootViewController: movieViewController)
        let secondNavigationController = UINavigationController(rootViewController: secondViewController)
        
        
        // Настройка шрифта для отдельного UITabBarItem
        let fontAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .semibold),
            NSAttributedString.Key.foregroundColor: UIColor.systemBlue
        ]
        UITabBarItem.appearance().setTitleTextAttributes(fontAttributes, for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes(fontAttributes, for: .selected)
        
        // Установка заголовки и изображения табов
        movieNavigationController.tabBarItem = UITabBarItem(title: "Movies", image: UIImage(systemName: "film"), tag: 0)
        secondNavigationController.tabBarItem = UITabBarItem(title: "Persons", image: UIImage(systemName: "person"), tag: 1)
        secondNavigationController.navigationBar.backgroundColor = .white
        //secondNavigationController.navigationItem.titleView?.backgroundColor = .systemBlue
        
        // Создаем UITabBarController и добавим UINavigationController в него
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [movieNavigationController, secondNavigationController]
        
        
        // Установите цвет фона таб-бара
        //tabBarController.tabBar.barTintColor = UIColor.red
        
        
        // Установите цвет элементов таб-бара
        tabBarController.tabBar.tintColor = UIColor.systemBlue
        
        
        // Установите tabBarController как корневой контроллер окна
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        
//        window.rootViewController = UINavigationController(rootViewController: MovieViewController())
//        
//        self.window?.makeKeyAndVisible()
        
        
        
        
        // Установка максимального размера кэша на диске в 200 мегабайт
        print("DEBAG PRINT", SDImageCache.shared.diskCache.totalSize())
        SDImageCache.shared.config.maxDiskSize = 200 * 1024 * 1024
    }

}

