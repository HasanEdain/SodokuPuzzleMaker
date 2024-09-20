//
//  PuzzleTest.swift
//  SodokuPuzzleGeneratorTests
//
//  Created by Hasan Edain on 9/19/24.
//

import Testing

@testable import SodokuPuzzleGenerator

struct PuzzleTest {

    func testablePuzzle() -> Puzzle {
        let puzzle = Puzzle.testableSodoku

        return puzzle
    }

    @Test func testrow() async throws {
        let puzzle = testablePuzzle()

        let rowZero = puzzle.row(number: 0)
        #expect(rowZero == [1,2,3,1,2,3,1,2,3])

        let rowOne = puzzle.row(number: 1)
        #expect(rowOne == [4,5,6,4,5,6,4,5,6])

        let rowTwo = puzzle.row(number: 2)
        #expect(rowTwo == [7,8,9,7,8,9,7,8,9])

        let rowThree = puzzle.row(number: 3)
        #expect(rowThree == [1,2,3,1,2,3,1,2,3])

        let rowFour = puzzle.row(number: 4)
        #expect(rowFour == [4,5,6,4,5,6,4,5,6])

        let rowFive = puzzle.row(number: 5)
        #expect(rowFive == [7,8,9,7,8,9,7,8,9])

        let rowSix = puzzle.row(number: 6)
        #expect(rowSix == [1,2,3,1,2,3,1,2,3])

        let rowSeven = puzzle.row(number: 7)
        #expect(rowSeven == [4,5,6,4,5,6,4,5,6])

        let rowEight = puzzle.row(number: 8)
        #expect(rowEight == [7,8,9,7,8,9,7,8,9])
    }

    @Test func testcolumn() async throws {
        let puzzle = testablePuzzle()

        let columnZero = puzzle.column(number: 0)
        #expect(columnZero == [1,4,7,1,4,7,1,4,7])

        let columnOne = puzzle.column(number: 1)
        #expect(columnOne == [2,5,8,2,5,8,2,5,8])

        let columnTwo = puzzle.column(number: 2)
        #expect(columnTwo == [3,6,9,3,6,9,3,6,9])

        let columnThree = puzzle.column(number: 3)
        #expect(columnThree == [1,4,7,1,4,7,1,4,7])

        let columnFour = puzzle.column(number: 4)
        #expect(columnFour == [2,5,8,2,5,8,2,5,8])

        let columnFive = puzzle.column(number: 5)
        #expect(columnFive == [3,6,9,3,6,9,3,6,9])

        let columnSix = puzzle.column(number: 6)
        #expect(columnSix == [1,4,7,1,4,7,1,4,7])

        let columnSeven = puzzle.column(number: 7)
        #expect(columnSeven == [2,5,8,2,5,8,2,5,8])

        let columnEight = puzzle.column(number: 8)
        #expect(columnEight == [3,6,9,3,6,9,3,6,9])
    }

    @Test func testSquare() async throws {
        let puzzle = testablePuzzle()

        let squareZero = puzzle.square(number: 0)
        #expect(squareZero == [1,2,3,4,5,6,7,8,9])
        let squareOne = puzzle.square(number: 1)
        #expect(squareOne == [1,2,3,4,5,6,7,8,9])
        let squareTwo = puzzle.square(number: 2)
        #expect(squareTwo == [1,2,3,4,5,6,7,8,9])
        let squareThree = puzzle.square(number: 3)
        #expect(squareThree == [1,2,3,4,5,6,7,8,9])
        let squareFour = puzzle.square(number: 4)
        #expect(squareFour == [1,2,3,4,5,6,7,8,9])
        let squareFive = puzzle.square(number: 5)
        #expect(squareFive == [1,2,3,4,5,6,7,8,9])
        let squareSix = puzzle.square(number: 6)
        #expect(squareSix == [1,2,3,4,5,6,7,8,9])
        let squareSeven = puzzle.square(number: 7)
        #expect(squareSeven == [1,2,3,4,5,6,7,8,9])
        let squareEight = puzzle.square(number: 8)
        #expect(squareEight == [1,2,3,4,5,6,7,8,9])
    }

    @Test func testSquareNumber() async throws {
        let puzzle = testablePuzzle()

        #expect(puzzle.squareNumber(at: Location(x: 0, y: 0)) == 1)
        #expect(puzzle.squareNumber(at: Location(x: 1, y: 0)) == 1)
        #expect(puzzle.squareNumber(at: Location(x: 2, y: 0)) == 1)
        #expect(puzzle.squareNumber(at: Location(x: 3, y: 0)) == 2)
        #expect(puzzle.squareNumber(at: Location(x: 4, y: 0)) == 2)
        #expect(puzzle.squareNumber(at: Location(x: 5, y: 0)) == 2)
        #expect(puzzle.squareNumber(at: Location(x: 6, y: 0)) == 3)
        #expect(puzzle.squareNumber(at: Location(x: 7, y: 0)) == 3)
        #expect(puzzle.squareNumber(at: Location(x: 8, y: 0)) == 3)
    }

    @Test func testRowAtLocation() async throws {
        let puzzle = testablePuzzle()

        #expect(puzzle.isRowValid(rowNumber: 0) == false)
        #expect(puzzle.isRowValid(rowNumber: 1) == false)
        #expect(puzzle.isRowValid(rowNumber: 2) == false)
    }

}
