//
//  ContentView.swift
//  NewTest4
//
//  Created by Никита Куркурин on 04.12.2021.
//

import SwiftUI

func test(){
//    print("lolka")
//    get_key_pair()
//    try_to_sign()
}

struct ContentView: View {
//    let a = crypt(text: "test")
    let a = test()
    @State var openfile = false
    @State var filename = ""
    
    var body: some View {
        ZStack {
            Color(.systemBackground)
            MailsListView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
