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


class Api{
    func getAnswer (completion: @escaping (Answer) ->()) {
        let apiAnswer = "https://8ball.delegator.com/magic/JSON/question_string"
        guard let url = URL(string: apiAnswer)
        else {return}
        URLSession.shared.dataTask(with: url) { (data, _, _)  in
            let answer = try! JSONDecoder().decode(Answer.self, from: data!)
            DispatchQueue.main.async {
                completion(answer)
            }
        }
        .resume()
    }
}






