import Foundation
import SQLite


let path = try! FileManager
        .default
        .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        .appendingPathComponent("db.sqlite")
        .absoluteString


class Model {
    var db: Connection = try! Connection(path)
//    init() {
//        db = try! Connection(path)
//    }
    func createTable() {}
}


class Session: Model {
    let session = Table("session")
    var key = Expression<String>("key")
    var value = Expression<String>("value")

    override init() {
        super.init()
        createTable()
    }

    override func createTable() {
        try! db.run(session.create(ifNotExists: true) { t in
            t.column(key, primaryKey: true)
            t.column(value)
        })
    }

    func get(key: String) -> String {
        try! db.scalar(session.select(value).filter(self.key == key))
    }

    func set(key: String, value: String) {
        try! db.run(session.upsert(self.key <- key,
                self.value <- value,
                onConflictOf: self.value))
    }
}


class Relations: Model {
    let relations = Table("Relations")

    let from_ = Expression<String>("from_")
    let to_ = Expression<String>("to_")

    override init() {
        super.init()
        createTable()
    }

    override func createTable() {
        try! db.run(relations.create(ifNotExists: true) { t in
            t.column(from_)
            t.column(to_)
        })
    }

    func is_sended_keys(sender: String, receiver: String) -> Bool{
        ((try! db.pluck(relations.select(from_).filter(from_ == sender && to_ == receiver))) != nil)
    }

    func create_relation(sender: String, receiver: String) {
        try! db.run(relations
                .insert(from_ <- sender,
                        to_ <- receiver))
    }
}


class Mails: Model {

    let mails = Table("Mails")
    var mail = Expression<String>("mail")
    var password = Expression<String>("password")
    var privateKey = Expression<String>("privateKey")
    var publicKey = Expression<String>("publicKey")
    var tripleDesKey = Expression<String>("tripleDesKey")

    override init() {
        super.init()
//        try! db?.run(mails.drop())
        createTable()
//        delete_rows()
    }
        
//    func delete_rows() {
//        print("SEXXX")
//        let not_need = mails.filter(mail != "Nkl54@mail.ru")
//        try! db?.run(not_need.delete())
//    }
    
//    func update_table() 

    override func createTable() {
        try! db.run(mails.create(ifNotExists: true) { t in
            t.column(mail, primaryKey: true)
            t.column(password)
            t.column(privateKey)
            t.column(publicKey)
            t.column(tripleDesKey)
        })
    }

    func add_mail(login: String, password: String) -> Bool {
        do {
            let keys = get_key_pair_with_triple_des()
            try db.run(mails.insert(mail <- login,
                    self.password <- password,
                    publicKey <- keys.0,
                    privateKey <- keys.1,
                    tripleDesKey <- keys.2))
        } catch {
            return false
        }
        return true
    }

    func get_mails() -> Array<String> {
        var mails_: Array<String> = Array()
        try! db.prepare(mails).forEach { mail_ in
            mails_.append(mail_[mail])
        }
        return mails_
    }
    
    func get_password(login: String) -> String {
        try! db.pluck(mails.select(password).filter(mail == login))?[password] as! String
    }
    
    func delete_mail(mail_: String) {
        let mail_to_delete = mails.filter(mail == mail_)
        try! db.run(mail_to_delete.delete())
    }

    func get_keys(mail_: String) -> (String, String, String) {
//        try! db.pluck(mails.select(password).filter(mail == mail_))?[password] as! String
        let mail_obj = try! db.pluck(mails.select(publicKey, privateKey, tripleDesKey).filter(mail == mail_))
        return (mail_obj![privateKey], mail_obj![publicKey], mail_obj![tripleDesKey])
    }
}


func testDb() {
//    do {
//        let db = try Connection(path)
//
//        let users = Table("users")
//        let id = Expression<Int64>("id")
//        let name = Expression<String?>("name")
//        let email = Expression<String>("email")
//
//        try db.run(users.create(ifNotExists: true) { t in
//            t.column(id, primaryKey: true)
//            t.column(name)
//            t.column(email, unique: true)
//        })
        // CREATE TABLE "users" (
        //     "id" INTEGER PRIMARY KEY NOT NULL,
        //     "name" TEXT,
        //     "email" TEXT NOT NULL UNIQUE
        // )

//        let insert = users.insert(name <- "Alice", email <- "Alice@mac.com")
//        let rowid = try db.run(insert)
//        // INSERT INTO "users" ("name", "email") VALUES ('Alice', 'alice@mac.com')
//
//        for user in try db.prepare(users) {
//            print("id: \(user[id]), name: \(user[name]), email: \(user[email])")
//            // id: 1, name: Optional("Alice"), email: alice@mac.com
//        }
//        // SELECT * FROM "users"
//
//        let alice = users.filter(id == rowid)
//
//        try db.run(alice.update(email <- email.replace("mac.com", with: "me.com")))
//        // UPDATE "users" SET "email" = replace("email", 'mac.com', 'me.com')
//        // WHERE ("id" = 1)
//
////        try db.run(alice.delete())
////         DELETE FROM "users" WHERE ("id" = 1)
//
//        print(try db.scalar(users.count)) // 0
//        // SELECT count(*) FROM "users"
//    } catch {
//        print (error)
//    }

//    Session().set(key: "color", value: "red")
    print(Session().get(key: "color"))
}

