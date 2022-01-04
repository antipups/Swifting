//
//  MailView.swift
//  NewTest4
//
//  Created by Никита Куркурин on 06.12.2021.
//

import SwiftUI

struct MailView: View {
    var login: String
    @State var messages: [Response.Message] = []
    @State var loading = true

    public init (login: String) {
        self.login = login
    }

    var body: some View {
        ZStack {
            List {
                Section {
                    NavigationLink(destination: SendMailView(login: login)){
                        HStack {
                            Image(systemName: "paperplane")
                            Text("Написать письмо")
                        }.foregroundColor(.blue)
                    }
                }
                Section {
                    ForEach(messages, id: \.id) { mail_ in
                        NavigationLink(destination: Text(mail_.subject)) {
                            //                Image(systemName: "mail")
                            VStack(alignment: .leading) {
                                Text(mail_.from)
        //                        Divider()
                                Text(mail_.subject).font(.system(size: 13))
                            }
                        }.foregroundColor(.blue)
                    }
                }
                
            }.onAppear { // Prefer, Life cycle method
                get_messages(login: login) { response in
                    messages = response.messages
                    self.loading = false
                }
            }
            if loading {
                ProgressView("Получаю письма")
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10)
                            .fill(Color(.systemBackground)))
                    .shadow(radius: 10)
            }
        }
        .navigationTitle("Доступные письма")
    }
}

struct MailView_Previews: PreviewProvider {
    static var previews: some View {
        MailView(login: "Nkl54@mail.ru")
    }
}
