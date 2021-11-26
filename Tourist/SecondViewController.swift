//
//  secondViewController.swift
//  Tourist
//
//  Created by Anatoliy Serputov on 2021-11-25.
//

import UIKit
import FirebaseFirestore

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var Change: UILabel!
    @IBOutlet weak var MyTable2: UITableView!
    let db = Firestore.firestore()
    var tripsList:[Trip] = []
    var checkStars:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        MyTable2.dataSource = self
        MyTable2.delegate = self
        
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
            self.MyTable2.reloadData()
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
//        print(self.count)
        return tripsList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        checkStars = ""
        let cell = MyTable2.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! TripTableViewCell
        
        let curTrip:Trip = self.tripsList[indexPath.row]
        
        cell.TripTitleLabel.text = "\(curTrip.title)"
        cell.TripPriceLabel.text = "\(curTrip.price)"
        for index in 1...curTrip.stars {
            checkStars = "⭐️" + checkStars;
        }
        cell.TripStarsLabel.text = checkStars
        
      
//        cell.TripImg
        
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        
        let currTask = self.tripsList[indexPath.row]
        
        
        db.collection("myTrips").document(currTask.id!).delete{
            (error) in
            if let err = error{
                print(err)
            }
            print("ok deleted")
        }
        
        self.tripsList.remove(at: indexPath.row)
        self.MyTable2.deleteRows(at: [indexPath], with: .fade)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tripsList.removeAll()
        
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
            self.MyTable2.reloadData()
        }
    }

    @IBAction func CleanALL(_ sender: Any) {
        for trip in tripsList {
            db.collection("myTrips").document(trip.id!).delete{
                (error) in
                if let err = error{
                    print(err)
                }
                print("ok deleted")
            }
        }
        print(tripsList.count)
        tripsList.removeAll()
        self.MyTable2.reloadData()
        
    }
}
