//
//  services.swift
//  NewTest4
//
//  Created by Никита Куркурин on 04.12.2021.
//


import SwiftSMTP


func get_messages(login: String){
    get_password(login: login)
}


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
        do {
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
        } catch {
            return false
        }
        
    }
}
