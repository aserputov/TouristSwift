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
    var checkStars:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MyTable.dataSource = self
        MyTable.delegate = self
        
        db.collection("activities").getDocuments { (results, error) in
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
        checkStars = ""
        let cell = MyTable.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! TripTableViewCell
        
        let curTrip:Trip = self.tripsList[indexPath.row]
        
        cell.TripTitleLabel.text = "\(curTrip.title)"
        cell.TripPriceLabel.text = "$\(curTrip.price).00"
//        print(curTrip.photoLink)
//        let image: UIImage = UIImage(named: "\(curTrip.photoLink)")!
//        cell.TripImgLabel = UIImageView(image: image)
//        cell.TripImgLabel!.frame = CGRectMake(0,0,100,200)
//        self.view.addSubview(cell.TripImgLabel!)
        if(curTrip.title == "New York, USA"){
            cell.TripImgLabel.image = #imageLiteral(resourceName: "second")
        }else if(curTrip.title == "Berlin, Germany"){
            cell.TripImgLabel.image = #imageLiteral(resourceName: "image")
        }else if(curTrip.title == "Toronto, Canada"){
            cell.TripImgLabel.image = #imageLiteral(resourceName: "third")
        }else if(curTrip.title == "Halifax, Canada"){
            cell.TripImgLabel.image = #imageLiteral(resourceName: "fifth")
        }else{
            cell.TripImgLabel.image = #imageLiteral(resourceName: "first")
        }
//        cell.TripImgLabel.image = #imageLiteral(resourceName: "4038c700-61d2-11e9-805e-2d39adbf13ca.png")
//        cell.TripImgLabel.image = #imageLiteral(resourceName: "first")
        for index in 1...curTrip.stars {
            checkStars = "⭐️" + checkStars;
        }
        cell.TripStarsLabel.text = checkStars
//        print(curTrip.id!)
        let check = curTrip.id!
        cell.TripButtonLabel.accessibilityLabel = "\(check)"
        cell.TripButtonLabel.tag = indexPath.row
        
//        print(cell.TripButtonLabel.accessibilityLabel)
        
//        cell.subscribeButton.addTarget(self, action: #selector((_:)), for: .touchUpInside)
             
        
//        cell.TripButtonLabel.addTarget(self, action: #selector(subscribeTapped(_:)), for: .touchUpInside)
      
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
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){}
    

}

