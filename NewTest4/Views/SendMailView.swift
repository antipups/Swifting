//
//  SendMailView.swift
//  NewTest4
//
//  Created by Никита Куркурин on 09.12.2021.
//

import SwiftUI
import ToastUI


struct SendMailView: View {
    var login: String

//    не работает, почини
//    enum Field: Hashable {
//        case receiver
//        case subject
//        case message_body
//    }
//    .focused($fieldIsFocused, equals: .message_body)

    @State var receiver: String = ""
    @State var subject: String = ""
    @State var message_body: String = ""
    
    @State var filename: String = ""

    @State private var toast_about_receiver: Bool = false
//    @FocusState private var fieldIsFocused: Field?

    var body: some View {
        Form {
            Section {
                EmailInput(
                        receiver: $receiver,
                        toast_about_receiver: $toast_about_receiver,
                        placeholder: "Кому отправить")
                TextField("Тема письма", text: $subject)
                TextField("Тело письма", text: $message_body)
                ImportFiles(login: login)
            }

            Section {
                SendMessageButton(receiver: $receiver,
                        toast_about_receiver: $toast_about_receiver,
                        login: login,
                        subject: $subject,
                        message_body: $message_body
                )
            }
        }
        .navigationTitle("Отправка письма")
    }
}

struct SendMailView_Previews: PreviewProvider {
    static var previews: some View {
        SendMailView(login: "Nkl54@mail.ru")
    }
}


struct EmailInput: View {
    @Binding var receiver: String
    @Binding var toast_about_receiver: Bool
    let placeholder: String

    var body: some View {
        TextField(placeholder,
            text: $receiver,
            onEditingChanged: {editing_status in
                if !editing_status {
                    if !receiver.contains("@") {
                        toast_about_receiver = true
                    }
                }
            })
            .textContentType(.emailAddress)
            .keyboardType(.emailAddress)
            .toast(isPresented: $toast_about_receiver,
                    dismissAfter: 2.0)
            {
                receiver = ""
                toast_about_receiver = false
            } content: {
                ToastView("Введенная почта не валидна")
                        .toastViewStyle(ErrorToastViewStyle())
            }
    }
}


struct ImportFiles: View {
    let login: String
    @State var openfile = false

    var body: some View {
        Button {
            openfile.toggle()
        } label: {
            HStack {
                Text("Прикрепить файл")
                Image(systemName: "paperclip")
            }.foregroundColor(.blue)
        }
        .fileImporter(
                isPresented: $openfile,
                allowedContentTypes: [.pdf]
        ) { result in read_file(result, login: login) }
    }
}


struct SendMessageButton: View {
    @Binding var receiver: String
    @Binding var toast_about_receiver: Bool
    let login: String
    @Binding var subject: String
    @Binding var message_body: String

    var body: some View {
        Button {
            if receiver.contains("@") {
                if sendMessage(login: login, subject: subject, to: receiver, body: message_body) {
                    toast_about_receiver = false
                }
            }
        } label: {
            HStack {
                Text("Отправить письмо")
                Image(systemName: "arrowshape.turn.up.right")
            }
        }
    }
}