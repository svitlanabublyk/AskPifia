//
//  Model.swift
//  AskPifia
//
//  Created by Svitlana Bublyk on 10/01/2022.
//

import Foundation



struct Answer: Decodable {
    var magic: Request
}


struct Request: Decodable {
    var question: String
    var answer: String
    var type: String
    
}


class Api {
    func getAnswer(completion: @escaping (String) ->(), defaultAnswers: Array<String>) {
        let apiAnswer = "https://8ball.delegator.com/magic/JSON/question_string"
        guard let url = URL(string: apiAnswer)
        else {return}
        URLSession.shared.dataTask(with: url) { (rawData, _, _)  in
            let answer: String
            if let data = rawData {
                answer = try! JSONDecoder().decode(Answer.self, from: data).magic.answer
                
            } else {
                answer = defaultAnswers.randomElement() ?? "Ooops, something went wrong!"
            }
            DispatchQueue.main.async {
                completion(answer)
            }
        }
        .resume()
    }
}





