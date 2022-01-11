//
// Created by Никита Куркурин on 10.01.2022.
//

import Foundation


func set_seen(login: String, uid: Int, completion: @escaping () -> Void) {
    let password = get_password(login: login)
    let url = "\(server_url)set_seen?login=\(login)&password=\(password)&uid=\(uid)"

    URLSession.shared.dataTask(with: URL(string: url)!,
    completionHandler: {data, response, error in
        completion()
    }).resume()
}
