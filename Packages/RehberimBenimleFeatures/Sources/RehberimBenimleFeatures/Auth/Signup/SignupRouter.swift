//
//  SignupRouter.swift
//  RehberimBenimleFeatures
//
//  Created by Okan Orkun on 19.01.2026.
//

import UIKit

final class SignupRouter: SignupRouterProtocol {
    weak var viewController: UIViewController?

    func navigateToInfos() {
        
    }
    
    func navigateToLogin() {
        viewController?.navigationController?.pushViewController(LoginBuilder.build(), animated: true)
    }
}
