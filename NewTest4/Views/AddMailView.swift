//
//  AddMailView.swift
//  NewTest4
//
//  Created by Никита Куркурин on 05.12.2021.
//

import SwiftUI
import AlertToast


struct AddMailView: View {
 
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var login: String = ""
    @State var password: String = ""
    
    @State private var showToast = false
    @State private var success_operation = false
    
    var body: some View {
        
        Form {
            Section {
                TextField("Логин", text: $login)
                TextField("Пароль", text: $password)
            }
            Section{
                Button {
                    success_operation = add_mail(login: login, password: password)
                    showToast = true
                    if success_operation {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                } label: {
                    HStack {
                        Image(systemName: "plus")
                        Text("Добавить")
                    }.frame(maxWidth: .infinity)
                }
            }
        }.frame(maxWidth: .infinity).toast(isPresenting: $showToast) {
            if success_operation {
                return AlertToast(type: .complete(.green), title: "Успешно")
            } else {
                return AlertToast(type: .error(.red), title: "Ошибка")
            }
        }
        .navigationTitle("Добавление почты")
}
}

struct AddMailView_Previews: PreviewProvider {
    static var previews: some View {
        AddMailView()
    }
}
