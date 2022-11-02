//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Harsh Pailkar on 31/10/22.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()
            
            VStack(spacing: 60){
                Text("Guess The Flag")
                    .foregroundColor(Color(red: 0.26, green: 0.26, blue: 0.26))
                    .font(.largeTitle.weight(.bold))
                
                VStack(spacing: 20){
                    VStack{
                        Text("Tap the flag of")
                            .foregroundColor(Color.primary)
                            .font(.subheadline.weight(.semibold))
                        
                        Text(countries[correctAnswer])
                            .foregroundColor(Color.primary)
                            .font(.title2.weight(.bold))
                    }
                    
                    ForEach(0..<3){ number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .shadow(radius: 3)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .background(Color(red: 0.26, green: 0.26, blue: 0.26))
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Text("Score: \(score)")
                    .foregroundColor(Color(red: 0.26, green: 0.26, blue: 0.26))
                    .font(.title.weight(.bold))
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
    }
    
    func flagTapped(_ number: Int){
        if number == correctAnswer {
            scoreTitle = "Correct"
            score = score + 1
        } else {
            scoreTitle = "Wrong"
        }
        
        showingScore = true
    }
    
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
