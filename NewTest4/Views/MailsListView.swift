//
//  MailsListView.swift
//  NewTest4
//
//  Created by Никита Куркурин on 05.12.2021.
//

import SwiftUI


struct MailsListView: View {
    let mails = get_mails()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    List
                    {
                        ForEach(mails, id: \.self) {mail_ in
                            NavigationLink(destination: MailView(login: mail_)) {
                                Image(systemName: "mail")
                                Text(mail_)
                            }.foregroundColor(.blue)
                        }
                    }
                }
                Section {
                    NavigationLink(destination: AddMailView()) {
                        Image(systemName: "rectangle.stack.badge.plus")
                        Text("Добавить почту")
                    }.foregroundColor(.blue)
                }
            }
            .navigationBarTitle("Выберите почту")
        }
    }
}


struct MailsListView_Previews: PreviewProvider {
    static var previews: some View {
        MailsListView()
    }
}
