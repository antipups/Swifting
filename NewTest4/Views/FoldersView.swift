//
//  FoldersView.swift
//  NewTest4
//
//  Created by Никита Куркурин on 07.01.2022.
//

import SwiftUI

struct FoldersView: View {
    let login: String
    @State var folders: [FoldersResponse.Folder] = []
    @State var loading = true
    
    var body: some View {
        ZStack{
            List{
                SendButton(login: login)
                ForEach(folders, id: \.id) { folder in
                    NavigationLink(destination: MailView(login: login,
                            folder: folder.title)) {
                        HStack {
                            Image(systemName: "folder")
                            Text(folder.title)
                        }
                    }.foregroundColor(.blue)
                }
            }
            if loading {
                LoaderView(text: "Получаю папки")
            }
        }
        .navigationBarTitle("Папки", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: BackButton(button_name: "Почты"))
        .onAppear {
            load_folders()
        }
        .refreshable {
            self.loading = true
            load_folders()
        }
    }
    
    func load_folders() {
        get_folders(login: login) { response in
            folders = response.folders
            self.loading = false
        }
    }
}

struct FoldersView_Previews: PreviewProvider {
    static var previews: some View {
        FoldersView(login: "Nkl54@mail.ru")
    }
}
