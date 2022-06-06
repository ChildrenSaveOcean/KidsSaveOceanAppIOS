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

class UserTaskViewModel: Codable {

    enum CodingKeys: String, CodingKey {

        // Dashboard tasks
        case localPolitics = "dash_joined_a_policy_hijack_campaign"
        case research = "dash_learn_about_problem"
        case protest = "dash_protest"
        case share = "dash_share"
        case writeLetterAboutClimate = "dash_wrote_a_letter_about_climate"
        case writeLetterAboutPlastic = "dash_wrote_a_letter_about_plastic"

        // Other properties
        case lettersWritten = "user_letters_written"
        case userType = "user_person_type"
        case hijackPolicySelected = "hijack_policy_selected"
        case signaturesPledged = "signatures_pledged"
        case locationId = "location_id"
    }

    var localPolitics: Bool = false
    var research: Bool = false
    var protest: Bool = false
    var share: Bool = false
    var startCampaign: Bool = false
    var writeLetterAboutClimate: Bool = false
    var writeLetterAboutPlastic: Bool = false
    var lettersWritten: Int = 0
    var userType: UserType = .student
    var hijackPolicySelected: String = ""
    var signaturesPledged: Int = 0
    var locationId: String = ""
    var campaign = CampaignSignatures(with: [String: Any]())

    static var shared = UserTaskViewModel()

    static var databaseRef: DatabaseReference? {

        guard let userId = Auth.auth().currentUser?.uid else { return nil }

        return Database.database().reference().child("USERS").child( userId )
    }

    static func fetchUserFBData() {

        databaseRef?.observeSingleEvent(of: .value) {  snapshot in

            guard let dictionary = snapshot.value as? Dictionary<String, Any>,
                let userViewModel = UserTaskViewModel(with: dictionary) else {
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

    func setTaskStatus(task: DashboardTask, value: Bool) {
        switch task {
        case .research:
            self.research = value

        case.share:
            self.share = value

        case .local_politics:
            self.localPolitics = value

        case .protest:
            self.protest = value
            
        case .write_letter_about_plastic:
            self.writeLetterAboutPlastic = value
            
        case .write_letter_about_climate:
            self.writeLetterAboutClimate = value
            
        default:
            break
        }
    }

    func getTaskStatus(_ task: DashboardTask) -> Bool {
        switch task {
        case .research:
            return self.research

        case.share:
            return self.share

        case .local_politics:
            return self.localPolitics

        case .protest:
            return self.protest
            
        case .write_letter_about_plastic:
            return self.writeLetterAboutPlastic
            
        case .write_letter_about_climate:
            return self.writeLetterAboutClimate
            
        default:
            return false
        }
    }

    func saveUser() {

        let completionTasksStates = DashboardTask.allCases.map{ getTaskStatus($0) }
        UserDefaultsHelper.saveCompletionTasksStatus(completionTasksStates)
        UserDefaultsHelper.saveLetterNumber(lettersWritten)

        let userModelDictionary = self.dictionaryRepresentation

        UserTaskViewModel.databaseRef?.setValue(userModelDictionary) { (error: Error?, _: DatabaseReference) in

            if let error = error {
                print("UserViewModel saving failed, parameters for update: \(String(describing: userModelDictionary))")
                fatalError(error.localizedDescription)
            }

            print("\nUser saved successfully")
        }
    }

    func increaseLetterWrittenCount() {
        lettersWritten += 1
        saveUser()
    }

    class func getDashboardTasks() -> [DashboardTask] {
       return DashboardTask.allCases
    }

    class func getDashboardTaskTitles() -> [String] {
       return DashboardTask.allCases.map { $0.title }
    }
    
    func isUserLocationCampaignIsLive() -> Bool {
        let campaignLive = CampaignViewModel.shared.campaigns.filter({$0.id == campaign?.campaignId}).first?.live
        return campaignLive ?? false
        
    }
}
