//
//  ViewControllerTests.swift
//  UserDefaultsTests
//
//  Created by 山本響 on 2022/08/13.
//

@testable import UserDefaults
import XCTest

class ViewControllerTests: XCTestCase {
    
    private var sut: ViewController!
    private var defaults: FakeUserDefaults!
    
    override func setUp() {
        super.setUp()
        let sb = UIStoryboard(name: "Main", bundle: nil)
        sut = sb.instantiateViewController(identifier: String(describing: ViewController.self))
        
        defaults = FakeUserDefaults()
        sut.userDefaults = defaults
        
    }
    
    override func tearDown() {
        sut = nil
        defaults = nil
        super.tearDown()
    }

    func test_viewDidLoad_withEmptyUserDefaults_shouldShow0InCounterLabel() {
        
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(sut.counterLabel.text, "0")
    }
    
    func test_tappingButton_with12InUserDefaults_shouldWrite13ToUserDefaults() {
        defaults.integers = ["count": 12]
        sut.loadViewIfNeeded()
        
        tap(sut.incrementButton)
        
        XCTAssertEqual(defaults.integers["count"], 13)
    }
}
