//
//  CasinoLocations.swift
//  Blackjack
//
//  Created by Lauren Small on 10/22/18.
//  Copyright © 2018 Lauren Small. All rights reserved.
//

import Foundation
class CasinoLocations: Codable {
    
    var location: [LocationInformation]
    
    struct LocationInformation: Codable {
        var formatted_address: String
        var name: String
        //        var vicinity: Double
        
    }
}
