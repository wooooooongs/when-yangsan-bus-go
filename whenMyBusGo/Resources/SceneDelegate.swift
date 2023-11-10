//
//  SceneDelegate.swift
//  whenMyBusGo
//
//  Created by 이재웅 on 2023/07/07.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
            
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = BusTimetableViewController()
        window.makeKeyAndVisible()
        self.window = window
    }
}

