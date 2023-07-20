//
//  MainVC.swift
//  test
//
//  Created by Ярослав on 19.07.2023.
//

import UIKit
import SnapKit

fileprivate enum AnimationConstants {
    static let duration = 0.15
    static let springDamping = 0.75
    static let velocity = 0.75
    static let options: UIView.AnimationOptions = [.allowUserInteraction]
}

private extension MainVC {
    func showMenu() {
        bgView.snp.remakeConstraints {
            $0.left.equalTo(view.snp.right).offset(-UIScreen.main.bounds.width / 3)
            $0.top.bottom.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        UIView.animate(withDuration: AnimationConstants.duration,
                       delay: 0,
                       usingSpringWithDamping: AnimationConstants.springDamping,
                       initialSpringVelocity: AnimationConstants.velocity,
                       options: AnimationConstants.options) {
            self.view.layoutIfNeeded()
        }
    }
    
    func hideMenu() {
        bgView.snp.remakeConstraints {
            $0.edges.equalToSuperview()
        }
        
        UIView.animate(withDuration: AnimationConstants.duration,
                       delay: 0,
                       usingSpringWithDamping: AnimationConstants.springDamping,
                       initialSpringVelocity: AnimationConstants.velocity,
                       options: AnimationConstants.options) {
            self.view.layoutIfNeeded()
        }
    }
}

class BgView: UIView {
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let inside = super.point(inside: point, with: event)

        if !inside {
            for subview in subviews {
                let pointInSubview = subview.convert(point, from: self)
                if subview.point(inside: pointInSubview, with: event) {
                    return true
                }
            }
        }
        return inside
    }
}

class MainVC: UIViewController {
    var menuShown: Bool = false {
        didSet {
            if menuShown { showMenu() } else { hideMenu() }
        }
    }
    
    let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    let menu = MenuView()
    let bgView = BgView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        makeConstraints()
    }
}

private extension MainVC {
    @objc func menuButtonTapped() {
        menuShown.toggle()
    }
    
    func setup() {
        view.addSubview(bgView)
        bgView.addSubview(tableView)
        bgView.addSubview(menu)
        
        tableView.delegate = self
        tableView.dataSource = self
        title = "Shopping List App"
        
        let barButton = UIBarButtonItem(systemItem: .add)
        barButton.target = self
        
        barButton.action = #selector(menuButtonTapped)
        navigationItem.leftBarButtonItem = barButton
        
        menu.menuButtonTapped = {
            print("hello world")
        }
        
        navigationController?.navigationBar.isOpaque = true
        navigationController?.navigationBar.isTranslucent = false
    }
    
    func makeConstraints() {
        bgView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        menu.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.width.equalToSuperview()
            $0.right.equalTo(bgView.snp.left)
        }
    }
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        90
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Здесь будет что-нибудь у нас бла-бла-бла"
        return cell
    }
}
