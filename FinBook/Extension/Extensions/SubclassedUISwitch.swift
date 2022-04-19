//
//  SubclassedUISwitch.swift
//  FinBook
//
//  Created by Владимир Рубис on 15.04.2022.
//

import UIKit

//MARK: Класс необходим для изменения текста лейбла в Alert без Observer
class SubclassedUISwitch: UISwitch {
    var label = UILabel()
}
