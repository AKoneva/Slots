//
//  CardView.swift
//  Slots Demo
//
//  Created by Macbook Pro on 05.08.2020.
//  Copyright © 2020 Macbook Pro. All rights reserved.
//

import SwiftUI

struct CardView: View {
    var body: some View {
  
        Image("apple").resizable()
                                  .aspectRatio(1, contentMode:.fit)
                                  .background(Color.white.opacity(0.5))
                                  .cornerRadius(20)
                              
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}
