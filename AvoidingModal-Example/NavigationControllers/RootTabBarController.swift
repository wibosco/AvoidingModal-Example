//
//  RootTabBarController.swift
//  AvoidingModal-Example
//
//  Created by William Boles on 06/01/2017.
//  Copyright © 2017 Boles. All rights reserved.
//

import UIKit

class RootTabBarController: UITabBarController {

    // MARK: - ViewLifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.setNavigationBarHidden(true, animated: false)
    }

}
