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
    
}
