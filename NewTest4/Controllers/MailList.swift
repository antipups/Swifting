//
//  MailList.swift
//  NewTest4
//
//  Created by Никита Куркурин on 04.12.2021.
//




//
//let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
//                   .appendingPathComponent("db.sqlite")
//
//
//
//var db: OpaquePointer?
//guard sqlite3_open(fileURL.path, &db) == SQLITE_OK else {
//    print("error opening database")
//    sqlite3_close(db)
//    db = nil
//    return
//}
//
//if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS Heroes (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, powerrank INTEGER)", nil, nil, nil) != SQLITE_OK {
//    let errmsg = String(cString: sqlite3_errmsg(db)!)
//    print("error creating table: \(errmsg)")
//}
