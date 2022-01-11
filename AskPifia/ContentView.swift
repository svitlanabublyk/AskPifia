//
//  ContentView.swift
//  AskPifia
//
//  Created by Svitlana Bublyk on 10/01/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var settings = false
    
    
    var body: some View {
        NavigationView {
            
            VStack {
                Text("Ask and shake me!")
                    .padding(.horizontal)
                HStack {
                    Image(systemName: "arrow.clockwise")
                        .onTapGesture {
                        // update text onscreen
                    }
                    .padding()
                }
            }
            .navigationBarItems(trailing: Button(action: {
                self.settings = true
            }) {
                Image(systemName: "gearshape")
                    .foregroundColor(.gray)
            }
            )
        }
    }
}









struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
