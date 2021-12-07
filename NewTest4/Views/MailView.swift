//
//  MailView.swift
//  NewTest4
//
//  Created by Никита Куркурин on 06.12.2021.
//

import SwiftUI

struct MailView: View {
    var messages: [Any]
    
    var body: some View {
//        NavigationView {
//            ForEach(mails, id: \.self) {mail_ in
//                NavigationLink(destination: MailView(login: mail_)) {
//                    Image(systemName: "mail")
//                    Text(mail_)
//                }.foregroundColor(.blue)
//            }
//            .navigationTitle("Доступные письма")
//        }
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct MailView_Previews: PreviewProvider {
    static var previews: some View {
        MailView(messages: [1, 1])
    }
}
