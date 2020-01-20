//
//  UserViewModel.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 5/18/19.
//  Copyright © 2019 KidsSaveOcean. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import MapKit

enum UserType: Int { // we can get from from Firebase, bit it will stay here temporary
    case
    student,
    teacher,
    other
}

enum DashboardTasksScopes: Int, CaseIterable {
    case research, write_letter_about_plastic, write_letter_about_climate, share, local_politics, protest,  hijack_policy_selected, campaign

    var firebaseFieldName: String {
        switch self {
        case .research:
            return "dash_learn_about_problem"
        case .write_letter_about_plastic:
            return "dash_wrote_a_letter_about_plastic"
        case .write_letter_about_climate:
            return "dash_wrote_a_letter_about_climate"
        case .share:
            return "dash_share"
        case .local_politics:
            return "dash_joined_a_policy_hijack_campaign"
        case .protest:
            return "dash_protest"
        case .hijack_policy_selected:
            return "hijack_policy_selected"
        case .campaign:
            return "campaign"
//        case .write_letter:
//            return "dash_write_a_letter"
        
//        case .start_campaign:
//            return "dash_start_a_letter_writing_campaign"
        
        }
    }

    var dashboardTasks: String {
        switch self {
        case .research:
            return "Research plastic & climate"
//        case .write_letter:
//            return "Write your government a letter"
        case .share:
            return "Spread Fatechanger by sharing"
//        case .start_campaign:
//            return "Start a letter writing campaign"
        case .local_politics:
            return "Help create new environmental laws"
        case .protest:
            return "Take part in or organize a protest"
        case .write_letter_about_plastic:
            return "Write your government a letter about plastic"
        case .write_letter_about_climate:
            return "Write your government a letter about climate"
        default:
            return ""
        }
    }
}

var lettersWrittenKey: String {return  "user_letters_written"}
var userTypeKey: String {return "user_person_type"}
var hijackPolicySelectedKey: String {return "hijack_policy_selected"}
var campaignKey: String {return "campaign"}
var locationIdKey: String {return "location_id"}
var signaturesPledgedKey: String {return "signatures_pledged"}

class UserViewModel {
    let authorizedUser = Auth.auth().currentUser
    var databaseReferenece: DatabaseReference? //= Database.database().reference().child("USERS").child(Auth.auth().currentUser!.uid)
////// Zip2Sequence ?
    var parametersDisctionary: [String: Any?] = [ campaignKey: nil,
                                                  DashboardTasksScopes.local_politics.firebaseFieldName: false,
                                                  DashboardTasksScopes.research.firebaseFieldName: false,
                                                  DashboardTasksScopes.protest.firebaseFieldName: false,
                                                  DashboardTasksScopes.share.firebaseFieldName: false,
                                                  DashboardTasksScopes.write_letter_about_climate.firebaseFieldName: false,
                                                  DashboardTasksScopes.write_letter_about_plastic.firebaseFieldName: false,
                                                  hijackPolicySelectedKey: "",
                                                  locationIdKey: "",
                                                  signaturesPledgedKey: 0,
                                                  lettersWrittenKey: 0,
                                                  userTypeKey: 0
        ]

    var local_politics: Bool = false {
        willSet(newValue) {
            parametersDisctionary[DashboardTasksScopes.local_politics.firebaseFieldName] = newValue
        }
    }
    var research: Bool = false {
        willSet(newValue) {
            parametersDisctionary[DashboardTasksScopes.research.firebaseFieldName] = newValue
        }
    }
    var protest: Bool = false {
        willSet(newValue) {
            parametersDisctionary[DashboardTasksScopes.protest.firebaseFieldName] = newValue
        }
    }
    var share: Bool = false {
        willSet(newValue) {
            parametersDisctionary[DashboardTasksScopes.share.firebaseFieldName] = newValue
        }
    }
    var start_campaign: Bool = false
//    {
//        willSet(newValue) {
//            parametersDisctionary[DashboardTasksScopes.start_campaign.firebaseFieldName] = newValue
//        }
//    }
    
    //var write_letter: Bool = false
    var write_letter_about_climate: Bool = false {
        willSet(newValue) {
            parametersDisctionary[DashboardTasksScopes.write_letter_about_climate.firebaseFieldName] = newValue
            //setWrittingState()
        }
    }
    var write_letter_about_plastic: Bool = false {
        willSet(newValue) {
            parametersDisctionary[DashboardTasksScopes.write_letter_about_plastic.firebaseFieldName] = newValue
            //setWrittingState()
        }
    }
    var letters_written: Int = 0 {
        willSet(newValue) {
            parametersDisctionary[lettersWrittenKey] = newValue
        }
    }
    var user_type: UserType = .student {
        willSet(newValue) {
            parametersDisctionary[userTypeKey] = newValue.rawValue
        }
    }
    var hijack_policy_selected: String = "" {
        willSet(newValue) {
            parametersDisctionary[hijackPolicySelectedKey] = newValue
        }
    }
    
    var signatures_pledged: Int = 0 {
        willSet(newValue) {
            parametersDisctionary[signaturesPledgedKey] = newValue
        }
    }
    
    var location_id: String = "" {
        willSet(newValue) {
            parametersDisctionary[locationIdKey] = newValue
        }
    }
    
//    var campaign_id: String? {
//        willSet(newValue) {
//            guard let campaign_id = newValue else {return}
//            let campaign = CampaignViewModel.shared().campaigns.filter {$0.id == campaign_id}.first
//            guard campaign != nil else {return}
//            let campSignatures = CampaignSignatures(campaign_id: campaign_id, signatures_pledged: campaign!.signatures_pledged, signatures_collected: 0)
//            parametersDisctionary[campaignKey] = campSignatures.dictionary()
//        }
//    }
    
    var campaign: CampaignSignatures? = CampaignSignatures(campaing: [String: Any]()) {
        willSet(newValue) {
            if let newCampaign = newValue {
                parametersDisctionary[campaignKey] = newCampaign.dictionary()
            } else {
                parametersDisctionary[campaignKey] = nil
            }
        }
    }

    private static var sharedUserViewModel: UserViewModel = {
        let viewModel = UserViewModel()
        return viewModel
    }()

    class func shared() -> UserViewModel {
        if sharedUserViewModel.databaseReferenece == nil {
            sharedUserViewModel.fetchUserFBData()
        }
        return sharedUserViewModel
    }

    private func fetchUserFBData() {
        if Auth.auth().currentUser?.uid != nil {
            self.databaseReferenece = Database.database().reference().child("USERS").child(Auth.auth().currentUser!.uid)
            self.fetchUser {
                //self.setWrittingState()
                //NotificationCenter.default.post(name: Notification.Name(Settings.UserHasBeenLoadedNotificationName), object: nil)
            }
        }
    }

//    private func setWrittingState() {
//        self.write_letter = self.write_letter_about_plastic && self.write_letter_about_climate
//    }
    // swiftlint:disable cyclomatic_complexity
    // swiftlint:disable function_body_length
    func fetchUser(_ completion: (() -> Void)?) {

        databaseReferenece?.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let snapshotValue = snapshot.value as? NSDictionary else {
                return
            }

            for userFBData in snapshotValue {

                guard let parameterName = userFBData.key as? String else {
                    continue
                }

                //setTaskStatus(task: parameterName, value:  userFBData.value)

                switch parameterName {
                case DashboardTasksScopes.research.firebaseFieldName:
                    guard let value = userFBData.value as? Bool else {continue}
                    self.research = value
                    continue

//                case DashboardTasksScopes.write_letter.firebaseFieldName:
//                    guard let value = userFBData.value as? Bool else {continue}
//                    self.write_letter = value
//                    continue

                case DashboardTasksScopes.share.firebaseFieldName:
                    guard let value = userFBData.value as? Bool else {continue}
                    self.share = value
                    continue

//                case DashboardTasksScopes.start_campaign.firebaseFieldName:
//                    guard let value = userFBData.value as? Bool else {continue}
//                    self.start_campaign = value
//                    continue

                case DashboardTasksScopes.local_politics.firebaseFieldName:
                    guard let value = userFBData.value as? Bool else {continue}
                    self.local_politics = value
                    continue

                case DashboardTasksScopes.protest.firebaseFieldName:
                    guard let value = userFBData.value as? Bool else {continue}
                    self.protest = value
                    continue

                case lettersWrittenKey:
                    guard let value = userFBData.value as? Int else {continue}
                    self.letters_written = value
                    continue

                case userTypeKey:
                    guard let value = userFBData.value as? UserType else {continue}
                    self.user_type = value
                    continue
                    
                case DashboardTasksScopes.write_letter_about_plastic.firebaseFieldName:
                    guard let value = userFBData.value as? Bool else {continue}
                    self.write_letter_about_plastic = value
                    continue
                    
                case DashboardTasksScopes.write_letter_about_climate.firebaseFieldName:
                    guard let value = userFBData.value as? Bool else {continue}
                    self.write_letter_about_climate = value
                    continue
                    
                case hijackPolicySelectedKey:
                    guard let value = userFBData.value as? String else {continue}
                    self.hijack_policy_selected = value
                    continue
                    
                case campaignKey:
                    guard let value = userFBData.value as? [String: Any] else {continue}
                    self.campaign = CampaignSignatures(campaing: value)
                    //value
                    continue
                    
                case signaturesPledgedKey:
                    guard let value = userFBData.value as? Int else {continue}
                    self.signatures_pledged = value
                    //value
                    continue
                    
                case locationIdKey:
                    guard let value = userFBData.value as? String else {continue}
                    self.location_id = value
                    continue

                default:
                    continue
                }
            }

            print("\nuser has been fetched, view model has been updated\n")

            if completion != nil {
                completion!()
            }
        })
    }
    // swiftlint:enable function_body_length
    // swiftlint:enable cyclomatic_complexity

    private func setTaskStatus(task: DashboardTasksScopes, value: Bool) {
        switch task {
        case .research:
            self.research = value

//        case .write_letter:
//            self.write_letter = value

        case.share:
            self.share = value

//        case .start_campaign:
//            self.start_campaign = value

        case .local_politics:
            self.local_politics = value

        case .protest:
            self.protest = value
            
        case .write_letter_about_plastic:
            self.write_letter_about_plastic = value
            
        case .write_letter_about_climate:
            self.write_letter_about_climate = value
            
        default:
            break
        }
    }

    private func getTaskStatus(_ task: DashboardTasksScopes) -> Bool {
        switch task {
        case .research:
            return self.research

//        case .write_letter:
//            return self.write_letter

        case.share:
            return self.share

//        case .start_campaign:
//            return self.start_campaign

        case .local_politics:
            return self.local_politics

        case .protest:
            return self.protest
            
        case .write_letter_about_plastic:
            return self.write_letter_about_plastic
            
        case .write_letter_about_climate:
            return self.write_letter_about_climate
            
        default:
            return false
        }
    }

    func saveUser() {
        parametersDisctionary[userTypeKey] = self.user_type.rawValue
        databaseReferenece?.setValue(parametersDisctionary) { (error: Error?, _: DatabaseReference) in
            if error != nil {
                print("parameters for update: \(self.parametersDisctionary)")
                fatalError(error!.localizedDescription)  // TODO app should not crash if there is some problem with database
            } else {
                print("\nUser saved successfully")
            }
        }
    }

    func saveCompletionTaskStatuses(_ values: [Bool]) {
        UserDefaultsHelper.saveCompletionTasksStatus(values) // just for any case
        for (i, task) in DashboardTasksScopes.allCases.enumerated() {
            setTaskStatus(task: task, value: values[i])
        }
    }

    func getCompletionTasksStatuses() -> [Bool] {

        //var userDefsStatuses = Settings.getCompletionTasksStatus()
        var taskStatuses = [Bool]()

        for task in DashboardTasksScopes.allCases {
            taskStatuses.append(getTaskStatus(task))
        }
        return taskStatuses
    }

    func increaseLetterWrittenCount() {
        letters_written += 1
        saveUser()
    }

    class func getDashboardTasks() -> [DashboardTasksScopes] {
       return DashboardTasksScopes.allCases.map { $0 }
    }

    class func getDashboardFullTasks() -> [String] {
       return DashboardTasksScopes.allCases.map { $0.dashboardTasks }
    }
    
    func isUserLocationCampaignIsLive() -> Bool {
        let campaignLive = campaign != nil ? CampaignViewModel.shared().campaigns.filter({$0.id == campaign?.campaign_id}).first?.live : false
        return campaignLive ?? false
        
    }
}
