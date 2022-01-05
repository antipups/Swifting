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
    
    enum Field: Hashable {
        case login
        case password
    }
    
    @State var login: String = ""
    @State var password: String = ""
    
    @State private var showToast = false
    @State private var success_operation = false
        
    @FocusState private var emailFieldIsFocused: Field?
    
    var body: some View {
        
        Form {
            Section {
                TextField("Логин", text: $login)
                    .disableAutocorrection(true)
                    .focused($emailFieldIsFocused, equals: .login)
                
                SecureField("Пароль", text: $password)
                    .disableAutocorrection(true)
                    .focused($emailFieldIsFocused, equals: .password)
            }
            Section{
                Button {
                    if login.isEmpty {
                        emailFieldIsFocused = .login
                    } else if password.isEmpty {
                        emailFieldIsFocused = .password
                    } else {
                        success_operation = add_mail(login: login, password: password)
                        showToast = true
                        if success_operation {
                            self.presentationMode.wrappedValue.dismiss()
                        }
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
