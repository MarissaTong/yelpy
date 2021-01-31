//
//  ViewController.swift
//  Yelpy
//
//  Created by Memo on 5/21/20.
//  Copyright © 2020 memo. All rights reserved.
//

import UIKit
import AlamofireImage

class RestaurantsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
//    //returns the height of the cell
//    func tableView (_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
//        return 200
//    }
    
    //specifies length of the table view->number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantsArray.count
    }
    
    //writing those code to each one of the cells -> the data that goes into each cell
    func tableView (_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell") as! RestaurantCell
        
        let restaurant = restaurantsArray[indexPath.row]
        
        cell.label.text = restaurant["name"] as? String ?? " "
        
        if let imageUrlString = restaurant["image_Url"] as? String{
            let imageUrl = URL(string:imageUrlString)
            //af is an framework -> makes requests & API calls easier
            cell.restaurantImage.af.setImage(withURL: imageUrl!)
        }
        
        return cell
        
    }
    
    
    // ––––– TODO: Add storyboard Items (i.e. tableView + Cell + configurations for Cell + cell outlets)
    // ––––– TODO: Next, place TableView outlet here
    @IBOutlet weak var tableView: UITableView!
    
    
    // –––––– TODO: Initialize restaurantsArray
    var restaurantsArray: [[String:Any?]] = []
    
    
    // ––––– TODO: Add tableView datasource + delegate
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getAPIData()
        

    }
    
    
    // ––––– TODO: Get data from API helper and retrieve restaurants
    func getAPIData(){
        API.getRestaurants(){ (restaurants) in
            
            guard let restaurants = restaurants else {
                return
            }
            
            // print(restaurants)
            self.restaurantsArray = restaurants
            self.tableView.reloadData() //sometimes data pulled up before API receives data
        }
        
    }
    
    

}

// ––––– TODO: Create tableView Extension and TableView Functionality


