//
//  FakeUserDefaults.swift
//  UserDefaultsTests
//
//  Created by 山本響 on 2022/08/13.
//

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
