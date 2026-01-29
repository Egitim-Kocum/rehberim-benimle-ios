//
//  SignupRouter.swift
//  RehberimBenimleFeatures
//
//  Created by Okan Orkun on 19.01.2026.
//

import UIKit

final class SignupRouter: SignupRouterProtocol {
    weak var viewController: UIViewController?
    
    func navigateToLogin() {
        viewController?.navigationController?.setViewControllers([LoginBuilder.build()], animated: false)
    }
}
