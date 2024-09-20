//
//  PuzzleView.swift
//  SodokuPuzzleGenerator
//
//  Created by Hasan Edain on 9/19/24.
//

import SwiftUI

struct PuzzleView: View {
    var puzzle: Puzzle

    var body: some View {
        VStack (spacing: 0){
            HStack (spacing: 0) {
                SquareView(square: puzzle.square(number: 1))
                SquareView(square: puzzle.square(number: 2))
                SquareView(square: puzzle.square(number: 3))
            }
            HStack (spacing: 0) {
                SquareView(square: puzzle.square(number: 4))
                SquareView(square: puzzle.square(number: 5))
                SquareView(square: puzzle.square(number: 6))
            }
            HStack (spacing: 0) {
                SquareView(square: puzzle.square(number: 7))
                SquareView(square: puzzle.square(number: 8))
                SquareView(square: puzzle.square(number: 9))
            }
        }
        .border(.black, width: 8)
    }
}

#Preview {
    let puzzle = Puzzle.midSodoku

    PuzzleView(puzzle: puzzle)
}
