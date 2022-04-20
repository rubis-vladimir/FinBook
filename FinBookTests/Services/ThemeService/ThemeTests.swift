//
//  ThemeTests.swift
//  FinBookTests
//
//  Created by Владимир Рубис on 20.04.2022.
//

import XCTest
@testable import FinBook

class ThemeTests: XCTestCase {

    func testSetActiveTheme() {
        //arange
        let userDefaults = UserDefaults.standard
        let numberTheme = 1
        let key = "app_theme"
        
        //act
        let theme = Theme(rawValue: numberTheme)!
        theme.setActive()
        
        let value = userDefaults.object(forKey: key)
        
        //assert
        XCTAssertEqual(Theme.current, .light)
        XCTAssertEqual(value as! Int, 1)
    }
}
