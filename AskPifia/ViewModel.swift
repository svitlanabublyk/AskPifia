//
//  ViewModel.swift
//  AskPifia
//
//  Created by Svitlana Bublyk on 10/01/2022.
//

import Foundation


func updateAnsweredText(completion: @escaping (String) ->(), defaultAnswers: PossibleAnswers) {
    var answersToUse:Array<String> = []
    for answer in  defaultAnswers.items {
        answersToUse.append(answer.answerValue)
    }
    Api().getAnswer(completion: completion, defaultAnswers:answersToUse)
}



struct AnswerToAdd : Identifiable, Codable{
    var id = UUID()
    var answerValue: String
}


class PossibleAnswers: ObservableObject {
    
    @Published var items = [
        AnswerToAdd(answerValue: "Yes"),
        AnswerToAdd(answerValue: "No"),
        AnswerToAdd(answerValue: "Not sure")
    ]
}
