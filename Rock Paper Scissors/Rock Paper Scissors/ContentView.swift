//
//  ContentView.swift
//  Rock Paper Scissors
//
//  Created by Chockalingam, Nitya on 12/02/2025.
//

import SwiftUI

enum Choices:String, CaseIterable {
    case Scissors = "✂️", Paper = "📝", Rock = "🪨"
}

struct ContentView: View {
    
    @State var computerChoice = Choices.allCases.first!
    @State var gameOutcome = ""
    
    @State var wins = 0
    @State var round = 0
    
    @State var showAlert = false
    @State var showComputerChoice = false
    
    var body: some View {
        GeometryReader{geo in
            VStack{
                //Computer
                VStack{
                    if !showComputerChoice{
                        Text("🤖").font(.system(size: 100))
                    } else {
                        Text(computerChoice.rawValue).font(.system(size: 100))
                    }
                }.frame(width: geo.size.width, height: geo.size.height/2)
                //Player
                VStack{
                    Text("Make your selection:").padding()
                    HStack(spacing:0){
                        ForEach(Choices.allCases, id:\.self){option in
                            Button(action: {
                                //Start the round
                                round += 1
                                
                                //Generated a computer choice
                                let index = Int.random(in: 0...Choices.allCases.count-1)
                                computerChoice = Choices.allCases[index]
                                showComputerChoice = true
                                
                                //Check if win
                                checkWin(playerChoice: option)
                            }){
                                Text(option.rawValue).font(.system(size: geo.size.width/CGFloat(Choices.allCases.count)))
                            }
                        }
                    }
                    HStack{
                        Spacer()
                        Text("Wins: \(wins)")
                        Spacer()
                        Text("Round: \(round)")
                        Spacer()
                    }
                }.frame(width: geo.size.width, height: geo.size.height/2)
                
            }
        }
        .alert("You \(gameOutcome)!", isPresented: $showAlert){
            Button("Play again!", role: .cancel){showComputerChoice = false}
        }
        
    }
    func checkWin(playerChoice:Choices){
        switch playerChoice {
        case .Scissors:
            if computerChoice == .Scissors{
                gameOutcome = "Draw"
            } else if computerChoice == .Paper{
                gameOutcome = "Win"
                wins += 1
            } else {
                gameOutcome = "Lose"
            }
        case .Paper:
            if computerChoice == .Paper{
                gameOutcome = "Draw"
            } else if computerChoice == .Scissors{
                gameOutcome = "Win"
                wins += 1
            } else {
                gameOutcome = "Lose"
            }
        case .Rock:
            if computerChoice == .Rock{
                gameOutcome = "Draw"
            } else if computerChoice == .Paper{
                gameOutcome = "Win"
                wins += 1
            } else {
                gameOutcome = "Lose"
            }
            
        }
        showAlert = true
    }
}
    
#Preview {
    ContentView()
}
