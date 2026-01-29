//
//  LoginRouter.swift
//  RehberimBenimle
//
//  Created by Okan Orkun on 24.12.2025.
//

import UIKit
import RehberimBenimleUI

final class LoginRouter: LoginRouterProtocol {

    weak var viewController: UIViewController?
    
    func navigateToInfos(role: UserType) {
        switch role {
        case .student:
            print("Student Infos")
        case .instructor:
            print("Instructor Infos")
        }
    }
    
    func navigateToHome() {
        // TODO: push home
    }
    
    func navigateToForgotPassword() {
        // TODO: push forgot password
    }
    
    func navigateToSignup() {
        viewController?.navigationController?.setViewControllers([SignupBuilder.build()], animated: false)
    }
}
