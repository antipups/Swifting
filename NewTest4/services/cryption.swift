//
//  cryption.swift
//  NewTest4
//
//  Created by Никита Куркурин on 08.12.2021.
//

import Foundation
import Cryptor
import CryptorRSA
import SwCrypt


class To3DES {
    
    static func key_generation() -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length3DESKey).map{ _ in letters.randomElement()! })
    }
    
    public static func encrypt(text: Data, salt: String) -> Data? {
        let key = Array(salt.utf8)
        let bytes = Array(text)
        let cryptor = try! Cryptor(
                operation: .encrypt,
                algorithm: .tripleDes,
                options: [.ecbMode, .pkcs7Padding],
                key: key,
                iv:[UInt8]()
        )
        if let encrypted = cryptor.update(byteArray: bytes)?.final() {
            return Data(encrypted)
        }
        return nil
    }

    public static func decrypt(text: Data, salt: String) -> String? {
        let key = Array(salt.utf8)
        let bytes = [UInt8](text)
        let cryptor = try! Cryptor(
                operation: .decrypt,
                algorithm: .tripleDes,
                options: [.ecbMode, .pkcs7Padding ],
                key: key,
                iv:[UInt8]()
        )
        if let decrypted = cryptor.update(byteArray: bytes)?.final() {
            return String(bytes: decrypted, encoding: .utf8)
        }
        return nil
    }
}


func get_key_pair_with_triple_des() -> (String, String, String) {
    let (privateKey, publicKey) = try! CC.RSA.generateKeyPair(lengthRSAKeys)
    let privateKeyPEM = SwKeyConvert.PrivateKey.derToPKCS1PEM(privateKey)
    let publicKeyPEM = SwKeyConvert.PublicKey.derToPKCS8PEM(publicKey)
    return (privateKeyPEM, publicKeyPEM, To3DES.key_generation())
}


//func crypt(text: String) -> String?{
//
////    let publicKey = try! CryptorRSA.createPublicKey(with: "Sex".data(using: .utf8)!)
//
//    return To3DES.key_generation()
//
////    let key = "123"
////    let data = "sex"
////
////    print("Просто текст - \(text)")
////    let enctrypt_text = To3DES.encrypt(text: text, salt: key)
////    print("Зашифрованный текст - \(enctrypt_text)")
////    let decrypt_text = To3DES.decrypt(text: enctrypt_text!, salt: key)
////    print("Расшифрованный текст - \(decrypt_text!)")
////    return ""
////    let algorithm: SecKeyAlgorithm = .ecdsaSignatureRFC4754
//
//}

func try_to_sign(){
//    let (privateKey, publicKey, tripleDESKey) = get_keys(mail: "Nkl54@mail.ru")
//    let salt = "12345678912345678"
//    let encrypted = To3DES.encrypt(text: "asdhuashduahusdhiuasdasd".data(using: .utf8)!, salt: salt)
//    print(encrypted!)
//    let decrypt = To3DES.decrypt(text: encrypted!, salt: salt)
//    print(decrypt)

//    let testMessage = "Sex".data(using: .utf8)
//    let testMessage1 = "Sex2".data(using: .utf8)
//    let (privateKey, publicKey) = try! CC.RSA.generateKeyPair(2048)
//    let sign = try? CC.RSA.sign(
//            testMessage!,
//            derKey: privateKey,
//            padding: .pss,
//            digest: .sha1,
//            saltLen: 16)
//    let verified = try? CC.RSA.verify(
//            testMessage1!,
//            derKey: publicKey,
//            padding: .pss,
//            digest: .sha1,
//            saltLen: 16,
//            signedData: sign!
//    )
//    print(sign)
//    print(verified)
}


//func create_signature(data: Data, login: String) {
//    let (privateKey, publicKey, tripleDESKey) = get_keys(mail: login)
////    let sign = try? CC.RSA.sign(
////            data,
////            derKey: SwKeyConvert.PrivateKey.pemToPKCS1DER(privateKey),
////            padding: .pss,
////            digest: .sha1,
////            saltLen: 16
////    )
//    let encrypted = To3DES.encrypt(text: "Sex".data(using: .utf8)!, salt: tripleDESKey)
//    let decrypt = To3DES.decrypt(text: encrypted!, salt: tripleDESKey)
//    print(decrypt)
//    return
//}
