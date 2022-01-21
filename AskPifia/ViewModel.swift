//
//  ViewModel.swift
//  AskPifia
//
//  Created by Svitlana Bublyk on 10/01/2022.
//

import Foundation

/**
 Call API Model and transform to answers
  - Parameters:
    - completion: clouser for  setting answer
    - defaultAnswers: possible answers that could be used as default answers
 */
func updateAnsweredText(completion: @escaping (String) ->(), defaultAnswers: PossibleAnswers) {
    var answersToUse:Array<String> = []
    for answer in  defaultAnswers.items {
        answersToUse.append(answer.answerValue)
    }
    Api().getAnswer(completion: completion, defaultAnswers:answersToUse)
}


///  Answers that you can set by yourself
struct AnswerToAdd : Identifiable, Codable{
    var id = UUID()
    var answerValue: String
}

/// Answers could be used by default
class PossibleAnswers: ObservableObject {
    
    @Published var items = [
        AnswerToAdd(answerValue: "Yes"),
        AnswerToAdd(answerValue: "No"),
        AnswerToAdd(answerValue: "Not sure")
    ]
}
