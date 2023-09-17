//
//  Move.swift
//  RockPaperScissors
//
//  Created by Nowroz Islam on 17/9/23.
//

import Foundation

enum Move: String, CaseIterable, Identifiable {
    case rock
    case paper
    case scissors
    
    var id: Self {
        self
    }
}

extension Move {
    var winMove: Self {
        switch self {
        case .rock:
            return .paper
        case .paper:
            return .scissors
        case .scissors:
            return .rock
        }
    }
}

extension Move {
    var emoji: String {
        switch self {
        case .rock:
            return "🪨"
        case .paper:
            return "📄"
        case .scissors:
            return "✂️"
        }
    }
}
