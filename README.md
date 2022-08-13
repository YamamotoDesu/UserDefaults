# UserDefaults
iOS Unit Testing by Example - Chapter 11

![image](https://user-images.githubusercontent.com/47273077/178744829-44543765-d038-4d50-938d-7fb790badb98.png)

ViewController
```swift
import UIKit

protocol UserDefaultsProtocol {
    func set(_ value: Int, forKey defaultName: String)
    func integer(forKey defaultName: String) -> Int
    
}

extension UserDefaults: UserDefaultsProtocol {}


class ViewController: UIViewController {
    
    @IBOutlet private(set) var counterLabel: UILabel!
    @IBOutlet private(set) var incrementButton: UIButton!
    
    var userDefaults: UserDefaultsProtocol = UserDefaults.standard
    
    private var count = 0 {
        didSet {
            counterLabel.text = "\(count)"
            userDefaults.set(count, forKey: "count")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        count = userDefaults.integer(forKey: "count")
    }
    
    @IBAction private func incrementButtonTapped() {
        count += 1
    }

}

```


FakeUserDefaults
```swift
@testable import UserDefaults
import Foundation

class FakeUserDefaults: UserDefaultsProtocol {
    
    var integers: [String: Int] = [:]
    func set(_ value: Int, forKey defaultName: String) {
        integers[defaultName] = value
    }
    
    func integer(forKey defaultName: String) -> Int {
        integers[defaultName] ?? 0
    }
    
}
```

TestHepler
```swift

import UIKit

func tap(_ button: UIButton) {
    button.sendActions(for: .touchUpInside)
}

```

ViewControllerTests
```swift

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
```
