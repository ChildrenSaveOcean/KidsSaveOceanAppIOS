//
//  UserViewModel.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 5/18/19.
//  Copyright © 2019 KidsSaveOcean. All rights reserved.
//

import Foundation
import Firebase
import MapKit

enum UserType: Int { // we can get from from Firebase, bit it will stay here temporary
    case
    student,
    teacher,
    other
}

enum dashboardTasksScopes: Int, CaseIterable {
    case research, write_letter, share, start_campaign, local_politics, protest

    var firebaseFieldName: String {
        switch self {
        case .research:
            return "dash_learn_about_problem"
        case .write_letter:
            return "dash_write_a_letter"
        case .share:
            return "dash_share"
        case .start_campaign:
            return "dash_start_a_letter_writing_campaign"
        case .local_politics:
            return "dash_become_active_in_local_politics"
        case .protest:
            return "dash_protest"
        }
    }

    var dashboardTasks: String {
        switch self {
        case .research:
            return "Research plastic ocean pollution"
        case .write_letter:
            return "Write your government a letter"
        case .share:
            return "Spread Fatechanger by sharing"
        case .start_campaign:
            return "Start a letter writing campaign"
        case .local_politics:
            return "Seek change through local government"
        case .protest:
            return "Take part in or organize a protest"
        }
    }
}

var lettersWrittenKey: String {return  "user_letters_written"}
var userTypeKey: String {return "user_person_type"}

class UserViewModel {

    let authorizedUser = Auth.auth().currentUser
    let databaseReferenece: DatabaseReference //= Database.database().reference().child("USERS").child(Auth.auth().currentUser!.uid)

    var parametersDisctionary: [String: Any] = [ dashboardTasksScopes.research.firebaseFieldName: false,
                                                  dashboardTasksScopes.write_letter.firebaseFieldName: false,
                                                  dashboardTasksScopes.share.firebaseFieldName: false,
                                                  dashboardTasksScopes.start_campaign.firebaseFieldName: false,
                                                  dashboardTasksScopes.local_politics.firebaseFieldName: false,
                                                  dashboardTasksScopes.protest.firebaseFieldName: false,
                                                  lettersWrittenKey: 0,
                                                  userTypeKey: 0 ]

    var local_politics: Bool = false {
        willSet(newValue) {
            parametersDisctionary[dashboardTasksScopes.local_politics.firebaseFieldName] = newValue
        }
    }
    var research: Bool = false {
        willSet(newValue) {
            parametersDisctionary[dashboardTasksScopes.research.firebaseFieldName] = newValue
        }
    }
    var protest: Bool = false {
        willSet(newValue) {
            parametersDisctionary[dashboardTasksScopes.protest.firebaseFieldName] = newValue
        }
    }
    var share: Bool = false {
        willSet(newValue) {
            parametersDisctionary[dashboardTasksScopes.share.firebaseFieldName] = newValue
        }
    }
    var start_campaign: Bool = false {
        willSet(newValue) {
            parametersDisctionary[dashboardTasksScopes.start_campaign.firebaseFieldName] = newValue
        }
    }
    var write_letter: Bool = false {
        willSet(newValue) {
            parametersDisctionary[dashboardTasksScopes.write_letter.firebaseFieldName] = newValue
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

    private static var sharedUserViewModel: UserViewModel = {
        let viewModel = UserViewModel(databaseRef: Database.database().reference())
        return viewModel
    }()

    class func shared() -> UserViewModel {
        return sharedUserViewModel
    }

    init(databaseRef: DatabaseReference) {
        self.databaseReferenece = databaseRef.child("USERS").child(Auth.auth().currentUser!.uid)
        self.fetchUser {
            //NotificationCenter.default.post(name: Notification.Name(Settings.UserHasBeenLoadedNotificationName), object: nil)
        }
    }

    func fetchUser(_ completion: (() -> Void)?) {

        databaseReferenece.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let snapshotValue = snapshot.value as? NSDictionary else {
                return
            }

            for userFBData in snapshotValue {

                guard let parameterName = userFBData.key as? String else {
                    continue
                }

                //setTaskStatus(task: parameterName, value:  userFBData.value)

                switch parameterName {
                case dashboardTasksScopes.research.firebaseFieldName:
                    guard let value = userFBData.value as? Bool else {continue}
                    self.research = value
                    continue

                case dashboardTasksScopes.write_letter.firebaseFieldName:
                    guard let value = userFBData.value as? Bool else {continue}
                    self.write_letter = value
                    continue

                case dashboardTasksScopes.share.firebaseFieldName:
                    guard let value = userFBData.value as? Bool else {continue}
                    self.share = value
                    continue

                case dashboardTasksScopes.start_campaign.firebaseFieldName:
                    guard let value = userFBData.value as? Bool else {continue}
                    self.start_campaign = value
                    continue

                case dashboardTasksScopes.local_politics.firebaseFieldName:
                    guard let value = userFBData.value as? Bool else {continue}
                    self.local_politics = value
                    continue

                case dashboardTasksScopes.protest.firebaseFieldName:
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

    private func setTaskStatus(task: dashboardTasksScopes, value: Bool) {
        switch task {
        case .research:
            self.research = value

        case .write_letter:
            self.write_letter = value

        case.share:
            self.share = value

        case .start_campaign:
            self.start_campaign = value

        case .local_politics:
            self.local_politics = value

        case .protest:
            self.protest = value
        }
    }

    private func getTaskStatus(_ task: dashboardTasksScopes) -> Bool {
        switch task {
        case .research:
            return self.research

        case .write_letter:
            return self.write_letter

        case.share:
            return self.share

        case .start_campaign:
            return self.start_campaign

        case .local_politics:
            return self.local_politics

        case .protest:
            return self.protest
        }
    }

    func saveUser() {
        parametersDisctionary[userTypeKey] = self.user_type.rawValue
        databaseReferenece.setValue(parametersDisctionary) { (error: Error?, _: DatabaseReference) in
            if error != nil {
                fatalError(error!.localizedDescription)  // TODO app should not crash if there is some problem with database
            } else {
                print("\nUser saved successfully")
            }
        }
    }

    func saveCompletionTaskStatuses(_ values: [Bool]) {
        Settings.saveCompletionTasksStatus(values) // just for any case
        for (i, task) in dashboardTasksScopes.allCases.enumerated() {
            setTaskStatus(task: task, value: values[i])
        }
    }

    func getCompletionTasksStatuses() -> [Bool] {

        //var userDefsStatuses = Settings.getCompletionTasksStatus()
        var taskStatuses = [Bool]()

        for task in dashboardTasksScopes.allCases {
            taskStatuses.append(getTaskStatus(task))
        }
        return taskStatuses
    }

    func increaseLetterWrittenCount() {
        letters_written += 1
        saveUser()
    }

    class func getDashboardTasks() -> [dashboardTasksScopes] {
       return dashboardTasksScopes.allCases.map { $0 }
    }

    class func getDashboardFullTasks() -> [String] {
       return dashboardTasksScopes.allCases.map { $0.dashboardTasks }
    }
}
