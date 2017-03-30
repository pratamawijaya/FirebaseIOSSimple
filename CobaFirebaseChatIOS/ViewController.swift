//
//  ViewController.swift
//  CobaFirebaseChatIOS
//
//  Created by Pratama Nur Wiaya on 3/30/17.
//  Copyright © 2017 PratamaLabs. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var dbRef:FIRDatabaseReference?
    var dbHandle:FIRDatabaseHandle?
    
    var postData = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        dbRef = FIRDatabase.database().reference()
        
        // get data
        dbHandle =  dbRef?.child("posts").observe(.childAdded, with: { (snapshot) in
            let post = snapshot.value as? String
            if let actualPost = post{
                
                // append data to array
                self.postData.append(actualPost)
                // reload table view
                self.tableView.reloadData()
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell")
        
        cell?.textLabel?.text = postData[indexPath.row]
        return cell!
    }
  
}

