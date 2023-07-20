//
//  MenuView.swift
//  test
//
//  Created by Ярослав on 19.07.2023.
//

import UIKit

class MenuView: UIView {
    var menuButtonTapped: (() -> Void)?
    
    let button: UIButton = {
        let button = UIButton()
        button.setTitle("Settings", for: .normal)
        button.configuration = .filled()
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .systemGray4
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        addSubview(button)
        
        button.snp.makeConstraints {
            $0.top.equalToSuperview().offset(25)
            $0.right.equalToSuperview().inset(25)
            $0.bottom.lessThanOrEqualToSuperview()
            $0.left.greaterThanOrEqualToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

@objc private extension MenuView {
    func buttonTapped() {
        menuButtonTapped?()
    }
}
