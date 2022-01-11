//
//  MessageView.swift
//  NewTest4
//
//  Created by Никита Куркурин on 09.12.2021.
//

import SwiftUI

struct MessageView: View {
    let login: String
    let id_: Int
    let title_: String
    let from_: String
    let when_: String
    let body_: String

    var body: some View {
        Text(title_)
        Divider()
        HStack{
            Text(from_).font(.system(size: 10))
            Text(when_).font(.system(size: 10))
        }
        Divider()
        Text(body_).onAppear {
            set_seen(login: login, uid: id_) {  }
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(login: "Login",
                    id_: 123,
                    title_: "title",
                    from_: "from",
                    when_: "when",
                    body_: "body")
    }
}
