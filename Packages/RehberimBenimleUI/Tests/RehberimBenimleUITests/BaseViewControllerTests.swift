//
//  BaseViewControllerTests.swift
//  RehberimBenimleUI
//
//  Created by Okan Orkun on 31.12.2025.
//

import Testing
import UIKit
@testable import RehberimBenimleUI

@MainActor
struct BaseViewControllerTests {
    
    private let sut: BaseViewController
    
    init(sut: BaseViewController) {
        self.sut = sut
        _ = sut.view // trigger viewDidLoad
    }
    
    @Test("Should add loading view on viewDidLoad")
    func test_BaseViewController_viewDidLoad_setsUpLoadingView() {
        // Given
        let subviews = sut.view.subviews
        
        // Then
        #expect(!subviews.isEmpty)
    }
    
    @Test("Should show loading indicator when rendering loading state")
    func test_BaseViewController_renderLoading_showsLoadingIndicator() {
        // When
        sut.render(state: .loading)
        
        // Then
        let loadingView = sut.view.subviews.first
        #expect(loadingView != nil)
        #expect(loadingView!.isHidden == false)
    }
    
    @Test("Should hide loading indicator when rendering success state")
    func test_BaseViewController_renderSuccess_hidesLoadingIndicator() {
        // Given
        sut.render(state: .loading)
        
        // When
        sut.render(state: .success)
        
        // Then
        let loadingView = sut.view.subviews.first
        #expect(loadingView!.isHidden)
    }
    
    @Test("Should hide loading indicator and show alert when rendering error state")
    func test_BaseViewController_renderError_hidesLoadingAndShowsAlert() {
        // Given
        sut.render(state: .loading)
        
        // When
        sut.render(state: .error("Test Error"))
        
        // Then
        let loadingView = sut.view.subviews.first
        #expect(loadingView!.isHidden)
        
        // Alert presented?
        #expect(sut.presentedViewController is UIAlertController)
    }
}
