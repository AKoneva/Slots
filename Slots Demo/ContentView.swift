//
//  ContentView.swift
//  Slots Demo
//
//  Created by Macbook Pro on 05.08.2020.
//  Copyright © 2020 Macbook Pro. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var numbers = Array(repeating: 0, count: 9)
    
    @State private var symbols = ["apple", "star", "cherry"]
    @State private var backgrounds = Array(repeating: Color.white, count: 9)
    
    @State private var credits = 1000
    @State private var showAlert = false
    @State var win = false
    
    private var betAmount = 5
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.yellow, Color.blue]), startPoint: .leading, endPoint: .trailing)
                .ignoresSafeArea()
            
            VStack {
                Text("SwiftUI Slots")
                    .bold()
                    .foregroundColor(.white)
                    .scaleEffect(3)
                    .padding(.all, 35)
                
                Text("Credits: \(credits)")
                    .padding()
                    .background(win ? Color.green.opacity(0.5) : Color.white.opacity(0.5))
                    .cornerRadius(20)
                    .scaleEffect(win ? 1.2 : 1)
                Spacer()
                VStack {
                    LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]) {
                        ForEach(0 ..< 9) { num in
                            CardView(symbol: $symbols[numbers[num]], background: $backgrounds[num])
                        }
                    }
                    .padding()
                }
                Spacer()
                HStack {
                    VStack {
                        Button {
                            if self.credits <= 0 {
                                showAlert.toggle()
                            } else {
                                randomCards(IsMax: false)
                            }
                        } label: {
                            Text("Spin")
                                .bold()
                                .foregroundColor(.white)
                                .padding()
                                .padding(.horizontal)
                                .background(.pink)
                                .cornerRadius(20)
                        }
                        Text("\(betAmount) credits")
                            .font(.footnote)
                    }
                    .padding()
                    VStack {
                        Button {
                            if self.credits <= 0 {
                                showAlert.toggle()
                            } else {
                                randomCards(IsMax: true)
                            }
                        } label: {
                            Text("Max Spin")
                                .bold()
                                .foregroundColor(.white)
                                .padding()
                                .padding(.horizontal)
                                .background(.pink)
                                .cornerRadius(20)
                        }
                        Text("\(betAmount * 5) credits")
                            .font(.footnote)
                    }
                }
            }.alert(Text("Error"), isPresented: $showAlert) {
                Text("Your error message goes here.")
            }
        }

    }
    
    func randomCards(IsMax:Bool) {
        self.backgrounds = self.backgrounds.map { _ in
            Color.white
        }
        
        if IsMax {
            //Spin all cards
            self.numbers =  self.numbers.map { _ in
                Int.random(in: 0...2 )
            }
        } else {
            //Spin centre
            // change the images
            self.numbers[3] = Int.random(in: 0...2)
            self.numbers[4] = Int.random(in: 0...2)
            self.numbers[5] = Int.random(in: 0...2)
            
            print(numbers[3], numbers[4], numbers[5])
        }
        
        processWin(IsMax: IsMax)
    }
    
    func processSingleSpin(check: [Int]) -> Int {
        var matches = 0
        if numbers[check[0]] == numbers[check[1]] && numbers[check[1]] == numbers[check[2]] {
            matches += 1
            
            withAnimation(.spring()) {
                backgrounds[check[0]] = Color.green
                backgrounds[check[1]] = Color.green
                backgrounds[check[2]] = Color.green
            }
            print(backgrounds)
            
        }
        return matches
    }
    
    
    func processWin(IsMax: Bool) {
        var matches = 0
        win = false
        
        let middle = [3, 4, 5]
        let top = [0, 1, 2]
        let bottom = [6, 7, 8]
        let diagonalTopLeftToBottomRight = [0, 4, 8]
        let diagonalTopRightToBottomLeft = [2, 4, 6]
        
        if IsMax {
                matches += processSingleSpin(check: top)
                matches += processSingleSpin(check: middle)
                matches += processSingleSpin(check: bottom)
                matches += processSingleSpin(check: diagonalTopLeftToBottomRight)
                matches += processSingleSpin(check: diagonalTopRightToBottomLeft)
        } else {
            matches += processSingleSpin(check: middle)
        }
        
        if matches > 0 {
            win = true
            self.credits += matches * (betAmount * 2)
        } else {
            if IsMax {
                self.credits -= betAmount * 5
            } else {
                self.credits -= betAmount
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}





