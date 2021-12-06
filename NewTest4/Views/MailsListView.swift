//
//  MailsListView.swift
//  NewTest4
//
//  Created by Никита Куркурин on 05.12.2021.
//

import SwiftUI

struct MailsListView: View {
    var body: some View {
        NavigationView {
            Form {
                Section {
                    
                }
                Section {
                    NavigationLink(destination: AddMailView()) {
                        Image(systemName: "rectangle.stack.badge.plus")
                        Text("Добавить почту")
                    }.foregroundColor(.blue)
                }
            }
            .navigationBarTitle("Выберите почту")
        }
    }
}


struct MailsListView_Previews: PreviewProvider {
    static var previews: some View {
        MailsListView()
    }
}
