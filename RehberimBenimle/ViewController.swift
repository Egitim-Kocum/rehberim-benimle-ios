//
//  ViewController.swift
//  RehberimBenimle
//
//  Created by Abdulkerim Can on 30.09.2025.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Rehberim Benimle"
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubviews(label)
        view.backgroundColor = .systemBackground
        
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}


extension UIView {
    func addSubviews(_ view: UIView...) {
        view.forEach { self.addSubview($0) }
    }
}
