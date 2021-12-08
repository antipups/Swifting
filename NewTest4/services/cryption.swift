//
//  cryption.swift
//  NewTest4
//
//  Created by Никита Куркурин on 08.12.2021.
//

import Foundation
import Cryptor
import CryptorRSA


class To3DES {
    
    static func key_generation() -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<32).map{ _ in letters.randomElement()! })
    }
    
    public static func encrypt(text: String, salt: String) -> String? {
        let key = Array(salt.utf8)
        let bytes = Array(text.utf8)
        let cryptor = try! Cryptor(operation: .encrypt, algorithm: .tripleDes, options: [.ecbMode, .pkcs7Padding], key: key, iv:[UInt8]())
        if let encrypted = cryptor.update(byteArray: bytes)?.final() {
            return Data(encrypted).base64EncodedString()
        }
        return nil
    }

    public static func decrypt(text: String, salt: String) -> String? {
        let key = Array(salt.utf8)
        let bytes = [UInt8](Data(base64Encoded: text)!)
        let cryptor = try! Cryptor(operation: .decrypt, algorithm: .tripleDes, options: [.ecbMode, .pkcs7Padding ], key: key, iv:[UInt8]())
        if let decrypted = cryptor.update(byteArray: bytes)?.final() {
            return String(bytes: decrypted, encoding: .utf8)
        }
        return nil
    }
}


func crypt(text: String) -> String?{
    
//    let publicKey = try! CryptorRSA.createPublicKey(with: "Sex".data(using: .utf8)!)
    
    return To3DES.key_generation()
//    let key = "123"
//    let data = "sex"
//
//    print("Просто текст - \(text)")
//    let enctrypt_text = To3DES.encrypt(text: text, salt: key)
//    print("Зашифрованный текст - \(enctrypt_text)")
//    let decrypt_text = To3DES.decrypt(text: enctrypt_text!, salt: key)
//    print("Расшифрованный текст - \(decrypt_text!)")
//    return ""
//    let algorithm: SecKeyAlgorithm = .ecdsaSignatureRFC4754
    
}


