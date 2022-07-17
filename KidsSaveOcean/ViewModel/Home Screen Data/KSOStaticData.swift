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

let UserTypeViewData: KSODataArray = [["image_name": "Skater",
                                     "title": "I am a Student",
                                     "subTitle": "HOW I CAN HELP",
                                     "description": "Get started on a letter-writing campaign,\nwe’ll show you how!",
                                     "action": "aWbPiPh_gaU"],
                                    ["image_name": "Crab - teacher",
                                     "title": "I am a Teacher",
                                     "subTitle": "HOW I CAN HELP",
                                     "description": "We have lots of learning materials available to\nhelp you engage students.",
                                     "action": "aWbPiPh_gaU"],
                                    ["image_name": "Turtle - other",
                                     "title": "I want to support",
                                     "subTitle": "HOW I CAN HELP",
                                     "description": "Not a student or teacher? Your support is the\nbedrock of Fatechanger. Learn more.",
                                     "action": "aWbPiPh_gaU"]]

///// Perhaps we will get it later dynamically from web-services from backend.
let HomeViewData: KSODataArray = [["image_name": "theWavEs",
                                   "title": "Activism News - Keep Updated!",
                                   "subTitle": "CORONA ENDANGERS CLIMATE PROGRESS",
                                   "action": ""],
                                    ["image_name": "homePic2",
                                     "title": "Write Letters, Multiply Impact",
                                     "subTitle": "DEMAND PROTECTION OF OUR PLANET",
                                     "action": ""],
                                    ["image_name": "Imagery",
                                     "title": "Create New Environmental Policy",
                                     "subTitle": "PLASTIC & CLIMATE EMERGENCIES",
                                     "action": ""],
                                    ["image_name": "dashboardCopyForHomeScreenPic",
                                     "title": "Your Activist Dashboard",
                                     "subTitle": "LIGHT IT UP",
                                     "action": ""],
                                    ["image_name": "mapForCampaign",
                                     "title": "Letter Campaigns, Initiatives, Activism",
                                     "subTitle": "WATCH YOUTH IMPACT SPREAD",
                                     "action": ""],
                                    ["image_name": "Share_like_a_boss",
                                    "title": "Tips to share like a Boss",
                                    "subTitle": "CALL OUT TO THE PACK",
                                    "action": ""
                                    ]]

let KSONewsViewData: KSODataArray = [["image_name": "Map",
                                     "title": "Letter Writing Campaign",
                                     "subTitle": "UPDATES",
                                     "description": "See our progress",
                                     "action": ""],
                                    ["image_name": "Surfer",
                                     "title": "Peder Hill",
                                     "subTitle": "INTERVIEW",
                                     "description": "Q&A with the founder",
                                     "action": ""]
                                    ]

let KSONewsTableViewData: KSODataArray = [["image_name": "Whale",
                                          "title": "The Last Whale",
                                          "subTitle": "United Nations Clean Ocean Summit 2018"],
                                         ["image_name": "Diver",
                                          "title": "Exhibition pace",
                                          "subTitle": "Children's Whale sculpture seeks exhibition space"],
                                         ["image_name": "K",
                                          "title": "Kickstarter",
                                          "subTitle": "We're live! Help give kids a voice"]]

let KSOResourcesStudentsTableViewData: KSODataArray = [["image_name": "letter_tmp",
                                                       "title": "Example Letters",
                                                       "subTitle": "Here is some examples of letters students have written"],
                                                      ["image_name": "Contacts_tmp",
                                                       "title": "Country Contacts",
                                                       "subTitle": "Look up who is the best person to write to in your contry"],
                                                      ["image_name": "",
                                                       "title": "Resource Title 3...",
                                                       "subTitle": "Subtitle and synopsis pm resource would go here"],
                                                      ["image_name": "",
                                                       "title": "Resource Title 4...",
                                                       "subTitle": "Subtitle and synopsis pm resource would go here"],
                                                      ["image_name": "",
                                                       "title": "Resource Title 5...",
                                                       "subTitle": "Subtitle and synopsis pm resource would go here"]]

let KSOResourcesTeacherTableViewData: KSODataArray = [["image_name": "teaching_tmp",
                                                      "title": "Resource Title 1",
                                                      "subTitle": "Subtitle and synopsis pm resource would go here"],
                                                     ["image_name": "teaching_tmp",
                                                      "title": "Resource Title 2",
                                                      "subTitle": "Subtitle and synopsis pm resource would go here"],
                                                     ["image_name": "",
                                                      "title": "Resource Title 3",
                                                      "subTitle": "Subtitle and synopsis pm resource would go here adjfhadlskfhladskhf"],
                                                     ["image_name": "",
                                                      "title": "Resource Title 4",
                                                      "subTitle": "Subtitle and synopsis pm resource would go here adjfhadlskfhladskhf"],
                                                     ["image_name": "",
                                                      "title": "Resource Title 5",
                                                      "subTitle": "Subtitle and synopsis pm resource would go here adjfhadlskfhladskhf"]]

class KSOStaticData: NSObject {

}
