//
//  GateNavigationController.swift
//  AvoidingModal-Example
//
//  Created by William Boles on 06/01/2017.
//  Copyright © 2017 Boles. All rights reserved.
//

import UIKit

protocol NavigationGate { }

class GateNavigationController: UINavigationController {
    
    // MARK: - Delegate

    private weak var externalDelegate: UINavigationControllerDelegate?

    override var delegate: UINavigationControllerDelegate? {
        get {
            return externalDelegate
        }
        set {
            if newValue is GateNavigationController {
                super.delegate = newValue
            } else {
                externalDelegate = newValue
            }
        }
    }

    // MARK: - ViewLifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
    }
}

// MARK: - UINavigationControllerDelegate

extension GateNavigationController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController,
                              willShow viewController: UIViewController,
                              animated: Bool) {
        if viewController is NavigationGate {
            viewController.navigationItem.setHidesBackButton(true,
                                                             animated: false)
        }
        
        externalDelegate?.navigationController?(navigationController,
                                                willShow: viewController,
                                                animated: animated)
    }

    func navigationController(_ navigationController: UINavigationController,
                              didShow viewController: UIViewController,
                              animated: Bool) {
        if viewController is NavigationGate {
            viewControllers = [viewController]
        }
        
        externalDelegate?.navigationController?(navigationController,
                                                didShow: viewController,
                                                animated: animated)
    }
}
