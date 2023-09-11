//
//  UserModel.swift
//  SimpliSave
//


import Foundation

struct UserRegister: Codable {
    //changed the variable declaration from var to var
    var firstName: String, lastName: String, cellphoneNumber: String, email: String,imageUrl:String
    var idNo: String, password: String,createdAt:String,updatedAt:String

//    enum CodingKeys: String, CodingKey {
//        case firstName, lastName, cellphoneNumber, email, idNo,createdAt,updatedAt
//        case imageURL
//        case password
//    }
}

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
