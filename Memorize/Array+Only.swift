//
//  Array+Only.swift
//  Memorize
//
//  Created by YunosukeSakai on 2020/09/22.
//  Copyright © 2020 堺雄之介. All rights reserved.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
