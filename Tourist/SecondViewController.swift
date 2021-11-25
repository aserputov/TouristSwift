//
//  secondViewController.swift
//  Tourist
//
//  Created by Anatoliy Serputov on 2021-11-25.
//

import UIKit
import FirebaseFirestore

class SecondViewController: UIViewController {
    
    @IBOutlet weak var Change: UILabel!
    let db = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()
        Change.text = ""
    }
    
    @IBAction func get(_ sender: Any) {
        db.collection("myTrips").getDocuments { (results, error) in
            if let err = error{
                print("shot")
                print(err)
                return
            }
            for document in results!.documents{
                do {
                    let trips = try  document.data(as: Trip.self)
                    print(trips?.id as Any)
                    print(trips?.title as Any)
                    print(trips?.price as Any)
                    print(trips?.photoLink as Any)
                }catch{
                    print("Hm Hm error")
                }
                
            }
            
         
        }
        
    }
}
