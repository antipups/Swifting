//
//  util.swift
//  NewTest4
//
//  Created by Никита Куркурин on 04.12.2021.
//

import Foundation
import SQLite


func add_mail(login: String, password: String) -> Bool {
    let mails = Mails()
    if check_mail(login: login, password: password) {
        return mails.add_mail(login: login, password: password)
    }
    else {
        return false
    }
}


func get_mails() -> Array<String> {
    return Mails().get_mails()
}


func get_password(login: String) -> String {
    return Mails().get_password(login: login)
}
