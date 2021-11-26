//
//  TripTableViewCell.swift
//  Tourist
//
//  Created by Anatoliy Serputov on 2021-11-25.
//

import UIKit
import FirebaseFirestore


class TripTableViewCell: UITableViewCell {
    var tripsList:[Trip] = []
    @IBOutlet weak var TripTitleLabel: UILabel!
    @IBOutlet weak var TripPriceLabel: UILabel!
    
    let db = Firestore.firestore()
    
    @IBOutlet weak var TripButtonLabel: UIButton!
    @IBOutlet weak var TripStarsLabel: UILabel!
    
//    @IBOutlet weak var TripImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func ButtonClicked(_ sender: Any) {
        let check = (sender as AnyObject).accessibilityLabel
        let secondCheck = check!
        if secondCheck != nil {
//            print("Contains a value!")
//            print(secondCheck!)
            
            
            let docRef = db.collection("activities").document("\(secondCheck!)")
            let docRe2 = db.collection("myTrips");
            var taskToAdd = MyTrip(id:secondCheck!, title: "ok",stars: 5 , price: 40, photoLink: "/")
            
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
//                    let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
//                    print("Document data: \(dataDescription)")
                    
//                    for document in dataDescription!.documents{

                        do {
                            let trips = try  document.data(as: Trip.self)
                            self.tripsList.append(trips!)
//                            print(trips)
                            let title = trips!.title as Any
                            let stars2 = trips!.stars as Int
                            let price2 = trips!.price as Int
                            let photoLink = trips!.photoLink as Any
                            print(price2)
                            print(stars2)
                            taskToAdd = MyTrip(id:secondCheck!, title: "\(title)",stars: stars2, price: price2, photoLink: "\(photoLink)")
                         
                          
                           
                            
//                            print(title)
//                            let price = Int(trips?.price as Any);
                            
                            
                        }catch{
                            print("Hm Hm error")
                        }
                    
//                    let taskToAdd = MyTrip(id:secondCheck!, title: "ok",stars: 5 , price: 40, photoLink: "/")
  
                    do{
                        try docRe2.addDocument(from: taskToAdd) { err in
                        if let err = err {
                            print("Error writing document: \(err)")
                        } else {
                            print("Document successfully written!")
                        }
                    }
                    }catch{
                        print("not ok")
                    }
                    
                } else {
                    print("Document does not exist")
                }
            }
           
            
            

        } else {
            print("Doesn’t contain a value.")
        }
//
    }
}
