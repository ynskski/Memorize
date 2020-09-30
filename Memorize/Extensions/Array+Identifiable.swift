//
//  Array+Identifiable.swift
//  Memorize
//
//  Created by YunosukeSakai on 2020/09/22.
//  Copyright © 2020 堺雄之介. All rights reserved.
//

import Foundation

extension Array where Element: Identifiable {
    func firstIndex(matching: Element) -> Int? {
        for index in 0..<self.count {
            if self[index].id == matching.id{
                return index
            }
        }
        
        return nil
    }
}
