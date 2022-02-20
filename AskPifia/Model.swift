//
//  Model.swift
//  AskPifia
//
//  Created by Svitlana Bublyk on 10/01/2022.
//

import Foundation

/// Package with data-answers from API
struct Answer: Decodable {
    var magic: Request
}

/// Package with question, answer and type
struct Request: Decodable {
    var question: String
    var answer: String
    var type: String
}

///  Class which gets data from API
class Api {

    ///  URL to API with data
    private var apiUrl: String

    ///  Constructor
    init(apiUrl: String) {
        self.apiUrl = apiUrl
    }

    /// API setter
    func setApiUrl(apiUrl: String) {
        self.apiUrl = apiUrl
    }

    /**
     Call API, get  and decode data.
     
     - Parameters:
       - completion: clouser for setting answer.
       - defaultAnswers: array with with default answers,  use random order  if API is not avalible.
    */
    func getAnswer(completion: @escaping (String) -> Void, defaultAnswers: [String]) {
        guard let url = URL(string: self.apiUrl)
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
