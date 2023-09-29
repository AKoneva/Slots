//
//  CardView.swift
//  Slots Demo
//
//  Created by Macbook Pro on 05.08.2020.
//  Copyright © 2020 Macbook Pro. All rights reserved.
//

import SwiftUI

struct CardView: View {
    private let translition = AnyTransition.move(edge: .bottom)
    
    @Binding var symbol: String
    @Binding var background: Color
    
    var body: some View {
        VStack {
                Image(symbol)
                    .resizable()
                    .aspectRatio(contentMode:.fit)
                    .transition(.slide)
                    .animation(.easeInOut, value: symbol)
        }
        .background(background.opacity(0.5))
        .cornerRadius(20)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(symbol: Binding.constant("apple"),
                 background: Binding.constant(Color.gray))
    }
}
