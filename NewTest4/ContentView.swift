//
//  ContentView.swift
//  NewTest4
//
//  Created by Никита Куркурин on 04.12.2021.
//

import SwiftUI

func test(){
    print("lolka")
}

struct ContentView: View {
    let a = crypt(text: "sex")
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
