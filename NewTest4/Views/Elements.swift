//
//  Elements.swift
//  NewTest4
//
//  Created by Никита Куркурин on 12.01.2022.
//

import SwiftUI

struct Elements: View {
    var body: some View {
        Text("Hello, World!")
    }
}

struct Elements_Previews: PreviewProvider {
    static var previews: some View {
        Elements()
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
                .alert(isPresented: $toast_about_receiver) {
                    Alert(title: Text("Введенный адрес невалиден"), dismissButton: .destructive(Text("Я его изменю")))
                }
//            .toast(isPresented: $toast_about_receiver,
//                    dismissAfter: 1.5)
//            {
//                receiver = ""
//                toast_about_receiver = false
//            } content: {
//                ToastView("Введенная почта невалидна")
//                        .toastViewStyle(ErrorToastViewStyle())
//            }
    }
}


struct SendMessageButton: View {
    @Binding var receiver: String
    @Binding var toast_about_receiver: Bool
    let login: String
    @Binding var subject: String
    @Binding var message_body: String
    @Binding var to_back: Bool


    var body: some View {
        Button {
            if receiver.contains("@") {
                if sendMessage(login: login, subject: subject, to: receiver, body: message_body) {
                    toast_about_receiver = true
                }
                else {
                    to_back = true
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

struct BackButton: View {
    let button_name: String
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            HStack(spacing: 0) {
                Image(systemName: "chevron.backward")
                Text(button_name)
            }.foregroundColor(.blue)
        }
    }
}
