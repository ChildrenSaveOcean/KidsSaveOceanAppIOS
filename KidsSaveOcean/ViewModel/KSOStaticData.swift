//
//  KSOStaticData.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 6/2/18.
//  Copyright © 2018 KidsSaveOcean. All rights reserved.
//

import UIKit

typealias KSODataDictionary = [String: Any]
typealias KSODataArray = [KSODataDictionary]

let UserTypeViewData: KSODataArray = [["image": #imageLiteral(resourceName: "Skater"),
                                     "title": "I am a Student",
                                     "subTitle": "HOW I CAN HELP",
                                     "description": "Get started on a letter-writing campaign,\nwe’ll show you how!",
                                     "action": "aWbPiPh_gaU"],
                                    ["image": #imageLiteral(resourceName: "Crab - teacher"),
                                     "title": "I am a Teacher",
                                     "subTitle": "HOW I CAN HELP",
                                     "description": "We have lots of learning materials available to\nhelp you engage students.",
                                     "action": "aWbPiPh_gaU"],
                                    ["image": #imageLiteral(resourceName: "Turtle - other"),
                                     "title": "I want to support",
                                     "subTitle": "HOW I CAN HELP",
                                     "description": "Not a student or teacher? Your support is the\nbedrock of Fatechanger. Learn more.",
                                     "action": "aWbPiPh_gaU"]]

///// Perhaps we will get it later dynamically from web-services from backend.
let HomeViewData: KSODataArray = [["image": #imageLiteral(resourceName: "theWavEs"),
                                     "title": "News And Media",
                                     "subTitle": "KEEP UPDATED",
                                     "action": ""],
                                    ["image": #imageLiteral(resourceName: "homePic2"),
                                     "title": "Write Letters, Multiply Impact",
                                     "subTitle": "DEMAND PROTECTION OF OUR PLANET",
                                     "action": ""],
                                    ["image": #imageLiteral(resourceName: "Imagery"),
                                        "title": "Create New Environmental Policy",
                                        "subTitle": "PLASTIC & CLIMATE EMERGENCIES",
                                        "action": ""],
                                    ["image": #imageLiteral(resourceName: "dashboardCopyForHomeScreenPic"),
                                     "title": "Your Activist Dashboard",
                                     "subTitle": "LIGHT IT UP",
                                     "action": ""],
                                    ["image": #imageLiteral(resourceName: "mapForCampaign"),
                                     "title": "Letter Campaigns, Initiatives, Activism",
                                     "subTitle": "WATCH YOUTH IMPACT SPREAD",
                                     "action": ""],
                                    ["image": #imageLiteral(resourceName: "Share_like_a_boss"),
                                    "title": "Tips to share like a Boss",
                                    "subTitle": "CALL OUT TO THE PACK",
                                    "action": ""
                                    ]]

let KSONewsViewData: KSODataArray = [["image": #imageLiteral(resourceName: "Map"),
                                     "title": "Letter Writing Campaign",
                                     "subTitle": "UPDATES",
                                     "description": "See our progress",
                                     "action": ""],
                                    ["image": #imageLiteral(resourceName: "Surfer"),
                                     "title": "Peder Hill",
                                     "subTitle": "INTERVIEW",
                                     "description": "Q&A with the founder",
                                     "action": ""]
                                    ]

let KSONewsTableViewData: KSODataArray = [["image": #imageLiteral(resourceName: "Whale"),
                                          "title": "The Last Whale",
                                          "subTitle": "United Nations Clean Ocean Summit 2018"],
                                         ["image": #imageLiteral(resourceName: "Diver"),
                                          "title": "Exhibition pace",
                                          "subTitle": "Children's Whale sculpture seeks exhibition space"],
                                         ["image": #imageLiteral(resourceName: "K"),
                                          "title": "Kickstarter",
                                          "subTitle": "We're live! Help give kids a voice"]]

let KSOResourcesStudentsTableViewData: KSODataArray = [["image": #imageLiteral(resourceName: "letter_tmp"),
                                                       "title": "Example Letters",
                                                       "subTitle": "Here is some examples of letters students have written"],
                                                      ["image": #imageLiteral(resourceName: "Contacts_tmp"),
                                                       "title": "Country Contacts",
                                                       "subTitle": "Look up who is the best person to write to in your contry"],
                                                      ["image": "",
                                                       "title": "Resource Title 3...",
                                                       "subTitle": "Subtitle and synopsis pm resource would go here"],
                                                      ["image": "",
                                                       "title": "Resource Title 4...",
                                                       "subTitle": "Subtitle and synopsis pm resource would go here"],
                                                      ["image": "",
                                                       "title": "Resource Title 5...",
                                                       "subTitle": "Subtitle and synopsis pm resource would go here"]]

let KSOResourcesTeacherTableViewData: KSODataArray = [["image": #imageLiteral(resourceName: "teaching_tmp"),
                                                      "title": "Resource Title 1",
                                                      "subTitle": "Subtitle and synopsis pm resource would go here"],
                                                     ["image": #imageLiteral(resourceName: "teaching_tmp"),
                                                      "title": "Resource Title 2",
                                                      "subTitle": "Subtitle and synopsis pm resource would go here"],
                                                     ["image": "",
                                                      "title": "Resource Title 3",
                                                      "subTitle": "Subtitle and synopsis pm resource would go here adjfhadlskfhladskhf"],
                                                     ["image": "",
                                                      "title": "Resource Title 4",
                                                      "subTitle": "Subtitle and synopsis pm resource would go here adjfhadlskfhladskhf"],
                                                     ["image": "",
                                                      "title": "Resource Title 5",
                                                      "subTitle": "Subtitle and synopsis pm resource would go here adjfhadlskfhladskhf"]]

class KSOStaticData: NSObject {

}
