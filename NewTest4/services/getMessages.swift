//
//  getMessages.swift
//  NewTest4
//
//  Created by Никита Куркурин on 04.12.2021.
//


import Foundation

struct Response: Codable {
    let status: String
    struct Message: Codable {
        let id: Int
        let subject: String
        let date: String
        let body: String
        let from: String
        let flags: [String]
    }
    let messages: [Message]
}


func get_messages(login: String, completion: @escaping ((Response) -> Void)) {
//    get_password(login: login)
    let password = get_password(login: login)
    let url = "http://127.0.0.1:8000/get_messages?login=\(login)&password=\(password)"

    URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {data, response, error in
        guard let data = data, error == nil else {
            print("Smth went wrong")
            return
        }

        var result: Any?
        do {
            result = try JSONDecoder().decode(Response.self, from: data)
        } catch {
            print("Failed to conver \(error.localizedDescription)")
        }

        guard let json = result else {
            print("Error equal")
            return
        }

        completion(json as! Response)
    }).resume()
}


