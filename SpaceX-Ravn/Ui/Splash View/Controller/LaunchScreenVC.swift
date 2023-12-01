//
//  LaunchScreenVC.swift
//  SpaceX-Ravn
//
//  Created by Leo on 30/11/23.
//

import UIKit
import SwiftUI

class LaunchScreenVC: UIViewController {
    private let splashView: UIHostingController<SplashView> = UIHostingController(rootView: SplashView())
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "AppBackground")
        
        view.addSubview(splashView.view)
        splashView.view.translatesAutoresizingMaskIntoConstraints = false
        splashView.view.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        splashView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        splashView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        splashView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoder")
    }
}
