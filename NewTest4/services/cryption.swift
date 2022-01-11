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

    return (privateKeyPEM, publicKeyPEM, crypt_tripleDesKey(pubKey: publicKey, tripleDesKey: To3DES.key_generation()))
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
//
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
//
//    sign?.base64EncodedString()
//    print(sign)
//    print(verified)
//    crypt_tripleDesKey(privKey: "asd", tripleDesKey: "123")
//    check_mail(login: "nick-kurkurin@yandex.ru", password: "fyvyjlvhsqbqdqrc")
//    check_mail(login: "gosha.mar.gosha@yandex.ru", password: "dygyuslobhldzanb")
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


func crypt_tripleDesKey(pubKey: Data, tripleDesKey: String) -> String {
//    let privateKeyDER = try! SwKeyConvert.PrivateKey.pemToPKCS1DER(privKey)
    let publicKeyDER = pubKey

    let crypted_data = try! CC.RSA.encrypt(tripleDesKey.data(using: .utf8)!, derKey: publicKeyDER, tag: "L".data(using: .utf8)!, padding: .oaep, digest: .sha1)
//    let (encrypted_data, status) = try! CC.RSA.decrypt(crypted_data, derKey: privateKeyDER, tag: "L".data(using: .utf8)!, padding: .oaep, digest: .sha1)
//
//    return String(decoding: encrypted_data, as: UTF8.self)
    return crypted_data.base64EncodedString()
}


func decrypt_tripleDesKey(privKey: String, crypted_data: String) -> String {
    let privateKeyDER = try! SwKeyConvert.PrivateKey.pemToPKCS1DER(privKey)
//    let publicKeyDER = try! SwKeyConvert.PublicKey.pemToPKCS1DER(pubKey)
    let crypted_data_bytes = Data(base64Encoded: crypted_data, options: .ignoreUnknownCharacters)!

//    let crypted_data = try! CC.RSA.encrypt(tripleDesKey.data(using: .utf8)!, derKey: publicKeyDER, tag: "L".data(using: .utf8)!, padding: .oaep, digest: .sha1)
    let (encrypted_data, _) = try! CC.RSA.decrypt(crypted_data_bytes, derKey: privateKeyDER, tag: "L".data(using: .utf8)!, padding: .oaep, digest: .sha1)
//
    return String(decoding: encrypted_data, as: UTF8.self)
//    return encrypted_data
}


func decrypt_from_tripledes(privKey: String, tripleDesData: String, text: String) -> String{
    let tripleDesKey = decrypt_tripleDesKey(privKey: privKey, crypted_data: tripleDesData)
    let crypted_text_bytes = Data(base64Encoded: text, options: .ignoreUnknownCharacters)!

    return To3DES.decrypt(text: crypted_text_bytes, salt: tripleDesKey)!
}


func decrypt_messages(messages: [MessagesResponse.Message],
                      login: String,
                      completion: @escaping ([MessagesResponse.Message]) -> Void) {

    var new_messages: [MessagesResponse.Message] = []

    let group = DispatchGroup()

    for message in messages {
            group.enter()
            get_keys_from_server(from_: message.from, to_: login, group_: group) { response in
//                print("tst", response)
                new_messages.append(MessagesResponse.Message(id: message.id,
                        subject: decrypt_from_tripledes(privKey: response.keys.privKey,
                                tripleDesData: response.keys.tripleDesKey,
                                text: message.subject),
                        date: message.date,
                        body: decrypt_from_tripledes(privKey: response.keys.privKey,
                                tripleDesData: response.keys.tripleDesKey,
                                text: message.body),
                        from: message.from
                                .replacingOccurrences(of: "=?UTF-8?Q?", with: "")
                                .replacingOccurrences(of: "?=", with: ""),
                        flags: message.flags,
                        attachments: message.attachments))
//                print(new_messages.count)
                group.leave()
            }
    }
    group.notify(queue: .main){
        completion(new_messages)
    }
}


struct KeysResponse: Codable {
    let status: String

    struct Keys: Codable {
        let pubKey: String
        let privKey: String
        let tripleDesKey: String
    }

    let keys: Keys
}


func get_keys_from_server(from_: String, to_: String, group_: DispatchGroup, completion: @escaping (KeysResponse) -> Void) {
    let new_from = from_.replacingOccurrences(of: "=?UTF-8?Q?", with: "").replacingOccurrences(of: "?=", with: "")
    let url = "\(server_url)keys?from_=\(new_from)&to_=\(to_)"

    let request_url = URL(string: url.encodeUrl)

    URLSession.shared.dataTask(with: request_url!,
        completionHandler: {data, response, error in
            guard let data = data, error == nil else {
                print("Smth went wrong")
                group_.leave()
                return
            }

            var result: Any?
            do {
                result = try JSONDecoder().decode(KeysResponse.self, from: data)
            } catch {
                print("Failed to conver \(error.localizedDescription)")
                group_.leave()
                return
            }

            guard let json = result else {
                print("Error equal")
                group_.leave()
                return
            }
            completion(json as! KeysResponse)
    }).resume()
}