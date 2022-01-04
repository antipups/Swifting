//
//  workWithFiles.swift
//  NewTest4
//
//  Created by Никита Куркурин on 09.12.2021.
//

import Foundation


func read_file(filepath: URL){
//    var genbuf:[UInt8] = [UInt8]()
//
//    if let stream:InputStream = InputStream(fileAtPath: filepath) {
//        var buf:[UInt8] = [UInt8](repeating: 0, count: 16)
//        stream.open()
//
//        while true {
//            let len = stream.read(&buf, maxLength: buf.count)
//            print("len \(len)")
//            for i in 0..<len {
//                print(String(format:"%02x ", buf[i]), terminator: "")
//                genbuf.append(buf[i])
//            }
//            if len < buf.count {
//                break
//            }
//        }
//        stream.close()
//    }
//    print(genbuf)
    
    
//    guard let fileUrl: URL = Bundle.main.url(forResource: filepath, withExtension: "pdf") else {
//        print("error !!")
//        return
//    }
    
    do {
            // Get the raw data from the file.
        let rawData: Data = try! Data(contentsOf: filepath)

        // Return the raw data as an array of bytes.
        print([UInt8](rawData))
        
    } catch {
        // Couldn't read the file.
        print("error")
    }
}
