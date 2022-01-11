//
//  AddMailView.swift
//  NewTest4
//
//  Created by Никита Куркурин on 05.12.2021.
//

import SwiftUI
import ToastUI



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
                EmailInput(receiver: $login,
                        toast_about_receiver: $showToast,
                        placeholder: "Логин").focused($emailFieldIsFocused, equals: .login)
                
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
                        if !success_operation {
                            showToast = true
                        }
                    }
                    
                } label: {
                    HStack {
                        Image(systemName: "plus")
                        Text("Добавить")
                    }.frame(maxWidth: .infinity)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .toast(isPresented: $showToast,
                dismissAfter: 1.5)
        {
            login = ""
        } content: {
            ToastView("Ошибка авторизации")
                    .toastViewStyle(ErrorToastViewStyle())
        }
        .toast(isPresented: $success_operation,
                dismissAfter: 1.5)
        {
            presentationMode.wrappedValue.dismiss()
        } content: {
            ToastView("Авторизация успешна")
                    .toastViewStyle(SuccessToastViewStyle())
        }
        .navigationTitle("Добавление почты")
    }
}

struct AddMailView_Previews: PreviewProvider {
    static var previews: some View {
        AddMailView()
    }
}
