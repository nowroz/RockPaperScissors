//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Nowroz Islam on 17/9/23.
//

import SwiftUI

struct ContentView: View {
    @State private var cpuMove: Move = .allCases.randomElement()!
    @State private var userMove: Move = .paper
    @State private var shouldWin: Bool = .random()
    
    @State private var score: Int = 0
    @State private var turn: Int = 1
    
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    @State private var showingAlert: Bool = false
    
    @State private var showingGameOverAlert: Bool = false
    
    var correctAnswer: Bool {
        (userMove == cpuMove.winMove && shouldWin) || (userMove != cpuMove.winMove && userMove != cpuMove && shouldWin == false)
    }
    
    var body: some View {
        ZStack {
            Color(red: 0.4, green: 0.85, blue: 0.9)
                .ignoresSafeArea()
            
            VStack(spacing: 25) {
                Text("RockPaperScissors")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                    .shadow(radius: 3)
                
                CPUMoveView(move: cpuMove)
                
                Text("\(turn). Choose a move to \(shouldWin ? "win": "lose"):")
                    .font(.headline)
                    .foregroundStyle(.black)
                
                VStack(spacing: 15){
                    ForEach(Move.allCases) { move in
                        Button {
                            processMove(move: move)
                        } label: {
                            Text("\(move.emoji) \(move.rawValue)")
                                .font(.headline)
                                .padding()
                                .frame(maxWidth: 240)
                                .background(.white)
                                .clipShape(Capsule())
                        }
                        .tint(.black)
                        .shadow(color: .black, radius: 3)
                    }
                }
                
                Text("Score: \(score)")
                    .foregroundStyle(.black)
            }
        }
        .alert(alertTitle, isPresented: $showingAlert) {
            Button("Ok") {
                update()
            }
        } message: {
            Text(alertMessage)
        }
        .alert("Game Over!", isPresented: $showingGameOverAlert) {
            Button("Restart") {
                restart()
            }
        } message: {
            Text("Your final score is \(score).")
        }
    }
    
    func processMove(move: Move) {
        userMove = move
        if correctAnswer {
            displayAlert(
                withTitle: "Correct!",
                withMessage: "+1 Point."
            )
        } else {
            displayAlert(
                withTitle: "Wrong!",
                withMessage: "+0 Point."
            )
        }
    }
    
    func displayAlert(withTitle title: String, withMessage message: String) {
        alertTitle = title
        alertMessage = message
        showingAlert = true
    }
    
    func update() {
        if correctAnswer {
            score += 1
        }
        
        guard turn < 10 else {
            showingGameOverAlert = true
            return
        }
        
        turn += 1
        shuffle()
    }
    
    func shuffle() {
        cpuMove = .allCases.randomElement()!
        shouldWin = .random()
    }
    
    func restart() {
        score = 0
        turn = 1
        shuffle()
    }
}

#Preview {
    ContentView()
}
