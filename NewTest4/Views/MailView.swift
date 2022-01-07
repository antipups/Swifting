//
//  MailView.swift
//  NewTest4
//
//  Created by Никита Куркурин on 06.12.2021.
//
//  Описывается работа с почтовыми письмами
//

import SwiftUI

struct MailView: View {
    var login: String
    var folder: String
    @State var messages: [MessagesResponse.Message] = []
    @State var loading = true

    var body: some View {
        ZStack {
            List {
                SendButton(login: login)
                MessagesList(messages: $messages)
                
            }.onAppear { // Prefer, Life cycle method
                load_messages()
            }
            if loading {
                LoaderView(text: "Получаю письма")
            }
        }
        .navigationTitle("Доступные письма")
        .refreshable {
            self.loading = true
            load_messages()
        }
    }
    
    
    func load_messages() {
        get_messages(login: login,
                     folder: folder) { response in
            messages = response.messages
            self.loading = false
        }
    }
}

struct MailView_Previews: PreviewProvider {
    static var previews: some View {
        MailView(login: "Nkl54@mail.ru",
                 folder: "INBOX")
    }
}

struct SendButton: View {
    let login: String
    
    var body: some View {
        Section {
            NavigationLink(destination: SendMailView(login: login)){
                HStack {
                    Image(systemName: "paperplane")
                    Text("Написать письмо")
                }.foregroundColor(.blue)
            }
        }
    }
}


struct MessagesList: View {
    @Binding var messages: [MessagesResponse.Message]
    
    var body: some View {
        Section {
            ForEach($messages, id: \.id) { $mail_ in
                NavigationLink(destination: MessageView(
                    title_: mail_.subject,
                    from_: mail_.from,
                    when_: mail_.date,
                    body_: mail_.body
                )) {
                    VStack(alignment: .leading) {
                        Text(mail_.from)
                        Text(mail_.subject).font(.system(size: 13))
                    }
                }.foregroundColor(.blue)
            }
        }
    }
}


struct LoaderView: View {
    
    let text: String
    
    var body: some View {
        ProgressView(text)
            .padding()
            .background(RoundedRectangle(cornerRadius: 10)
                    .fill(Color(.systemBackground)))
            .shadow(radius: 10)
    }
}
