//
//  workWithFiles.swift
//  NewTest4
//
//  Created by Никита Куркурин on 09.12.2021.
//

import Foundation


func read_file(_ result: Result<URL, Error>){

    var arraybytes: NSData!

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
                arraybytes = try NSData(contentsOfFile: path)
//                print(arraybytes?.base64EncodedString())
                selectedFile.stopAccessingSecurityScopedResource()
            }

        } catch {
            // Couldn't read the file.
            print(error.localizedDescription)
        }

    } catch {
        print("error")
    }

    if var files = session["files"] {
        (files as AnyObject).append(arraybytes.base64EncodedString())
    }
    else {
        session["files"] = [arraybytes.base64EncodedString()]
    }
    print(session.count)
}
