//
//  CountryContactDetails.swift
//  KidsSaveOcean
//
//  Created by Oleg Ivaniv on 8/9/18.
//  Copyright © 2018 KidsSaveOcean. All rights reserved.
//

//import Foundation
import MapKit

class CountryContact: Codable {

    enum CodingKeys: String, CodingKey {
        case name = "country_name"
        case address = "country_address"
        case longitude, latitude
        case number = "country_number"
        case head_of_state = "country_head_of_state_title"
        case letters_written = "letters_written_to_country"
    }

    let name: String
    var code: String = ""
    let address: String?

    private var longitude: Double = 0
    private var latitude: Double = 0

    var number: Int?
    var letters_written: Int = 0
    var head_of_state: String?
    var action: Action?

    var coordinates: CLLocationCoordinate2D? {

        get {
            return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }

        set {
            if let coordinates = newValue {
                latitude = coordinates.latitude
                longitude = coordinates.longitude
            }
        }
    }

    init(code: String, name: String, address: String?, coordinates: CLLocationCoordinate2D?) {
        self.code = code
        self.name = name
        self.address = address
        self.coordinates = coordinates
    }
}
