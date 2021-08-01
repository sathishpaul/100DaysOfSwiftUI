//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Sathish Paul Leo on 8/1/21.
//

import SwiftUI

struct ContentView: View {
    var possibleMoves = ["Rock", "Paper", "Scissors"]
    var possiblePlayerResult = ["Win", "Lose"]

    @State private var appCurrentMove = Int.random(in: 0...2)
    @State private var turnsRemaining = 10
    @State private var score = 0
    @State private var isGameEnd = false
    @State private var isAlertShowing = false

    var winOrLose: String {
        possiblePlayerResult[Int.random(in: 0...1)]
    }
    
    func restartGame() {
        turnsRemaining = 10
        score = 0
        isGameEnd = false
        appCurrentMove = Int.random(in: 0...2)
    }
    
    func calculateTurnResult(for selectedMove: Int) {
        // Setup next value to determine which item to pick in the array based on win/lose
        let nextValue = winOrLose == "Win" ? 1 : -1;
        
        if(turnsRemaining > 1) {
            if(selectedMove == appCurrentMove) {
                // No op, user selected same option as the app.
            } else {
                let userWon = selectedMove == ((appCurrentMove + nextValue) % possibleMoves.count)
                if(userWon) {
                    score += 1
                } else {
                    score -= 1
                }
            }
        } else {
            isGameEnd = true
            isAlertShowing = true
        }
        turnsRemaining -= 1;
        appCurrentMove = Int.random(in: 0...2)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Rock, Paper, Scissors!")
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                .font(.title)
                .padding()
            
                Text("The app chose: \(possibleMoves[self.appCurrentMove])")
                    
                Text("To get a point, you must: \(winOrLose)")
                
                Text("Select your option:")
                    .foregroundColor(.black)


            
            ForEach(0 ..< 3) { number in
                Button(action: {
                    self.calculateTurnResult(for: number)
                }, label: {
                    Text("\(possibleMoves[number])")
                })
                .padding()
                .border(Color.black)
                .disabled(isGameEnd)
            }
            
            VStack(alignment: .leading, spacing: nil) {
                Text("Your score: \(score)")
                    .padding(.bottom, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                Text("Turns remaining: \(turnsRemaining)")
                    .padding(.bottom, 10)
                
                Button("Restart Game!", action: {
                    self.restartGame()
                })
            }

            Spacer()
        }
        .alert(isPresented: $isAlertShowing) {
            Alert(title: Text("Game over"), message: Text("Your score is \(score)"), dismissButton: .default(Text("Ok")) {
                // self.askQuestion()
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
