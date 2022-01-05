//
//  SendMailView.swift
//  NewTest4
//
//  Created by Никита Куркурин on 09.12.2021.
//

import SwiftUI


struct SendMailView: View {
    var login: String
    
    @State var receiver: String = ""
    @State var subject: String = ""
    @State var message_body: String = ""
    
    @State var filename: String = ""
    @State var openfile = false
    
    var body: some View {
        Form {
            Section {
                TextField("Куда отправить", text: $receiver)
                    .disableAutocorrection(true)
                TextField("Тема письма", text: $subject)
                TextField("Тело письма", text: $message_body)
//                    .frame(height: UIScreen.main.bounds.size.height * 0.5)
                Button {
                    openfile.toggle()
                } label: {
                    HStack {
                        Text("Прикрепить файл")
                        Image(systemName: "paperclip")
                    }.foregroundColor(.blue)
                }
                .fileImporter(isPresented: $openfile, allowedContentTypes: [.pdf]) { (res) in
                    do {
                        let fileurl = try res.get()
                        print(fileurl)
                        
                        self.filename = fileurl.lastPathComponent
                        print(self.filename)
                    } catch {
                        
                    }
                }
                
            }
            Section {
                Button {
                    print("tap")
                } label: {
                    HStack {
                        Text("Отправить письмо")
                        Image(systemName: "arrowshape.turn.up.right")
                    }
                }
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
