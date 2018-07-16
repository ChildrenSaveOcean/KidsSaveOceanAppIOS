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


let KSOUserTypeViewData:KSODataArray = [["image" : #imageLiteral(resourceName: "ClownFish"),
                                     "title":"I am a Student",
                                     "subTitle" :"HOW I CAN HELP",
                                     "description":"Get started on a letter-writting campaign, we'll show you how.",
                                     "action":"aWbPiPh_gaU"],
                                    ["image" : #imageLiteral(resourceName: "JellyFish"),
                                     "title":"I am a Teacher",
                                     "subTitle" :"HOW I CAN HELP",
                                     "description":"We have a lot of learning materials to help you engage your students.",
                                     "action":"aWbPiPh_gaU"],
                                    ["image" : #imageLiteral(resourceName: "Turtle"),
                                     "title":"I want to support",
                                     "subTitle" :"HOW I CAN HELP",
                                     "description":"We need your support donations. Learn how you can engage with...",
                                     "action":"aWbPiPh_gaU"]]

///// Perhaps we will get it later dynamically from web-services from backend.
let KSOHomeViewData:KSODataArray = [["image" : #imageLiteral(resourceName: "Map"),
                                     "title":"Letter Writting Campaign",
                                     "subTitle" :"UPDATES",
                                     "description":"See our progress",
                                     "action":""],
                                    ["image" : #imageLiteral(resourceName: "Surfer"),
                                     "title":"Peder Hill",
                                     "subTitle" :"INTERVIEW",
                                     "description":"Q&A with the founder",
                                     "action":""],
                                    ["image" : #imageLiteral(resourceName: "WhaleTail"),
                                     "title":"Third thing in this screen",
                                     "subTitle" :"SOME TEXT",
                                     "description":"Some sub text",
                                     "action":""],
                                    ["image" : #imageLiteral(resourceName: "actinia"),
                                     "title":"Something else",
                                     "subTitle" :"HELLO WORLD",
                                     "description":"All you need is love",
                                     "action":""]]

let KSONewsViewData:KSODataArray = [["image" : #imageLiteral(resourceName: "Map"),
                                     "title":"Letter Writting Campaign",
                                     "subTitle" :"UPDATES",
                                     "description":"See our progress",
                                     "action":""],
                                    ["image" : #imageLiteral(resourceName: "Surfer"),
                                     "title":"Peder Hill",
                                     "subTitle" :"INTERVIEW",
                                     "description":"Q&A with the founder",
                                     "action":""]
                                    ]

let KSONewsTableViewData:KSODataArray = [["image" : #imageLiteral(resourceName: "Whale"),
                                          "title":"The Last Whale",
                                          "subTitle" :"United Nations Clean Ocean Summit 2018"],
                                         ["image" : #imageLiteral(resourceName: "Diver"),
                                          "title":"Exhibition pace",
                                          "subTitle" :"Children's Whale sculpture seeks exhibition space"],
                                         ["image" : #imageLiteral(resourceName: "K"),
                                          "title":"Kickstarter",
                                          "subTitle" :"We're live! Help give kids a voice"]]

let KSOResourcesStudentsTableViewData:KSODataArray = [["image" : "",
                                                       "title":"Example Letters",
                                                       "subTitle" :"Here is some examples of letters students have written"],
                                                      ["image" : "",
                                                       "title":"Country Contacts",
                                                       "subTitle" :"Look up who is the best person to write to in your contry"],
                                                      ["image" : "",
                                                       "title":"Resource Title ...",
                                                       "subTitle" :"Subtitle and synopsis pm resource would go here"]]

let KSOResourcesTeacherTableViewData:KSODataArray = [["image" : "",
                                                      "title":"Resource Title 1",
                                                      "subTitle" :"Subtitle and synopsis pm resource would go here"],
                                                     ["image" : "",
                                                      "title":"Resource Title 2",
                                                      "subTitle" :"Subtitle and synopsis pm resource would go here"],
                                                     ["image" : "",
                                                      "title":"Resource Title 3",
                                                      "subTitle" :"Subtitle and synopsis pm resource would go here adjfhadlskfhladskhf"]]



class KSOStaticData: NSObject {
    
}

