//
//  KSOAuthorization.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 5/16/19.
//  Copyright © 2019 KidsSaveOcean. All rights reserved.
//

import UIKit
import FirebaseAuth

let AUTORIZATION_URL_AUTHORIZE_DOMAIN  = "kids-save-ocean.firebaseapp.com"

class KSOAuthorization: NSObject {

    class func anonymousAuthorization(completion:(() -> Void)?) {

        if Auth.auth().currentUser != nil { // already signed in anonymously
            print("already signed in anonymously, UID: \(Auth.auth().currentUser!.uid)")
            completion?()
            return
        }

        Auth.auth().signInAnonymously { (authResult, error) in
            if error != nil {
                print("\nThere is a problem with anonimous authorization! \n")
                return
            }

            if authResult != nil, authResult?.user.uid != nil {
                print("Get signed in anonymously, UID: \(authResult!.user.uid)")
                completion?()
            }
        }
    }
}
