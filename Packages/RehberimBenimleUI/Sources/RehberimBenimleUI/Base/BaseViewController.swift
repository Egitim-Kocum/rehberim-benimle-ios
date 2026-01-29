//
//  BaseViewController.swift
//  RehberimBenimle
//
//  Created by Okan Orkun on 24.12.2025.
//

import UIKit
import SnapKit

open class BaseViewController: UIViewController {

    private lazy var loadingOverlayView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        view.isHidden = true
        view.isUserInteractionEnabled = true
        return view
    }()

    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .white
        indicator.hidesWhenStopped = true
        return indicator
    }()

    open override func viewDidLoad() {
        super.viewDidLoad()
        setupLoading()
        setupKeyboardDismiss()
    }

    open func render(state: LoadingState) {
        switch state {
        case .idle, .success:
            hideLoading()
        case .loading:
            showLoading()
        case .error(let error):
            hideLoading()
            showError(message: error)
        }
    }
    
    private func setupLoading() {
        view.addSubviews(loadingOverlayView)
        loadingOverlayView.addSubview(loadingIndicator)

        loadingOverlayView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        loadingIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    private func setupKeyboardDismiss() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        tap.delegate = self
        view.addGestureRecognizer(tap)
    }
    
    private func showLoading() {
        view.bringSubviewToFront(loadingOverlayView)
        loadingOverlayView.isHidden = false
        loadingIndicator.startAnimating()
    }

    private func hideLoading() {
        loadingIndicator.stopAnimating()
        loadingOverlayView.isHidden = true
    }
    
    private func showError(message: String) {
        let alert = UIAlertController(title: "Hata", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension BaseViewController: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        !(touch.view is UIControl)
    }
}
