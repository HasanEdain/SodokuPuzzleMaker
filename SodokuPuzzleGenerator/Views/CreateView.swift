//
//  CreateView.swift
//  SodokuPuzzleGenerator
//
//  Created by Hasan Edain on 9/19/24.
//

import SwiftUI

struct CreateView: View {
    @State var puzzle: Puzzle
    @State var solved: Puzzle
    @State var minimumHints: Int = 15
    @State var saveCount: Int = 0
    @State var filenameString: String = "Sodoku"

    var body: some View {
        HStack {
            Form {
                Button("Create") {
                    create()
                }
                Button("Save") {
                    save()
                }
            }
            .padding(16)
            .frame(width: 164)
            VStack {
                PuzzleView(puzzle: puzzle)
                PuzzleView(puzzle: solved)
            }
        }
    }

    func create() {
        puzzle = Puzzle.create(minHints: minimumHints)
        solved = Backsolver.solve(puzzle: puzzle)
    }

    func backsolve() {
        solved = Backsolver.solve(puzzle: puzzle)
    }

    @MainActor func save() {
        let rendererSolved = ImageRenderer(content: solvedPuzzleView)
        let redererPuzzle = ImageRenderer(content: puzzleView)

        let folder = "Sodoku"

        let homeURL = FileManager.default.homeDirectoryForCurrentUser
        let desktopURL = homeURL.appendingPathComponent("Desktop")
        let folderURL = desktopURL.appendingPathComponent(folder)
        let solvedUrl = homeURL.appending(path: "\(filenameString)_\(saveCount)_solved.pdf")
        let unsolvedUrl = homeURL.appending(path: "\(filenameString)_\(saveCount)_puzzle.pdf")

        rendererSolved.render { size, renderInContext in
            var box = CGRect(
                origin: .zero,
                size: .init(width: CGFloat(9*48), height: CGFloat(9*48))
            )

            guard let context = CGContext(solvedUrl as CFURL, mediaBox: &box, nil) else {
                return
            }

            context.beginPDFPage(nil)
            renderInContext(context)
            context.endPage()
            context.closePDF()
        }

        redererPuzzle.render { size, renderInContext in
            var box = CGRect(
                origin: .zero,
                size: .init(width: CGFloat(9*48), height: CGFloat(9*48))
            )

            guard let context = CGContext(unsolvedUrl as CFURL, mediaBox: &box, nil) else {
                return
            }

            context.beginPDFPage(nil)
            renderInContext(context)
            context.endPage()
            context.closePDF()
        }

        self.saveCount = saveCount + 1
    }

    @ViewBuilder var solvedPuzzleView: some View {
        PuzzleView(puzzle: solved)
    }

    @ViewBuilder var puzzleView: some View {
        PuzzleView(puzzle: puzzle)
    }
}

#Preview {
    let puzzle: Puzzle = Puzzle.midSodoku
    let solvedArray:[[Int]] = Backsolver().solve(puzzle.cells)

    let solvedPuzzle: Puzzle = Backsolver.solve(puzzle: puzzle)

    CreateView(puzzle: puzzle, solved: puzzle)
}
