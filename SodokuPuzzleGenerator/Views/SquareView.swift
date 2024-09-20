//
//  SquareView.swift
//  SodokuPuzzleGenerator
//
//  Created by Hasan Edain on 9/19/24.
//

import SwiftUI

struct SquareView: View {
    var square: [Int]

    var body: some View {
        VStack (spacing: 0){
            HStack (spacing: 0) {
                CellView(value: square[0])
                CellView(value: square[1])
                CellView(value: square[2])
            }
            HStack (spacing: 0) {
                CellView(value: square[3])
                CellView(value: square[4])
                CellView(value: square[5])
            }
            HStack (spacing: 0) {
                CellView(value: square[6])
                CellView(value: square[7])
                CellView(value: square[8])
            }
        }.border(.black, width: 4)
    }
}

#Preview {
    let puzzle = Puzzle.midSodoku
    let squareZero = puzzle.square(number: 1)
    let squareOne = puzzle.square(number: 2)
    let squareTwo = puzzle.square(number: 3)
    let squareThree = puzzle.square(number: 4)
    let squareFour = puzzle.square(number: 5)
    let squareFive = puzzle.square(number: 6)
    let squareSix = puzzle.square(number: 7)
    let squareSeven = puzzle.square(number: 8)
    let squareEight = puzzle.square(number: 9)

    VStack {
        HStack {
            SquareView(square: squareZero)
            SquareView(square: squareOne)
            SquareView(square: squareTwo)
        }
        HStack {
            SquareView(square: squareThree)
            SquareView(square: squareFour)
            SquareView(square: squareFive)
        }
        HStack {
            SquareView(square: squareSix)
            SquareView(square: squareSeven)
            SquareView(square: squareEight)
        }
    }

}
