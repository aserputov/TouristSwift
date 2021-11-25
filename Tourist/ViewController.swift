//
//  ViewController.swift
//  Tourist
//
//  Created by Anatoliy Serputov on 2021-11-24.
//

import UIKit
import FirebaseFirestore

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var MyTable: UITableView!
    var count:Int = 0 ;
    let db = Firestore.firestore()

    override func viewDidLoad() {
       
       
        
        super.viewDidLoad()
        MyTable.dataSource = self
        MyTable.delegate = self
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
//        print(self.count)
        return 4
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = MyTable.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        
        db.collection("activities").getDocuments { (results, error) in
            if let err = error{
                print("shot")
                print(err)
                return
            }
//            print(results!.count)
            self.count = results!.count
            print(self.count)
            
            
            for document in results!.documents{
//                let dc = document.data()
//                print(dc["price"])
//                print(dc["title"])
//                print(dc["stars"])
                
                do {
                    let trips = try  document.data(as: Trip.self)
                    print(trips?.id as Any)
                    print(trips?.title as Any)
                    print(trips?.price as Any)
                    print(trips?.photoLink as Any)
                    cell.textLabel!.text = "\(trips?.id)"
                    cell.detailTextLabel!.text = "\(trips?.title)"
                }catch{
                    print("Hm Hm error")
                }
                
            }
            
         
        }
        
       
        
//        print(indexPath.row)
        
        cell.textLabel!.text = "OKSSKSKSK"
        cell.detailTextLabel!.text = "ok"
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        print(indexPath.row)
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){}
    

    @IBAction func get(_ sender: Any) {
       
    }
}

