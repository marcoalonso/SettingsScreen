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
    private let mailComposeDelegate = MailDelegate()
    private let messageComposeDelegate = MessageDelegate()
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        ///Llamadas
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
                        
                        ///Email
                        Button {
                            self.presentMailCompose()
                        } label: {
                            HStack {
                                Image(systemName: "mail")
                                Text("Enviar correo")
                            }
                        }
                        
                        ///Mensaje texto
                        Button {
                            self.presenteMessageCompose()
                        } label: {
                            HStack {
                                Image(systemName: "message")
                                Text("Enviar mensaje texto")
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


extension ContentView {
    private class MailDelegate: NSObject, MFMailComposeViewControllerDelegate {
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            controller.dismiss(animated: true)
        }
    }
    
    private func presentMailCompose(){
        guard MFMailComposeViewController.canSendMail() else {
            return
        }
        
        let vc = UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.rootViewController
        
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = mailComposeDelegate
        composeVC.setToRecipients(["marcoalonsoiosdeveloper@gmail.com"])
        composeVC.setSubject("Información")
        composeVC.setMessageBody("Hola", isHTML: false)
        vc?.present(composeVC, animated: true)
    }
}

extension ContentView {
    private class MessageDelegate: NSObject, MFMessageComposeViewControllerDelegate {
        func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
            controller.dismiss(animated: true)
        }
    }
    
    private func presenteMessageCompose(){
        guard MFMessageComposeViewController.canSendText() else {
            return
        }
        
        let vc = UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.rootViewController
        
        let composeVC = MFMessageComposeViewController()
        composeVC.messageComposeDelegate = messageComposeDelegate
        composeVC.recipients = ["4432282860"]
        composeVC.body = "Hola como estas!"
        vc?.present(composeVC, animated: true)
    }
}
