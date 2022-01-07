//
//  MessageView.swift
//  NewTest4
//
//  Created by Никита Куркурин on 09.12.2021.
//

import SwiftUI

struct MessageView: View {
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
        Text(body_)
//        Text(from_ + text_)
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(title_: "title",
                    from_: "from",
                    when_: "when",
                    body_: "body")
    }
}
