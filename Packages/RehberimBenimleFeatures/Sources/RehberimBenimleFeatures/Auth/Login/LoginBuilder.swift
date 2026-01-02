//
//  LoginBuilder.swift
//  RehberimBenimle
//
//  Created by Okan Orkun on 24.12.2025.
//

import UIKit
import RehberimBenimleCoreKit

@MainActor
public enum LoginBuilder {

    public static func build() -> UIViewController {
        let interactor = LoginInteractor(
            authService: DependencyContainer.shared.authService
        )

        let router = LoginRouter()
        let validator = LoginValidator()
        let presenter = LoginPresenter(
            interactor: interactor,
            router: router,
            validator: validator
        )

        let view = LoginViewController(presenter: presenter)
        presenter.view = view
        router.viewController = view

        return view
    }
}
