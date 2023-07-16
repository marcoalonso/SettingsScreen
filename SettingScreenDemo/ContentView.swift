//
//  ContentView.swift
//  SettingScreenDemo
//
//  Created by Marco Alonso Rodriguez on 16/07/23.
//

import SwiftUI
import MessageUI

struct ContentView: View {
    
    let phoneNumber = "4432282860"
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        Button {
                            if let phoneURL = URL(string: "tel://\(phoneNumber)") {
                                UIApplication.shared.open(phoneURL)
                            }
                        } label: {
                            HStack {
                                Image(systemName: "phone")
                                Text("Llamar")
                            }
                        }
                    } header: {
                        Text("Contacto")
                    }


                }
            }
            .navigationTitle("Settings")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


