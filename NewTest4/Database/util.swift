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
    Mails().get_mails()
}


func get_password(login: String) -> String {
    Mails().get_password(login: login)
}


func delete_mail(mail: String) {
    Mails().delete_mail(mail_: mail)
}


func get_keys(mail: String) -> (String, String, String) {
    Mails().get_keys(mail_: mail)
}


func get_tripleDesKey(mail: String) -> String {
    Mails().get_tripleDesKey(mail_: mail)
}


func is_sended_keys(from_: String, to_: String) -> Bool {
    Relations().is_sended_keys(sender: from_, receiver: to_)
}


func create_relation(from_: String, to_: String) {
    Relations().create_relation(sender: from_, receiver: to_)
}


func delete_relations(from_: String, to_: String) {
    Relations().remove_relation(sender: from_, receiver: to_)
}