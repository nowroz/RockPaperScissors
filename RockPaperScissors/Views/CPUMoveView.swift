//
//  CPUMoveView.swift
//  RockPaperScissors
//
//  Created by Nowroz Islam on 17/9/23.
//

import SwiftUI

struct CPUMoveView: View {
    var move: Move
    
    var body: some View {
        VStack {
            Text(move.emoji)
                .font(.largeTitle)
                .shadow(radius: 3)
            
            Text(move.rawValue)
                .font(.largeTitle.weight(.semibold))
                .foregroundStyle(.black)
            
        }
        .padding()
        .background(.white.opacity(0.65))
        .clipShape(RoundedRectangle(cornerRadius: 25.0))
        .shadow(color: .white, radius: 10)
    }
}

#Preview {
    CPUMoveView(move: Move.paper)
        .preferredColorScheme(.dark)
}
