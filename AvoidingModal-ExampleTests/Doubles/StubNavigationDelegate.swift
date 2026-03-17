//
//  StubNavigationDelegate.swift
//  AvoidingModal-ExampleTests
//
//  Created by William Boles on 17/03/2026.
//  Copyright © 2026 Boles. All rights reserved.
//

import UIKit

class StubNavigationDelegate: NSObject, UINavigationControllerDelegate {
    enum Event: Equatable {
        case willShow(UINavigationController, UIViewController, Bool)
        case didShow(UINavigationController, UIViewController, Bool)
    }

    private(set) var events = [Event]()
    
    func navigationController(_ navigationController: UINavigationController,
                              willShow viewController: UIViewController,
                              animated: Bool) {
        events.append(.willShow(navigationController, viewController, animated))
    }

    func navigationController(_ navigationController: UINavigationController,
                              didShow viewController: UIViewController,
                              animated: Bool) {
        events.append(.didShow(navigationController, viewController, animated))
    }
}
