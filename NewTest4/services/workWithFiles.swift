//
//  workWithFiles.swift
//  NewTest4
//
//  Created by Никита Куркурин on 09.12.2021.
//

import Foundation


struct MyFile {
    let filename: String
    let file_bytes: Data
}


func read_file(_ result: Result<URL, Error>, login: String){

    var arraybytes: NSData!

    let selectedFile: URL

    switch result {
    case .failure(_):
        return
    case .success(let temp_url):
        selectedFile = temp_url
    }

    if selectedFile.startAccessingSecurityScopedResource() {
        let path = selectedFile.path
        arraybytes = NSData(contentsOfFile: path)
        selectedFile.stopAccessingSecurityScopedResource()
    }


    let filename: String = selectedFile.pathComponents.last!
    let (_, _, tripleDesKey) = get_keys(mail: login)
    let encrypt_file = To3DES.encrypt(text: arraybytes as Data, salt: tripleDesKey)!

    let file: MyFile = MyFile(
        filename: filename,
        file_bytes: encrypt_file
    )

    var temp_files: Array<Any>

    if let files = session["files"] {
        temp_files = Array(arrayLiteral: files)[0] as! Array<Any>
        temp_files.append(file)
    }
    else {
        temp_files = [file]
    }
    session["files"] = temp_files
    print((session["files"] as! Array<MyFile>))
}
