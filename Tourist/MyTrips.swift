//
//  MyTrips.swift
//  Tourist
//
//  Created by Anatoliy Serputov on 2021-11-25.
//

import Foundation
import FirebaseFirestoreSwift


struct MyTrip:Codable{
    @DocumentID var id:String?
    var title:String = "";
    var stars:Int = 0;
    var price:Int = 0;
    var photoLink:String = ""
    
}
