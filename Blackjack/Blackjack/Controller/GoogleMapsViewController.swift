//
//  GoogleMapsViewController.swift
//  Blackjack
//
//  Created by Lauren Small on 10/22/18.
//  Copyright © 2018 Lauren Small. All rights reserved.
//

import Foundation
import UIKit

class GoogleMapsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var placesTableView: UITableView!
    
    var resultsArray:[Dictionary<String, AnyObject>] = Array()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        searchTextField.addTarget(self, action: #selector(findLocationsFromGoogle(_:)), for: .editingChanged)
        placesTableView.estimatedRowHeight = 44.0
        placesTableView.dataSource = self
        placesTableView.delegate = self
    }
    
    //MARK:- UITableViewDataSource and UItableViewDelegates
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if let placeNameLabel = cell?.contentView.viewWithTag(102) as? UILabel {
            
            let place = self.resultsArray[indexPath.row]
            placeNameLabel.text = "\(place["name"] as! String) \(place["formatted_address"] as! String)"
        }
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let place = self.resultsArray[indexPath.row]
        if let locationGeometry = place["geometry"] as? Dictionary<String, AnyObject> {
            if let location = locationGeometry["location"] as? Dictionary<String, AnyObject> {
                if let latitude = location["lat"] as? Double {
                    if let longitude = location["lng"] as? Double {
                        UIApplication.shared.open(URL(string: "https://www.google.com/maps/@\(latitude),\(longitude),16z")!, options: [:])
                    }
                }
            }
        }
    }
    
    
    //This function uses the user's search input from the textfield to make a GET request to Google's servers.
    //As per Google's documentation: "The Google Places API Text Search Service is a web service that returns information about a set of places based on a string — for example "pizza in New York" or "shoe stores near Ottawa" or "123 Main Street". The service responds with a list of places matching the text string and any location bias that has been set."
    @objc func findLocationsFromGoogle(_ textField:UITextField) {
        
        if let searchQuery = textField.text {
            var googleApiString = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=\(searchQuery)&key=AIzaSyAujsxp2pEYwi8CJbh8P3caqvsPwH_Xfa0"
            googleApiString = googleApiString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            
            var urlRequest = URLRequest(url: URL(string: googleApiString)!)
            urlRequest.httpMethod = "GET"
            let task = URLSession.shared.dataTask(with: urlRequest) { (data, resopnse, error) in
                if error == nil {
                    
                    if let responseData = data {
                        let jsonDictionary = try? JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                        
                        if let dictionary = jsonDictionary as? Dictionary<String, AnyObject>{
                            
                            if let results = dictionary["results"] as? [Dictionary<String, AnyObject>] {
                                print("json == \(results)")
                                self.resultsArray.removeAll()
                                for dictionary in results {
                                    self.resultsArray.append(dictionary)
                                }
                                
                                DispatchQueue.main.async {
                                    self.placesTableView.reloadData()
                                }
                                
                            }
                        }
                        
                    }
                } else {
                    //there is an error hitting the endpoint/connecting to Google's servers
                }
            }
            task.resume()
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}





//lblPlaceName











/*
 //
 //  GoogleMapsViewController.swift
 //  Blackjack
 //
 //  Created by Lauren Small on 10/22/18.
 //  Copyright © 2018 Lauren Small. All rights reserved.
 //
 
 import Foundation
 import UIKit
 
 class GoogleMapsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
 
 
 @IBOutlet weak var searchTextField: UITextField!
 
 @IBOutlet weak var placesTableView: UITableView!
 
 var resultsArray:[Dictionary<String, AnyObject>] = Array()
 override func viewDidLoad() {
 super.viewDidLoad()
 // Do any additional setup after loading the view, typically from a nib.
 searchTextField.addTarget(self, action: #selector(findLocationsFromGoogle(_:)), for: .editingChanged)
 placesTableView.estimatedRowHeight = 44.0
 placesTableView.dataSource = self
 placesTableView.delegate = self
 }
 
 //MARK:- UITableViewDataSource and UItableViewDelegates
 
 func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 return resultsArray.count
 }
 
 func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 
 let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
 if let placeNameLabel = cell?.contentView.viewWithTag(102) as? UILabel {
 
 let place = self.resultsArray[indexPath.row]
 placeNameLabel.text = "\(place["name"] as! String) \(place["formatted_address"] as! String)"
 }
 return cell!
 }
 
 
 func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
 return UITableView.automaticDimension
 }
 
 func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
 tableView.deselectRow(at: indexPath, animated: true)
 let place = self.resultsArray[indexPath.row]
 if let locationGeometry = place["geometry"] as? Dictionary<String, AnyObject> {
 if let location = locationGeometry["location"] as? Dictionary<String, AnyObject> {
 if let latitude = location["lat"] as? Double {
 if let longitude = location["lng"] as? Double {
 UIApplication.shared.open(URL(string: "https://www.google.com/maps/@\(latitude),\(longitude),16z")!, options: [:])
 }
 }
 }
 }
 }
 
 
 //This function uses the user's search input from the textfield to make a GET request to Google's servers.
 //As per Google's documentation: "The Google Places API Text Search Service is a web service that returns information about a set of places based on a string — for example "pizza in New York" or "shoe stores near Ottawa" or "123 Main Street". The service responds with a list of places matching the text string and any location bias that has been set."
 @objc func findLocationsFromGoogle(_ textField:UITextField) {
 
 if let searchQuery = textField.text {
 var googleApiString = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=\(searchQuery)&key=API_KEY"
 googleApiString = googleApiString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
 
 var urlRequest = URLRequest(url: URL(string: googleApiString)!)
 urlRequest.httpMethod = "GET"
 let task = URLSession.shared.dataTask(with: urlRequest) { (data, resopnse, error) in
 if error == nil {
 
 if let responseData = data {
 let jsonDictionary = try? JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
 
 if let dictionary = jsonDictionary as? Dictionary<String, AnyObject>{
 
 if let results = dictionary["results"] as? [Dictionary<String, AnyObject>] {
 print("json == \(results)")
 self.resultsArray.removeAll()
 for dictionary in results {
 self.resultsArray.append(dictionary)
 }
 
 DispatchQueue.main.async {
 self.placesTableView.reloadData()
 }
 
 }
 }
 
 }
 } else {
 //there is an error hitting the endpoint/connecting to Google's servers
 }
 }
 task.resume()
 }
 }
 
 
 override func didReceiveMemoryWarning() {
 super.didReceiveMemoryWarning()
 // Dispose of any resources that can be recreated.
 }
 
 
 }
 
 
 
 
 
 //lblPlaceName
 
 
 
 
 
 
 
 
 
 
 
 /*
 
 */

 */
