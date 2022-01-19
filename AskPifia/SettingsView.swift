//
//  SettingsView.swift
//  AskPifia
//
//  Created by Svitlana Bublyk on 14/01/2022.
//

import SwiftUI



struct SettingsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State  var possibleAnswer1: String
    @State  var possibleAnswer2: String
    @State  var possibleAnswer3: String
    @ObservedObject var defaultAnswers: PossibleAnswers
    
    
    var body: some View {
        NavigationView {
            List {
                VStack{
                    TextField("Add your answer", text:$possibleAnswer1)
                    
                }
                VStack{
                    TextField("Add your answer", text:$possibleAnswer2)
                }
                VStack{
                    TextField("Add your answer", text:$possibleAnswer3)
                }
                
            }
            .navigationTitle("Choose your answer")
            .navigationBarItems(trailing: Button("Save"){
                
                self.defaultAnswers.items[0].answerValue = possibleAnswer1
                self.defaultAnswers.items[1].answerValue = possibleAnswer2
                self.defaultAnswers.items[2].answerValue = possibleAnswer3
                self.presentationMode.wrappedValue.dismiss()
            }
            )
        }
    }
}

