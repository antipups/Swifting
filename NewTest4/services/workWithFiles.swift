//
//  workWithFiles.swift
//  NewTest4
//
//  Created by Никита Куркурин on 09.12.2021.
//

import Foundation


func read_file(_ result: Result<URL, Error>){
    do {

        let selectedFile: URL

        switch result {
        case .failure(_):
            return
        case .success(let temp_url):
            selectedFile = temp_url
        }

        do {
            // get access to open file
            if selectedFile.startAccessingSecurityScopedResource() {
                let path = selectedFile.path
                let data = NSData(contentsOfFile: path)
                print(data)
                selectedFile.stopAccessingSecurityScopedResource()
            }

        } catch {
            // Couldn't read the file.
            print(error.localizedDescription)
        }

    } catch {
        print("error")
    }
}
