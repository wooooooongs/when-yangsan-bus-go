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
        
        let navigationController = UINavigationController(rootViewController: HomeViewController())
        setStyle(to: navigationController)

        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = navigationController
        window.backgroundColor = HexColor.from("EEEEEE")
        window.tintColor = .black
        window.makeKeyAndVisible()
        self.window = window
    }
    
    private func setStyle(to from: UINavigationController) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = HexColor.from("EEEEEE")
        appearance.shadowColor = .none
                
        from.navigationBar.standardAppearance = appearance
        from.navigationBar.scrollEdgeAppearance = appearance
        
        from.navigationBar.topItem?.title = "언제 출발해?"
        from.navigationBar.prefersLargeTitles = true
    }
}
