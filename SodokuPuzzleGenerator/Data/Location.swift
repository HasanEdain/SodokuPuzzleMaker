//
//  Location.swift
//  SodokuPuzzleGenerator
//
//  Created by Hasan Edain on 9/19/24.
//

import Foundation

class Location: CustomDebugStringConvertible, Comparable {
    let x: Int
    let y: Int

    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }

    static func == (lhs: Location, rhs: Location) -> Bool {
        if lhs.x != rhs.x {
            return false
        }

        if lhs.y != rhs.y {
            return false
        }

        return true
    }

    static func < (lhs: Location, rhs: Location) -> Bool {
        if lhs.x < rhs.x {
            return true
        }
        if lhs.y < rhs.y {
            return true
        }

        return false
    }

    func isInvalidLocation() -> Bool {
        if x < 0 {
            return true
        } else if y < 0 {
            return true
        } else if x > 8 {
            return true
        } else if y > 8 {
            return true
        }

        return false
    }

    static func random() -> Location {
        let xLoc = Int.random(in: 0...8)
        let yLoc = Int.random(in: 0...8)

        return Location(x: xLoc, y: yLoc)
    }

    static var invalid: Location {

        return Location(x: -1, y: -1)
    }

    var debugDescription: String {
        return String("(x: \(x) y:\(y))")
    }
}
