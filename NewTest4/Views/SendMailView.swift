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
    @State var to_back: Bool = false

    @State var receiver: String = ""
    @State var subject: String = ""
    @State var message_body: String = ""
    
    @State var filename: String = ""
    @State var openfile = false

    @State private var toast_about_receiver: Bool = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

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
//                ImportFiles(login: login, openfile: $openfile)
                Button {
                    openfile.toggle()
                    print(openfile)
                } label: {
                    HStack {
                        Text("Прикрепить файл")
                        Image(systemName: "paperclip")
                    }.foregroundColor(.blue)
                }
            }

            Section {
                SendMessageButton(receiver: $receiver,
                        toast_about_receiver: $toast_about_receiver,
                        login: login,
                        subject: $subject,
                        message_body: $message_body,
                        to_back: $to_back
                )
            }
        }
        .navigationTitle("Отправка письма")
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: BackButton(button_name: "Письма"))
        .onChange(of: to_back) { value in
            presentationMode.wrappedValue.dismiss()
        }
        .fileImporter(
                isPresented: $openfile,
                allowedContentTypes: [.pdf]
        ) { result in read_file(result, login: login) }
    }
}

struct SendMailView_Previews: PreviewProvider {
    static var previews: some View {
        SendMailView(login: "Nkl54@mail.ru")
    }
}


