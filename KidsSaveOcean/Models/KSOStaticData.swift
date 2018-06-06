//
//  KSOStaticData.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 6/2/18.
//  Copyright © 2018 KidsSaveOcean. All rights reserved.
//

import UIKit

typealias KSODataDictionary = Dictionary<String,Any>
typealias KSODataArray = Array<KSODataDictionary>


let KSOMainViewData:KSODataArray = [["image" : #imageLiteral(resourceName: "ClownFish"),
                                     "title":"I am a Student",
                                          "subTitle" :"HOW I CAN HELP",
                                          "description":"Get started on a letter-writting campaign, we'll show you how."],
                                         ["image" : #imageLiteral(resourceName: "JellyFish"),
                                          "title":"I am a Teacher",
                                          "subTitle" :"HOW I CAN HELP",
                                          "description":"We have a lot of learning materials to help you engage your students."],
                                         ["image" : #imageLiteral(resourceName: "Turtle"),
                                          "title":"I want to support",
                                          "subTitle" :"HOW I CAN HELP",
                                          "description":"We need your support donations. Learn how you can engage with..."]]

///// Perhaps we will get it later dynamically from web-services from backend.
let KSONewsViewData:KSODataArray = [["image" : #imageLiteral(resourceName: "Map"),
                                          "title":"Letter Writting Campaign",
                                          "subTitle" :"UPDATES",
                                          "description":"See our progress"],
                                         ["image" : #imageLiteral(resourceName: "Surfer"),
                                          "title":"Peder Hill",
                                          "subTitle" :"INTERVIEW",
                                          "description":"Q&A with the founder"]]

class KSOStaticData: NSObject {

}
