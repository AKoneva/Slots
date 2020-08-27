//
//  ContentView.swift
//  Slots Demo
//
//  Created by Macbook Pro on 05.08.2020.
//  Copyright © 2020 Macbook Pro. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var symbols = ["apple","star","cherry"]
    
    @State private var numbers = Array(repeating: 0, count: 9)
    @State private var backgrounds = Array(repeating: Color.white, count: 9)
    @State private var credits = 1000
    private var betAmount = 5
   
    var body: some View {
        
        ZStack {
            
            //background
            
            Rectangle()
                .foregroundColor(Color( red: 200/255, green:143/255, blue: 32/255))
                .edgesIgnoringSafeArea(.all)
            
            Rectangle().foregroundColor(Color(red: 228/255, green: 195/255, blue: 76/255)).rotationEffect(Angle(degrees: 50)) .edgesIgnoringSafeArea(.all)
            
                    
  VStack{
                Spacer()
                //Title
                HStack{
                    
                    Image(systemName: "star.fill") .foregroundColor(.yellow)
                    Text("SwiftUI Slots").bold().foregroundColor(.white)
                    Image(systemName: "star.fill") .foregroundColor(.yellow)
                    
                } .scaleEffect(2)
                Spacer()
                //credits counter
                
                Text("Credits: \(credits)")
                    .padding(.all, 10)
                    .background(Color.white.opacity(0.5))
                    .cornerRadius(20)
                
                Spacer()
                //Cards
    VStack{ Spacer()
                    HStack{
                        
                        Spacer()
                        
                        CardView(symbol:$symbols[numbers[0]], background: $backgrounds[0])
                        
                        CardView(symbol:$symbols[numbers[1]], background: $backgrounds[1])
                        
                        CardView(symbol:$symbols[numbers[2]], background: $backgrounds[2])
                        
                        Spacer()
                        
                    }
                    
                    HStack{
                        
                        Spacer()
                        
                        CardView(symbol:$symbols[numbers[3]], background: $backgrounds[3])
                        
                        CardView(symbol:$symbols[numbers[4]], background: $backgrounds[4])
                        
                        CardView(symbol:$symbols[numbers[5]], background: $backgrounds[5])
                        
                        Spacer()
                        
                    }
                    
                    HStack{
                        
                        Spacer()
                        
                        CardView(symbol:$symbols[numbers[6]], background: $backgrounds[6])
                        
                        CardView(symbol:$symbols[numbers[7]], background: $backgrounds[7])
                        
                        CardView(symbol:$symbols[numbers[8]], background: $backgrounds[8])
                        
                        Spacer()
                        
                   }
                    
         Spacer() }
                //buttons
    HStack (spacing: 55){
        VStack{
                    Button.init(action: {
                        if self.credits <= 0 {
                            Text("YOU DONT HAVE CREDITS")
                        }
                        else {self.processResults(IsMax: false)}
                        
                    })
                        { Text("Spin")
                            .bold()
                            .foregroundColor(Color.white)
                            .padding(.all,10)
                            .padding([.leading , .trailing], 30)
                            .background(Color.pink)
                            .cornerRadius(20)
                            
                           
                        }
        Text("\(betAmount) credits").padding(.top, 10).font(.footnote)
        
        }
         VStack{ Button.init(action: {
           if self.credits <= 0 {
                Text("YOU DONT HAVE CREDITS")
            }
            else {self.processResults(IsMax: true)}
                           
                       })
                           { Text("Max Spin")
                               .bold()
                               .foregroundColor(Color.white)
                               .padding(.all,10)
                               .padding([.leading , .trailing], 30)
                               .background(Color.pink)
                               .cornerRadius(20)
                               
                              
                           }
           Text("\(betAmount*5) credits").padding(.top, 10).font(.footnote)
           
        }
        
   }
//end HStack
                Spacer()}
             
        }
      
       
  
    }
    func processResults(IsMax:Bool){
         
         //Set back backgrounds to white
         self.backgrounds = self.backgrounds.map{_ in Color.white}
         
         if IsMax {
             //Spin all cards
             self.numbers =  self.numbers.map{_ in  Int.random(in: 0...self.symbols.count - 1 ) }
         }
         else{
             //Spin centre
             // change the images
             self.numbers[3] = Int.random(in: 0...self.symbols.count - 1 )
             self.numbers[4] = Int.random(in: 0...self.symbols.count - 1 )
             self.numbers[5] = Int.random(in: 0...self.symbols.count - 1 )
             
         }
         
        processWin(IsMax: IsMax)
         
     }
     
     
     func processWin(IsMax:Bool){
         var matches = 0
            if !IsMax{
             //processing for single spin
             if self.numbers[3] == self.numbers[4] && self.numbers[4] == self.numbers[5]{
                 //won
                 matches += 1
                 //Update backgrounds to green
                 self.backgrounds[3] = Color.green
                 self.backgrounds[4] = Color.green
                 self.backgrounds[5] = Color.green
                 
             }
         }
         else{
             // processing for maxSpin
             //Top checking
             
             if self.numbers[0] == self.numbers[1] && self.numbers[1] == self.numbers[2]{
                 //won
                 matches += 1
                 //Update backgrounds to green
                self.backgrounds[0] = Color.green
                 self.backgrounds[1] = Color.green
                 self.backgrounds[2] = Color.green
                }
             //Middle checking
             if self.numbers[3] == self.numbers[4] && self.numbers[4] == self.numbers[5]{
                            //won
                            matches += 1
                            //Update backgrounds to green
                            self.backgrounds[3] = Color.green
                            self.backgrounds[4] = Color.green
                            self.backgrounds[5] = Color.green
             }
             //bottom checking
             
            if self.numbers[6] == self.numbers[7] && self.numbers[7] == self.numbers[8]{
                 //won
                 matches += 1
                 //Update backgrounds to green
                 self.backgrounds[6] = Color.green
                 self.backgrounds[7] = Color.green
                 self.backgrounds[8] = Color.green
                
             }
             // diagonal top left to bottom right
             
           if self.numbers[0] == self.numbers[4] && self.numbers[4] == self.numbers[8]{
                 //won
                 matches += 1
                 //Update backgrounds to green
                 self.backgrounds[0] = Color.green
                 self.backgrounds[4] = Color.green
                 self.backgrounds[8] = Color.green
                
             }
             //diagonal top right to bottom left
             
          if self.numbers[2] == self.numbers[4] && self.numbers[4] == self.numbers[6]{
                 //won
                 matches += 1
                 //Update backgrounds to green
                 self.backgrounds[2] = Color.green
                 self.backgrounds[4] = Color.green
                 self.backgrounds[6] = Color.green
                }
        }
             // check matches and distrbute credits
             if matches>0 {
                 //at least 1 wins
                 self.credits += matches * (betAmount * 2)
             }
             else if !IsMax {
                 // 0 wins, single spin
                 self.credits -= betAmount
             }
             else{
                 // 0 wins,max spin
                 self.credits -= betAmount * 5
             }
         }
         
     }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}





