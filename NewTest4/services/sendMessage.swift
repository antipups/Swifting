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
                hostname: server,     // SMTP server address
                email: login,       // username to login
                password: password           // password to login
//                port: login.contains("@mail.ru") ? 465 : 25
        )
        var send_error: Bool = false
        smtp.send(mail) { (error) in
            if let error = error {
                print(error)
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
        attachs
                .append(Attachment(
                        data: file.file_bytes,
                        mime: "application/\(String(describing: file.filename.split(separator: file_ext_sep).last))",
                        name: file.filename))
    }
    return attachs
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

        let mail: Mail = Mail(
            from: Mail.User(name: String(login.split(separator: "@")[0]), email: login),
            to: [Mail.User(name: "User", email: to)],
            subject: subject,
            text: (To3DES.encrypt(text: body.data(using: .utf8)!, salt: tripleDESKey)?.base64EncodedString())!,
            attachments: get_attachs()
        )

        let smtp = SMTP(
                hostname: server,
                email: login,
                password: password
//                port: login.contains("@mail.ru") ? 465 : 25
        )

        var send_error: Bool = false

        smtp.send(mail) { (error) in
            if let error = error {
                print(error)
                send_error = true
            }
        }
        return !send_error
    }
}
