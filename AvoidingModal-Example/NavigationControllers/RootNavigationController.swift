//
//  RootNavigationController.swift
//  AvoidingModal-Example
//
//  Created by William Boles on 06/01/2017.
//  Copyright © 2017 Boles. All rights reserved.
//

import UIKit

class RootNavigationController: UINavigationController {
    
    // MARK: - ViewLifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    // MARK: - Reset
    
    func canBeMadeHeadViewController(viewController: UIViewController) -> Bool {
        return viewController.isKind(of: RootTabBarController.self) || viewController.isKind(of: TutorialViewController.self)
    }
    
    func resetNavigationStackWithLatestViewControllerAsHead() {
        if viewControllers.count > 1 {
            viewControllers.removeFirst((viewControllers.count - 1))
        }
    }
}

extension RootNavigationController: UINavigationControllerDelegate {
    
    // MARK: - UINavigationControllerDelegate
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if canBeMadeHeadViewController(viewController: viewController) {
            viewController.navigationItem.setHidesBackButton(true, animated: false)
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        //Delete existing view controllers on navigation stack if view controller can be made the head of the stack.
        if canBeMadeHeadViewController(viewController: viewController) {
            resetNavigationStackWithLatestViewControllerAsHead()
        }
    }
}
