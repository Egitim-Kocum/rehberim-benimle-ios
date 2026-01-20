//
//  SignupBuilder.swift
//  RehberimBenimleFeatures
//
//  Created by Okan Orkun on 19.01.2026.
//

import UIKit
import RehberimBenimleCoreKit

@MainActor
public enum SignupBuilder {
    
    public static func build() -> UIViewController {
        let interactor = SignupInteractor(
            authService: DependencyContainer.shared.authService
        )
        
        let router = SignupRouter()
        let validator = SignupValidator()
        let presenter = SignupPresenter(
            interactor: interactor,
            router: router,
            validator: validator
        )
        
        let view = SignupViewController(presenter: presenter)
        presenter.view = view
        router.viewController = view
        
        return view
    }
}
