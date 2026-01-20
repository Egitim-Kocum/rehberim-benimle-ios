//
//  SceneDelegate.swift
//  RehberimBenimle
//
//  Created by Abdulkerim Can on 30.09.2025.
//

import UIKit
import RehberimBenimleFeatures

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        let view = SignupBuilder.build()
        let navigationController = UINavigationController(rootViewController: view)
        window?.windowScene = windowScene
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

