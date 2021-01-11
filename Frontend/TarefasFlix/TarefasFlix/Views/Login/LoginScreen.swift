//
//  LoginScreen.swift
//  AssignmentsFlix
//
//  Created by Diogo Fouto on 31/12/2020.
//

import SwiftUI

struct LoginScreen: View {
    var body: some View {
        NavigationView {
            VStack {
                LoginScreenHeader()
                FamilyGrid()
            }
            .offset(y: -25)
            .navigationBarHidden(true)
        }
        .navigationBarHidden(true)
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}
