//
//  ViewController.swift
//  Tourist
//
//  Created by Anatoliy Serputov on 2021-11-24.
//

import UIKit
import FirebaseFirestore
import FirebaseFirestoreSwift

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var MyTable: UITableView!
    var count:Int = 0 ;
    var tripsList:[Trip] = []
    let db = Firestore.firestore()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MyTable.dataSource = self
        MyTable.delegate = self
        
        db.collection("myTrips").getDocuments { (results, error) in
            if let err = error{
                print("shot")
                print(err)
                return
            }
            
            
            for document in results!.documents{

                do {
                    let trips = try  document.data(as: Trip.self)
                    self.tripsList.append(trips!)
//                    print(trips)
//                    print(trips?.id as Any)
//                    print(trips?.title as Any)
//                    print(trips?.price as Any)
//                    print(trips?.photoLink as Any)
//
                    
                }catch{
                    print("Hm Hm error")
                }
                
            }
            self.MyTable.reloadData()
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
//        print(self.count)
        return tripsList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = MyTable.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! TripTableViewCell
        
        let curTrip:Trip = self.tripsList[indexPath.row]
        
        cell.TripTitleLabel.text = "\(curTrip.title)"
        
//        print(curTrip.title)
//        cell.tableViewLabel.text = "curTrip.title"
//        cell.textLabel!.text = "\(curTrip.id)"
//        cell.detailTextLabel!.text = "\(curTrip.title)"
     
        
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

