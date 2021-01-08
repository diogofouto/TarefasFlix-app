//
//  LoginScreenHeader.swift
//  TarefasFlix
//
//  Created by Diogo Fouto on 08/01/2021.
//

import SwiftUI

struct LoginScreenHeader: View {
    var body: some View {
        VStack {
            Image("TarefasFlix Logo")
            Text("Quem está a ver?")
                .font(.title)
                .fontWeight(.medium)
                .offset(y: -30)
        }
    }
}

struct LoginScreenHeader_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreenHeader()
    }
}
