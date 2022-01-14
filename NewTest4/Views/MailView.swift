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
                MessagesList(login: login, messages: $messages)
            }.onAppear {
                load_messages()
            }
            if loading {
                LoaderView(text: "Получаю письма")
            }
        }
        .navigationTitle("Письма")
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: BackButton(button_name: "Папки"))
        .refreshable {
            self.loading = true
            load_messages()
        }
    }
    
    
    func load_messages() {
        get_messages(login: login,
                     folder: folder) { response in
            decrypt_messages(messages: response.messages,
                                        login: login) { new_messages in
                messages = new_messages.sorted { message, message2 in
                    message.id > message2.id
                }
            }
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


func prepare_subject(body: String) -> String{
    body.count > 15 ? (String(body.prefix(10)) + "...") : body
}


func prepare_body(body: String) -> String{
    String(body.prefix(15)).replacingOccurrences(of: "\n", with: " ") + "..."
}


struct MessagesList: View {
    let login: String
    @Binding var messages: [MessagesResponse.Message]
    
    var body: some View {
        Section {
            ForEach($messages, id: \.id) { $mail_ in
                NavigationLink(destination: MessageView(
                    login: login,
                    id_: mail_.id,
                    title_: mail_.subject,
                    from_: mail_.from,
                    when_: mail_.date,
                    body_: mail_.body,
                    attachs: mail_.attachments
                )) {
                    HStack {
                        Image(systemName: mail_.flags.contains("\\Seen") ? "envelope.open" : "envelope.fill").foregroundColor(.blue)
                        VStack(alignment: .leading) {
                            Text(mail_.from)
                            HStack {
                                Text("[" + prepare_subject(body: mail_.subject) + "]")
                                        .font(.system(size: 13, weight: .bold))
                                Text(prepare_body(body: mail_.body)).font(.system(size: 13))
                            }
                        }
                    }
                }
                .foregroundColor(.blue)
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
