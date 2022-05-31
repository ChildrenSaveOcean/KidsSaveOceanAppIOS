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

enum DashboardTask: Int, CaseIterable {
    case research, write_letter_about_plastic, write_letter_about_climate, share, local_politics, protest,  hijack_policy_selected, campaign

    var title: String {
        switch self {
        case .research:
            return "Research plastic & climate emergencies"
        case .share:
            return "Spread Fatechanger by sharing"
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

class UserViewModel: Codable {

    enum CodingKeys: String, CodingKey {
        case local_politics = "dash_joined_a_policy_hijack_campaign"
        case research = "dash_learn_about_problem"
        case protest = "dash_protest"
        case share = "dash_share"
        case write_letter_about_climate = "dash_wrote_a_letter_about_climate"
        case write_letter_about_plastic = "dash_wrote_a_letter_about_plastic"

        case letters_written = "user_letters_written"
        case user_type = "user_person_type"
        case hijack_policy_selected = "hijack_policy_selected"
        case signatures_pledged = "signatures_pledged"
        case location_id = "location_id"
    }

    var local_politics: Bool = false
    var research: Bool = false
    var protest: Bool = false
    var share: Bool = false
    var start_campaign: Bool = false
    var write_letter_about_climate: Bool = false
    var write_letter_about_plastic: Bool = false
    var letters_written: Int = 0
    var user_type: UserType = .student
    var hijack_policy_selected: String = ""
    var signatures_pledged: Int = 0
    var location_id: String = ""
    var campaign = CampaignSignatures(campaing: [String: Any]())

    private let authorizedUser = Auth.auth().currentUser

    static var shared = UserViewModel()

    static func fetchUserFBData() {

        guard let userId = Auth.auth().currentUser?.uid else { return }
        Database.database().reference().child("USERS").child( userId ).observeSingleEvent(of: .value) {  snapshot in

            guard let dictionary = snapshot.value as? Dictionary<String, Any>,
                let userViewModel = UserViewModel(with: dictionary) else {
                return
            }

            shared = userViewModel
            shared.userDataHasBeenLoaded = true
        }

    }

    var userDataHasBeenLoaded = false {
        didSet {
            if userDataHasBeenLoaded {
                NotificationCenter.default.post(name: .userDataHasBeenLoaded, object: nil)
            }
        }
    }

    private func setTaskStatus(task: DashboardTask, value: Bool) {
        switch task {
        case .research:
            self.research = value

        case.share:
            self.share = value

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

    private func getTaskStatus(_ task: DashboardTask) -> Bool {
        switch task {
        case .research:
            return self.research

        case.share:
            return self.share

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

        guard let userId = Auth.auth().currentUser?.uid else { return }

        let userModelDictionary = self.dictionaryRepresentation

        Database.database().reference().child("USERS").child( userId )
            .setValue(userModelDictionary) { (error: Error?, _: DatabaseReference) in

            if let error = error {
                print("UserViewModel saving failed, parameters for update: \(String(describing: userModelDictionary))")
                fatalError(error.localizedDescription)
            }

            print("\nUser saved successfully")
        }
    }

    func saveCompletionTaskStatuses(_ values: [Bool]) {
        UserDefaultsHelper.saveCompletionTasksStatus(values) // just for any case
        for (i, task) in DashboardTask.allCases.enumerated() {
            setTaskStatus(task: task, value: values[i])
        }
    }

    func getCompletionTasksStatuses() -> [Bool] {

        //var userDefsStatuses = Settings.getCompletionTasksStatus()
        var taskStatuses = [Bool]()

        for task in DashboardTask.allCases {
            taskStatuses.append(getTaskStatus(task))
        }
        return taskStatuses
    }

    func increaseLetterWrittenCount() {
        letters_written += 1
        saveUser()
    }

    class func getDashboardTasks() -> [DashboardTask] {
       return DashboardTask.allCases
    }

    class func getDashboardTaskTitles() -> [String] {
       return DashboardTask.allCases.map { $0.title }
    }
    
    func isUserLocationCampaignIsLive() -> Bool {
        let campaignLive = CampaignViewModel.shared().campaigns.filter({$0.id == campaign.campaign_id}).first?.live
        return campaignLive ?? false
        
    }
}
