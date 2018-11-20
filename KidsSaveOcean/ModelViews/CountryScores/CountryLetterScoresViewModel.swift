//
//  CountryLetterScoresViewModel.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 10/13/18.
//  Copyright © 2018 KidsSaveOcean. All rights reserved.
//

import Foundation

import UIKit
import Firebase

final class CountryLetterScoresViewModel: NSObject {
  
  private let databaseReferenece: DatabaseReference
  private(set) var countryScores = [CountryScore]()
  
  override init() {
    self.databaseReferenece = Database.database().reference()
  }
  
  init(databaseReferenece: DatabaseReference) {
    self.databaseReferenece = databaseReferenece
  }
  
  func fetchCountryScores(_ completion: (() -> ())?) {
    countryScores.removeAll()
    
    databaseReferenece.child("MapPins").observeSingleEvent(of: .value, with: { (snapshot) in
      guard let snapshotValue = snapshot.value as? NSDictionary else {
        completion?()
        return
      }
      
      for pin in snapshotValue {
        guard let value = pin.value as? NSDictionary else {
          continue
        }
        
        guard let country = value["country"] as? String else {
          continue
        }
        
        guard let latitude = value["latitude"] as? String else {
          continue
        }
        
        guard let longitude = value["longitude"] as? String else {
          continue
        }
        
        guard let numberOfLetters = value["numberOfLetters"] as? String else {
          continue
        }
        
        let countryContact = CountryScore(country: country, latitude: latitude, longitude: longitude, numberOfLetters: Int(numberOfLetters)!)
        self.countryScores.append(countryContact)
      }
      
      completion?()
      
    }) { (error) in
      completion?()
      print(error.localizedDescription)
    }
  }
  
  func topCountryScores() -> [CountryScore] {
    return countryScores.sorted(by: {$0.numberOfLetters > $1.numberOfLetters})
  }
  
}
