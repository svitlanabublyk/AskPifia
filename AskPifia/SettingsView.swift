//
//  SettingsView.swift
//  AskPifia
//
//  Created by Svitlana Bublyk on 14/01/2022.
//

import SwiftUI

/// View with settings
struct SettingsView: View {

    @Environment(\.presentationMode) var presentationMode
    /// Possible answer1
    @State  var possibleAnswer1: String
    /// Possible answer2
    @State  var possibleAnswer2: String
    /// Possible answer3
    @State  var possibleAnswer3: String
    /// Variable with default answers
    @ObservedObject var defaultAnswers: PossibleAnswers

    var body: some View {
        NavigationView {
            List {
                VStack {
                    TextField("Add your answer", text: $possibleAnswer1)
                }
                VStack {
                    TextField("Add your answer", text: $possibleAnswer2)
                }
                VStack {
                    TextField("Add your answer", text: $possibleAnswer3)
                }
            }
            .navigationTitle("Default answers")
            .navigationBarItems(trailing: Button("Save") {

                self.defaultAnswers.items[0].answerValue = possibleAnswer1
                self.defaultAnswers.items[1].answerValue = possibleAnswer2
                self.defaultAnswers.items[2].answerValue = possibleAnswer3
                self.presentationMode.wrappedValue.dismiss()
            }
            )
        }
    }
}
