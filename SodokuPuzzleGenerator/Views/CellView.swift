//
//  CellView.swift
//  SodokuPuzzleGenerator
//
//  Created by Hasan Edain on 9/19/24.
//

import SwiftUI

struct CellView: View {
    var value: Int
    let padding: CGFloat = 8.0
    let size: CGFloat = 48.0
    var body: some View {
        if value != 0 {
            Text("\(value)")
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(.black)
                .padding(padding)
                .frame(width: size,height: size)
                .background(.white)
                .border(.black)
        } else {
            Text("")
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundStyle(.black)
                .padding(padding)
                .frame(width: size,height: size)
                .background(.white)
                .border(.black)
        }
    }
}

#Preview {

    VStack {
        CellView(value: 0)
        CellView(value: 1)
        CellView(value: 2)
        CellView(value: 3)
        CellView(value: 4)
        CellView(value: 5)
        CellView(value: 6)
        CellView(value: 7)
        CellView(value: 8)
        CellView(value: 9)
    }

}
