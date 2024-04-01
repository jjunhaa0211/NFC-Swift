//
//  SceneDelegate.swift
//  NFC-Junha
//
//  Created by 박준하 on 4/1/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)
        window?.backgroundColor = .systemBackground
        let navVC = UINavigationController(rootViewController: MainViewController())
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
    }
}

