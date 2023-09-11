//
//  UserModel.swift
//  SimpliSave
//
//  Created by DA MAC M1 126 on 2023/08/07.
// updated: 15/08/2023 Robert, added User struct and renamed the first one to UserRegister

import Foundation

struct UserRegister: Codable {
    //changed the variable declaration from var to var: 10/08/2023 | Rolva
    var firstName: String, lastName: String, cellphoneNumber: String, email: String,imageUrl:String
    var idNo: String, password: String,createdAt:String,updatedAt:String

//    enum CodingKeys: String, CodingKey {
//        case firstName, lastName, cellphoneNumber, email, idNo,createdAt,updatedAt
//        case imageURL
//        case password
//    }
}


/*
 created 10 08 2023
 updated: 15 08 2023
 Dev: Robert
 Description: used for user authentication
 */
struct User {
    var username: String
    var password: String
    var token: String?
}

struct profilePicModel{
    var imageUrl:String
}


struct budgetDetails:Codable{
    var budgetId:String
    var amountSet:String
    var progressAmount:String
    var budgetCreated:String
    var budgetStatus :String
    var transactionsType:String
}

struct ServerResponse: Codable {
    
    //let Data: String
    let Message: String
}
