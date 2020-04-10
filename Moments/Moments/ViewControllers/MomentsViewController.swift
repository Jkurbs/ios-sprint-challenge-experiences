//
//  MomentsViewController.swift
//  Moments
//
//  Created by Kerby Jean on 4/10/20.
//  Copyright © 2020 Kerby Jean. All rights reserved.
//

import UIKit

class MomentsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Moments"
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem =  UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showAddMomentVC))
    }
    
    
    @objc func showAddMomentVC() {
        let vc = AddVideoViewController()
        let nav = UINavigationController(rootViewController: vc)
        navigationController?.present(nav, animated: true, completion: nil)
    }
}
