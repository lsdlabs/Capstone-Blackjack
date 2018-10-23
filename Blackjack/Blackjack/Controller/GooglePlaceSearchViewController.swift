//
//  GooglePlaceSearchViewController.swift
//  Blackjack
//
//  Created by Lauren Small on 10/21/18.
//  Copyright © 2018 Lauren Small. All rights reserved.
//

import UIKit

class GooglePlaceSearchViewController: UIViewController {

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let location = parse(data: performRequest(with: getNearbyCasinoLocationURL())!)
        
        //let location = parse(data: performRequest(with: getNearbyCasinoLocationURL())!)
        
        location?.location.first?.name
        
    }
    
    
    
    func getNearbyCasinoLocationURL() -> URL {
        let urlString = "https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=Motor%20City%20Casino&inputtype=textquery&key=AIzaSyAujsxp2pEYwi8CJbh8P3caqvsPwH_Xfa0"
        
//        let urlString = "https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=pizza%20restaurant&inputtype=textquery&fields=formatted_address,name,opening_hours&locationbias=circle:5000@42.3314,-83.0458&key=AIzaSyAujsxp2pEYwi8CJbh8P3caqvsPwH_Xfa0"
   
        let url = URL(string: urlString)
        return url!
}

    func performRequest(with url: URL) -> Data?{
        do {
         print("Okay")
            return try Data(contentsOf: url)
        } catch {
            print("Error \(error)")
            return nil
        }
    }
        
        func parse(data: Data) -> CasinoLocations? {
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(CasinoLocations.self, from: data)
                //print(result.location)
                print(result.location[0].name)
                print(result.location[0].formatted_address)
                return result
            } catch {
                print("JSON Error: \(error)")
                return nil
            }
        }
        
}


//class GooglePlaceSearchViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {

//@IBOutlet weak var searchTextfield: UITextField!
//
//@IBOutlet weak var placesTableView: UITableView!
//
////***//
////Create an array to stor the results
//var resultsArray: [Dictionary<String, AnyObject>] = Array()
////***//
//
//override func viewDidLoad() {
//    super.viewDidLoad()
//
//    // Do any additional setup after loading the view.
//    searchTextfield.delegate = self
//
//    searchTextfield.addTarget(self, action: #selector(searchPlaceFromGoogle(_:)), for: .editingChanged)
//
//    //***//
//    placesTableView.dataSource = self
//    placesTableView.delegate = self
//    placesTableView.estimatedRowHeight = 45.0
//    //***//
//}
//
////MARK:- UITableViewDataSource and UITableViewDelegate
//func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    return resultsArray.count
//}
//
//func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell")
//
//    if let labelPlaceName = cell?.contentView.viewWithTag(100) as? UILabel {
//        let place = self.resultsArray[indexPath.row]
//        labelPlaceName.text = "\(place["name"] as! String) \(place["formatted_address"] as! String)"
//    }
//    return cell!
//}
//
//
//
//
//func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//    return UITableView.automaticDimension
//}
//
//
//func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    tableView.deselectRow(at: indexPath, animated: true)
//}
//
//@objc func searchPlaceFromGoogle(_ textField:UITextField) {
//
//    if let searchQuery = textField.text {
//        var strGoogleApi = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=\(searchQuery)&key= AIzaSyABWLJXK3XYoNT3-1A7yQmXMLuu03Oln_Y"
//        strGoogleApi = strGoogleApi.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
//
//        var urlRequest = URLRequest(url: URL(string: strGoogleApi)!)
//        urlRequest.httpMethod = "GET"
//        let task = URLSession.shared.dataTask(with: urlRequest) { (data, resopnse, error) in
//            if error == nil {
//
//                if let responseData = data {
//                    let jsonDict = try? JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
//
//                    if let dict = jsonDict as? Dictionary<String, AnyObject>{
//
//                        if let results = dict["results"] as? [Dictionary<String, AnyObject>] {
//                            print("json == \(results)")
//                            //self.resultsArray.removeAll()
//                            for dictionary in results {
//                                self.resultsArray.append(dictionary)
//                            }
//                            //To load the tableView, need DispatchQueue
//                            DispatchQueue.main.async {
//                                self.placesTableView.reloadData()
//                            }
//
//                        }
//                    }
//
//                }
//            } else {
//                //we have error connection google api
//            }
//        }
//        task.resume()
//    }
//}
//
//
//
//
//
//
//
//
//
////
////
////
////    override func viewDidLoad() {
////        super.viewDidLoad()
////
////        // Do any additional setup after loading the view.
////        searchTextfield.delegate = self
////    }
////
////
////    //MARK:- UITextFieldDelegate
////
////    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
////
////        searchPlaceFromGoogle(place: textField.text!)//we are going to hit the api anytime the user taps on the search...make textfield non optional
////        return true //this will get hit anytime the user hits the search button off the keyboard
////    }
////
////    func searchPlaceFromGoogle(place: String) {
//////        var googleFindPlaceApi = "https://maps.googleapis.com/maps/api/place/findplacefromtext/output?parameters"
////
////        //Required Parameters = key, input, and inputtype
//////        var googleFindPlaceApi = "https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=\(place)&inputtype=textquery&key=YOUR_API_KEY"
////
////        var googleFindPlaceApi = "https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=\(place)&inputtype=textquery&key=AIzaSyAujsxp2pEYwi8CJbh8P3caqvsPwH_Xfa0"
////
////        //encode String
////
////        googleFindPlaceApi = googleFindPlaceApi.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
////
////        var urlRequest = URLRequest(url: URL(string: googleFindPlaceApi)!)
////        urlRequest.httpMethod = "GET"
////
////        //create a task
////        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
////            if error == nil {//We get the results successfully
////                let jsonDictionary = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
////                print("json == \(jsonDictionary)")
////            } else {//There's an error connecting to the Google Place Search API
////
////            }
////
////        }
////        task.resume() //so it can start hitting the API
////    }
////
////    /*
////    // MARK: - Navigation
////
////    // In a storyboard-based application, you will often want to do a little preparation before navigation
////    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
////        // Get the new view controller using segue.destination.
////        // Pass the selected object to the new view controller.
////    }
////    */
//
//}
//
//
//
//
