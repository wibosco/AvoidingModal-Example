//
//  GateNavigationControllerTests.swift
//  AvoidingModal-ExampleTests
//
//  Created by William Boles on 17/03/2026.
//  Copyright © 2026 Boles. All rights reserved.
//

import XCTest

@testable import AvoidingModal_Example

class GateNavigationControllerTests: XCTestCase {
    var sut: GateNavigationController!
    var delegate: StubNavigationDelegate!
    
    // MARK: - Lifecycle
    
    override func setUp() {
        super.setUp()
        
        delegate = StubNavigationDelegate()
        
        sut = GateNavigationController(rootViewController: UIViewController())
        sut.loadViewIfNeeded()
    }

    override func tearDown() {
        delegate = nil
        sut = nil
        
        super.tearDown()
    }

    // MARK: - Tests

    // MARK: Stack Trimming

    func test_givenAGateRootViewController_whenDidShow_thenStackIsTrimmedToOnlyGateRoot() {
        let gateViewController = StubGateRootViewController()
        sut.viewControllers = [UIViewController(), UIViewController(), gateViewController]

        sut.navigationController(sut,
                                 didShow: gateViewController,
                                 animated: false)

        XCTAssertEqual(sut.viewControllers, [gateViewController])
    }

    func test_givenANonGateRootViewController_whenDidShow_thenStackIsNotTrimmed() {
        let first = UIViewController()
        let second = UIViewController()
        sut.viewControllers = [first, second]

        sut.navigationController(sut,
                                 didShow: second,
                                 animated: false)

        XCTAssertEqual(sut.viewControllers, [first, second])
    }

    // MARK: Back Button

    func test_givenAGateRootViewController_whenWillShow_thenBackButtonIsHidden() {
        let gateViewController = StubGateRootViewController()

        sut.navigationController(sut,
                                 willShow: gateViewController,
                                 animated: false)

        XCTAssertTrue(gateViewController.navigationItem.hidesBackButton)
    }

    func test_givenANonGateRootViewController_whenWillShow_thenBackButtonIsNotHidden() {
        let viewController = UIViewController()

        sut.navigationController(sut,
                                 willShow: viewController,
                                 animated: false)

        XCTAssertFalse(viewController.navigationItem.hidesBackButton)
    }

    // MARK: Delegate Forwarding

    func test_givenAnExternalDelegate_whenWillShow_thenEventIsForwardedToExternalDelegate() {
        sut.delegate = delegate
        let viewController = UIViewController()

        sut.navigationController(sut,
                                 willShow: viewController,
                                 animated: false)

        XCTAssertEqual(delegate.events, [.willShow(sut, viewController, false)])
    }

    func test_givenAnExternalDelegate_whenDidShow_thenEventIsForwardedToExternalDelegate() {
        sut.delegate = delegate
        let viewController = UIViewController()

        sut.navigationController(sut,
                                 didShow: viewController,
                                 animated: false)

        XCTAssertEqual(delegate.events, [.didShow(sut, viewController, false)])
    }
}
