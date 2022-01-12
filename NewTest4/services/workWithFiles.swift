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
//    print((session["files"] as! Array<MyFile>))
}


func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//    let paths = FileManager.default.urls(for: ., in: .userDomainMask)
    let documentsDirectory = paths[0]
//    let documentsDirectory =
    return documentsDirectory
}


func decrypt_files(from_: String, to_: String, attachs: [MessagesResponse.Attach], completion: @escaping () -> Void) {
    let group = DispatchGroup()
    for attach in attachs {
        get_keys_from_server(from_: from_, to_: to_, group_: group) { response in
            let tripleDesKey = decrypt_tripleDesKey(privKey: response.keys.privKey, crypted_data: response.keys.tripleDesKey)
            let filebytes = To3DES.decrypt_for_file(text: Data(base64Encoded: attach.content, options: .ignoreUnknownCharacters)!, salt: tripleDesKey)!

            var fileurl = getDocumentsDirectory().appendingPathComponent(attach.name)

            let toint = filebytes.map(Int8.init)
            let backtobytes = toint.map(UInt8.init)
            let data = Data(backtobytes)
            try! data.write(to: fileurl)
        }
    }
    group.notify(queue: .main){
        completion()
    }
}
