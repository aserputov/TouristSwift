//
//  ViewController.swift
//  Tourist
//
//  Created by Anatoliy Serputov on 2021-11-24.
//

import UIKit
import FirebaseFirestore

class ViewController: UIViewController {
    
    let db = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func get(_ sender: Any) {
        db.collection("activities").getDocuments { (results, error) in
            if let err = error{
                print("shot")
                print(err)
                return
            }
            print(results!.count)
            
            for document in results!.documents{
                let dc = document.data()
                print(dc["price"])
                print(dc["title"])
                print(dc["stars"])
            }
         
        }
    }
}

