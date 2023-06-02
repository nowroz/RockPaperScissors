//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Nowroz Islam on 1/6/23.
//

import SwiftUI

enum Move: String, CaseIterable, Identifiable {
    case rock
    case paper
    case scissors
    
    var id: Self {
        self
    }
}

extension Move {
    var getEmoji: String {
        switch self {
        case .rock:
            return "👊"
        case .paper:
            return "🖐️"
        case .scissors:
            return "✌️"
        }
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

struct MoveView: View {
    let move: Move
    let size: CGFloat
    
    var body: some View {
        VStack {
            Text(move.rawValue)
                .font(.headline.weight(.bold))
                .foregroundColor(.primary)
            
            Text(move.getEmoji)
                .font(.system(size: size))
                .shadow(radius: 5)
        }
        .padding()
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
    init(of move: Move, size: CGFloat) {
        self.move = move
        self.size = size
    }
}

struct ContentView: View {
    @State private var allMoves: [Move] = Move.allCases.shuffled()
    @State private var computerMove: Move = .allCases.randomElement()!
    @State private var shouldWin = Bool.random()
    @State private var score = 0
    @State private var turn = 1
    
    @State private var showingAnswer = false
    @State private var answerTitle = ""
    @State private var answerMessage = ""
    
    @State private var showingFinalScore = false
    @State private var finalScoreTitle = ""
    @State private var finalScoreMessage = ""
    
    private var gameChoice: String {
        shouldWin ? "win" : "lose"
    }
    
    private var gradientBackground: some View {
        LinearGradient(gradient: Gradient(colors: [
            .clear,
            .indigo.opacity(0.7),
        ]), startPoint: .top, endPoint: .bottom)
    }
    
    var body: some View {
        ZStack {
            gradientBackground
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Text("Rock-Paper-Scissors")
                    .font(.largeTitle.bold())
                
                VStack {
                    Text("Computer:")
                        .font(.title.weight(.semibold))
                        .foregroundColor(.secondary)
                    
                    MoveView(of: computerMove, size: 80)
                        .shadow(radius: 5)
                }
                
                VStack(spacing: 20) {
                    Text("Choose your move to \(gameChoice):")
                        .font(.title.weight(.semibold))
                        .foregroundColor(.secondary)
                    
                    HStack(spacing: 15) {
                        ForEach(allMoves) { move in
                            Button {
                                check(move)
                            } label: {
                                MoveView(of: move, size: 50)
                            }
                            .shadow(radius: 5)
                        }
                    }
                }
                
                Text("Score: \(score)")
                    .font(.headline.weight(.semibold))
                    .padding()
                
                Text("Turn: \(turn)/10")
            }
            .padding()
        }
        .alert(answerTitle, isPresented: $showingAnswer) {
            Button("Continue") {
                continueGame()
            }
        } message: {
            Text(answerMessage)
        }
        .alert(finalScoreTitle, isPresented: $showingFinalScore) {
            Button("Restart") {
                restart()
            }
        } message: {
            Text(finalScoreMessage)
        }
    }
    
    func check(_ move: Move) {
        if move == computerMove {
            answerTitle = "Draw!"
            answerMessage = "🤨"
        }else if move == computerMove.winMove && shouldWin {
            score += 1
            answerTitle = "Correct!"
            answerMessage = "+1 Point."
        } else if move != computerMove.winMove && shouldWin == false {
            score += 1
            answerTitle = "Correct!"
            answerMessage = "+1 Point."
        } else {
            score = max(0, score - 1)
            answerTitle = "Wrong!"
            answerMessage = "-1 Point."
        }
        
        if turn == 10 {
            showingFinalScore = true
            finalScoreTitle = "Game Over!"
            finalScoreMessage = "Your final score is \(score)"
        } else {
            showingAnswer = true
        }
    }
    
    func continueGame() {
        computerMove = Move.allCases.randomElement()!
        allMoves.shuffle()
        shouldWin = Bool.random()
        turn += 1
    }
    
    func restart() {
        computerMove = Move.allCases.randomElement()!
        allMoves.shuffle()
        shouldWin = Bool.random()
        turn = 1
        score = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
