//
//  MailsListView.swift
//  NewTest4
//
//  Created by Никита Куркурин on 05.12.2021.
//

import SwiftUI


var session: Dictionary<String, Any> = ["files": []]


struct MailsListView: View {
    @State private var mails = get_mails()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    List
                    {
                        ForEach(mails, id: \.self) {mail_ in
                            NavigationLink(destination: FoldersView(login: mail_)) {
                                Image(systemName: "tray")
                                Text(mail_)
                            }
                            .foregroundColor(.blue)
                            .swipeActions {
                                Button(action: {
                                    delete_mail(mail: mail_)
                                    let index: Int = mails.firstIndex(of: mail_)!
                                    mails.remove(at: index)
                                }) {
                                    Image(systemName: "trash")
                                }.tint(.red)
                            }
                        }
                    }
                }
                Section {
                    NavigationLink(destination: AddMailView()) {
                        Image(systemName: "rectangle.stack.badge.plus")
                        Text("Добавить почту")
                    }.foregroundColor(.blue)
                }
                
            }
            .onAppear {
                mails = get_mails()
            }
            .navigationBarTitle("Выберите почту")
            .refreshable {
                mails = get_mails()
            }
            
        }
    }
    
}


struct MailsListView_Previews: PreviewProvider {
    static var previews: some View {
        MailsListView()
    }
}
