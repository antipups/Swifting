//
//  util.swift
//  NewTest4
//
//  Created by Никита Куркурин on 04.12.2021.
//

import Foundation


func add_mail(login: String, password: String) -> Bool {
    let mails = Mails()
    return mails.add_mail(login: login, password: password)
}
