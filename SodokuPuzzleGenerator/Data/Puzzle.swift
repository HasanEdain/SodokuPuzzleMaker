//
//  Puzzle.swift
//  SodokuPuzzleGenerator
//
//  Created by Hasan Edain on 9/19/24.
//

import Foundation

class Puzzle:CustomDebugStringConvertible {
    var cells: [[Int]]

//MARK: - Init

    var debugDescription: String {
        var output = ""
        for index in 0...8 {
            let array = cells[index]
            for xIndex in 0...8 {
                output.append("\(array[xIndex])")
                if xIndex < 8 {
                    output.append(",")
                }
            }
            output.append("\n")
        }

        return output
    }

    init() {
        self.cells = [[Int]]()
        for yIndex in 0..<9 {
            self.cells.append([Int]())
            for _ in 0..<9 {
                self.cells[yIndex].append(Int(0))
            }
        }
    }

//MARK: - Access

    func row(number: Int) -> [Int] {
        let row = self.cells[number]

        return row
    }

    func column(number: Int) -> [Int] {
        var column = [Int]()

        for index in 0..<9 {
            column.append(cells[index][number])
        }

        return column
    }

    func square(number: Int) -> [Int] {
        var square = [Int]()

        var xOffset = 0
        var yOffset = 0

        if number == 2 {
            xOffset = 3
        } else if number == 3 {
            xOffset = 6
        } else if number == 4 {
            yOffset = 3
        } else if number == 5 {
            xOffset = 3
            yOffset = 3
        } else if number == 6 {
            xOffset = 6
            yOffset = 3
        } else if number == 7 {
            yOffset = 6
        } else if number == 8 {
            xOffset = 3
            yOffset = 6
        } else if number == 9 {
            xOffset = 6
            yOffset = 6
        }

        square.append(cells[0 + yOffset][0 + xOffset])
        square.append(cells[0 + yOffset][1 + xOffset])
        square.append(cells[0 + yOffset][2 + xOffset])
        square.append(cells[1 + yOffset][0 + xOffset])
        square.append(cells[1 + yOffset][1 + xOffset])
        square.append(cells[1 + yOffset][2 + xOffset])
        square.append(cells[2 + yOffset][0 + xOffset])
        square.append(cells[2 + yOffset][1 + xOffset])
        square.append(cells[2 + yOffset][2 + xOffset])

        return square
    }

    func cellValue(at location: Location) -> Int {
        return cells[location.y][location.x]
    }

    func update(value: Int, location: Location) {
        cells[location.y][location.x] = value
    }

//MARK: - Create Solved Puzzle
    static func create(minHints: Int = 17) -> Puzzle {
        let puzzle = Puzzle()

        var solvable: Bool = false

        for _ in 0...minHints {
            puzzle.placeRandom()
        }

        while solvable == false {
            puzzle.placeRandom()
            let solved = Backsolver.solve(puzzle: puzzle)
            solvable = (solved.anyZeros() == false)
        }
        print("\(puzzle)")
        return puzzle
    }

    func placeRandom() {
        var placed = false
        var locationArray = Puzzle.allLocations()
        let allNumbers = [1,2,3,4,5,6,7,8,9]
        guard let number = allNumbers.randomElement() else {
            print("Failed to get random value")
            return
        }

        while placed == false && locationArray.isEmpty == false && allNumbers.isEmpty == false {
            let index = Int.random(in: 0..<locationArray.count)
            let location = locationArray[index]


            if canPlace(value: number, location: location) {
                update(value: number, location: location)
                placed = true
            } else {
                locationArray.remove(at: index)
            }
        }
    }

    func anyZeros() -> Bool {
        let all = Puzzle.allLocations()
        var hasZero = false

        all.forEach { location in
            if cellValue(at: location) == 0 {
                hasZero = true
            }
        }

        return hasZero
    }

    static func allLocations() -> [Location] {
        var all = [Location]()
        for yIndex in 0...8 {
            for xIndex in 0...8 {
                all.append(Location(x:xIndex,y:yIndex))
            }
        }

        return all
    }

    func canPlace(value: Int, location: Location) -> Bool {
        let row = row(number: location.y)
        let column = column(number: location.x)
        let square = square(number: squareNumber(at: location))

        if cellValue(at: location) != 0 {
            return false
        }
        
        if row.contains(value) {
            return false
        }
        if column.contains(value) {
            return false
        }
        if square.contains(value) {
            return false
        }

        return true
    }

    func squareNumber(at location: Location) -> Int {
        let rangeOne = 0...2
        let rangeTwo = 3...5
        let rangeThree = 6...8

        if  rangeOne.contains(location.y) {
            if rangeOne.contains(location.x) {
                return 1
            }
            if rangeTwo.contains(location.x) {
                return 2
            }
            if rangeThree.contains(location.x) {
                return 3
            }
        } else if rangeTwo.contains(location.y){
            if rangeOne.contains(location.x) {
                return 4
            }
            if rangeTwo.contains(location.x) {
                return 5
            }
            if rangeThree.contains(location.x) {
                return 6
            }
        } else if rangeThree.contains(location.y) {
            if rangeOne.contains(location.x) {
                return 7
            }
            if rangeTwo.contains(location.x) {
                return 8
            }
            if rangeThree.contains(location.x) {
                return 9
            }
        }

        return -1
    }

//MARK: - Validity

    //Puzzle (9x9) does each row, column and 3x3 square have one and only one of each int 1 - 9
    func isValid() -> Bool {
        var valid: Bool = true

        for index in 0..<9 {
            if isRowValid(rowNumber: index) == false {
                valid = false
            }
            if isColumnValid(columnNumber: index) == false {
                valid = false
            }
            if isSquareValid(squareNumber: index) == false {
                valid = false
            }
        }

        return valid
    }

    func isRowValid(rowNumber: Int) -> Bool {
        let row = row(number: rowNumber)

        return isValid(array: row)
    }

    func isColumnValid(columnNumber:Int) -> Bool {
        let column = column(number: columnNumber)

        return isValid(array: column)
    }

    func isSquareValid(squareNumber: Int) -> Bool {
        let square = square(number: squareNumber)

        return isValid(array: square)
    }

    //Array of 9 integers, does it have 9 elements, and one and only one of each int between 0 and 9
    func isValid(array: [Int]) -> Bool {
        if array.count != 9 {
            return false
        }

        let total = 1+2+3+4+5+6+7+8+9
        let rowSum = array.reduce(0, +)

        if total != rowSum {
            return false
        }

        let counts = array.reduce(into: [:]) { $0[$1, default: 0] += 1 }

        var isValid: Bool = true

        counts.forEach { (key: Int, value: Int) in
            if value != 1 {
                isValid = false
            }
        }

        return isValid
    }

//MARK: - Static creation

    static var testSodoku: Puzzle {
        let puzzle = Puzzle()
        puzzle.cells = [
            [0, 2, 6, 0, 0, 0, 8, 1, 0],
            [3, 0, 0, 7, 0, 8, 0, 0, 6],
            [4, 0, 0, 0, 5, 0, 0, 0, 7],
            [0, 5, 0, 1, 0, 7, 0, 9, 0],
            [0, 0, 3, 9, 0, 5, 1, 0, 0],
            [0, 4, 0, 3, 0, 2, 0, 5, 0],
            [1, 0, 0, 0, 3, 0, 0, 0, 2],
            [5, 0, 0, 2, 0, 4, 0, 0, 9],
            [0, 3, 8, 0, 0, 0, 4, 6, 0],
        ]

        return puzzle
    }

    static var midSodoku: Puzzle {
        let puzzle = Puzzle()
        puzzle.cells = [
            [0, 2, 6, 0, 0, 0, 8, 1, 0],
            [3, 0, 0, 7, 0, 0, 0, 0, 6],
            [4, 0, 0, 0, 5, 0, 0, 0, 7],
            [0, 5, 0, 1, 0, 7, 0, 9, 0],
            [0, 0, 3, 9, 0, 5, 1, 0, 0],
            [0, 4, 0, 3, 0, 0, 0, 5, 0],
            [1, 0, 0, 0, 3, 0, 0, 0, 2],
            [5, 0, 0, 2, 0, 4, 0, 0, 9],
            [0, 3, 8, 0, 0, 0, 4, 6, 0],
        ]

        return puzzle
    }

    static var hardenstSodoku: Puzzle {
        let puzzle = Puzzle()
        puzzle.cells = [
            [0, 0, 5, 3, 0, 0, 0, 0, 0],
            [8, 0, 0, 0, 0, 0, 0, 2, 0],
            [0, 7, 0, 0, 1, 0, 5, 0, 0],
            [4, 0, 0, 0, 0, 5, 3, 0, 0],
            [0, 1, 0, 0, 7, 0, 0, 0, 6],
            [0, 0, 3, 2, 0, 0, 0, 8, 0],
            [0, 6, 0, 5, 0, 0, 0, 0, 9],
            [0, 0, 4, 0, 0, 0, 0, 3, 0],
            [0, 0, 0, 0, 0, 0, 9, 7, 0],
        ]
        return puzzle
    }

    static var testableSodoku: Puzzle {
        let puzzle = Puzzle()
        puzzle.cells = [
            [1, 2, 3, 1, 2, 3, 1, 2, 3],
            [4, 5, 6, 4, 5, 6, 4, 5, 6],
            [7, 8, 9, 7, 8, 9, 7, 8, 9],
            [1, 2, 3, 1, 2, 3, 1, 2, 3],
            [4, 5, 6, 4, 5, 6, 4, 5, 6],
            [7, 8, 9, 7, 8, 9, 7, 8, 9],
            [1, 2, 3, 1, 2, 3, 1, 2, 3],
            [4, 5, 6, 4, 5, 6, 4, 5, 6],
            [7, 8, 9, 7, 8, 9, 7, 8, 9]
        ]
        return puzzle
    }
}
