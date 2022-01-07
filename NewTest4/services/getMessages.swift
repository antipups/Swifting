//
//  getMessages.swift
//  NewTest4
//
//  Created by Никита Куркурин on 04.12.2021.
//


import Foundation

struct MessagesResponse: Codable {
    let status: String
    struct Message: Codable {
        let id: Int
        var subject: String
        let date: String
        let body: String
        var from: String
        let flags: [String]
    }
    let messages: [Message]
}

struct FoldersResponse: Codable {
    let status: String
    struct Folder: Codable {
        let id: String
        let title: String
    }
    let folders: [Folder]
}


extension String{
    var encodeUrl : String
    {
        return self.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
    }
    var decodeUrl : String
    {
        return self.removingPercentEncoding!
    }
}


func get_messages(login: String, folder: String, completion: @escaping ((MessagesResponse) -> Void)) {
//    get_password(login: login)
    let password = get_password(login: login)
    let url = "\(server_url)get_messages?login=\(login)&password=\(password)&folder=\(folder)"
    
    let request_url = URL(string: url.encodeUrl)
    
    URLSession.shared.dataTask(with: request_url!,
                               completionHandler: {data, response, error in
        guard let data = data, error == nil else {
            print("Smth went wrong")
            return
        }

        var result: Any?
        do {
            result = try JSONDecoder().decode(MessagesResponse.self, from: data)
        } catch {
            print("Failed to conver \(error.localizedDescription)")
        }

        guard let json = result else {
            print("Error equal")
            return
        }

        completion(json as! MessagesResponse)
    }).resume()
}


func get_folders(login: String, completion: @escaping ((FoldersResponse) -> Void)) {
//    get_password(login: login)
    let password = get_password(login: login)
    let url = "\(server_url)get_folders?login=\(login)&password=\(password)"

    URLSession.shared.dataTask(with: URL(string: url)!,
                               completionHandler: {data, response, error in
        guard let data = data, error == nil else {
            print("Smth went wrong")
            return
        }

        var result: Any?
        do {
            result = try JSONDecoder().decode(FoldersResponse.self, from: data)
        } catch {
            print("Failed to conver \(error.localizedDescription)")
        }

        guard let json = result else {
            print("Error equal")
            return
        }

        completion(json as! FoldersResponse)
    }).resume()
}
