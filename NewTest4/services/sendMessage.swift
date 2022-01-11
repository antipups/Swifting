//
//  sendMessage.swift
//  NewTest4
//
//  Created by Никита Куркурин on 08.12.2021.
//

import Foundation
import SwiftSMTP


func get_server(login: String) -> String {
    if login.contains("@mail.ru") {
        return "smtp.mail.ru"
    } else if login.contains("@yandex.ru") {
        return "smtp.yandex.ru"
    } else {
        return "Error"
    }
}


func check_mail(login: String, password: String) -> Bool {
    let server = get_server(login: login)

    if server == "Error" {
        return false
        
    } else {
        let mail = Mail(
                from: Mail.User(name: "Application", email: login),
                to: [Mail.User(name: "User", email: login)],
                subject: "Авторизация",
                text: "Вы авторизированны в данном приложении"
        )
        let smtp = SMTP(
                hostname: server,
                email: login,
                password: password
        )
        var send_error: Bool = false
        smtp.send(mail) { (error) in
            if let error = error {
                print("Error in sending mail - ", error)
                send_error = true
            }
        }
        return !send_error
    }
}


func get_attachs() -> Array<Attachment> {
    var attachs: Array<Attachment> = []
    let files: Array<MyFile> = session["files"] as! Array<MyFile>
    let file_ext_sep: Character = "."

    for file in files {
        attachs.append(
                Attachment(
                        data: file.file_bytes,
                        mime: "application/\(String(describing: file.filename.split(separator: file_ext_sep).last))",
                        name: file.filename))
    }
    session["files"] = []
    return attachs
}


struct SendKeys: Codable {
    let from_email: String
    let to_email: String
    let privKey: String
    let pubKey: String
    let tripleDesKey: String
}


func create_relation_on_mails(from_email: String,
                              to_email: String,
                              privkey: String,
                              pubkey: String,
                              tripleDesKey: String,
                              completion: @escaping (String) -> Void) {
    let url = URL(string: "\(server_url)set_keys")

    var request = URLRequest(url: url!)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = try! JSONEncoder().encode(SendKeys(from_email: from_email,
            to_email: to_email,
            privKey: privkey,
            pubKey: pubkey,
            tripleDesKey: tripleDesKey))

    URLSession.shared.dataTask(with: request,
        completionHandler: {data, response, error in
            completion("Top")
        }).resume()
}


func sendMessage(login: String,
                 subject: String,
                 to: String,
                 body: String) -> Bool{
    let password = get_password(login: login)

    let server = get_server(login: login)

    if server == "Error" {
        return false

    } else {
        let (privateKey, publicKey, tripleDESKey) = get_keys(mail: login)

        let attachs = get_attachs()

        let mail: Mail = Mail(
            from: Mail.User(name: login, email: login),
            to: [Mail.User(name: "User", email: to)],
            subject: (To3DES.encrypt(text: subject.data(using: .utf8)!, salt: tripleDESKey)?.base64EncodedString())!,
            text: (To3DES.encrypt(text: body.data(using: .utf8)!, salt: tripleDESKey)?.base64EncodedString())!,
            attachments: attachs
        )

        let smtp = SMTP(
                hostname: server,
                email: login,
                password: password
//                port: login.contains("@mail.ru") ? 58 : 25
        )

        var send_error: Bool = false

//        delete_relations(from_: login, to_: to)

        if !is_sended_keys(from_: login, to_: to) {
            create_relation(from_: login, to_: to)
            create_relation_on_mails(
                    from_email: login,
                    to_email: to,
                    privkey: privateKey,
                    pubkey: publicKey,
                    tripleDesKey: get_tripleDesKey(mail: login)
            ) { result in
                print(result)
            }
        }

        smtp.send(mail) { (error) in
            if let error = error {
                print(error)
                send_error = true
            }
        }
        return send_error
    }
}
