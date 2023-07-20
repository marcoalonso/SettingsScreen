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
    @AppStorage("isDarkModeOn") private var isDarkModeOn = false
    
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
                        
                        ///Sugerencia
                        Link(destination: URL(string: "https://forms.gle/guA95kfHXphQHgbx5")!) {
                            HStack {
                                Image(systemName: "pencil")
                                Text("Hacer una sugerencia")
                            }
                        }
                        
                        ///WhatsApp
                        Button {
                            openWhatsApp()
                        } label: {
                            HStack {
                                Image(systemName: "phone.bubble.left")
                                Text("Enviar WhatsApp")
                            }
                        }
                    } header: {
                        Text("Contacto")
                    }

                    // MARK:  Informacion
                    Section(header: Text("Información")) {
                        Link(destination: URL(string: "https://github.com/marcoalonso")!) {
                            HStack {
                                Image(systemName: "person")
                                Text("Desarrollador")
                            }
                        }
                        
                        Link(destination: URL(string: "https://www.youtube.com/@marcoalonso3284")!) {
                            HStack {
                                Image(systemName: "play.display")
                                Text("YouTube Channel")
                            }
                        }
                        ///iOS Bootcamp Mx
                        ///
                        Link(destination: URL(string: "https://mx.linkedin.com/company/ios-bootcamp-mx?trk=public_post_reshare_feed-actor-name")!) {
                            HStack {
                                Image(systemName: "apps.iphone")
                                Text("iOS Bootcamp Mx - LinkedIn")
                            }
                        }
                        
                        Link(destination: URL(string: "https://www.facebook.com/people/IOS-Bootcamp-Mx/100090332195526/")!) {
                            HStack {
                                Image(systemName: "apps.iphone")
                                Text("iOS Bootcamp Mx - Facebook")
                            }
                        }
                    }//Section
                    
                    Section(header: Text("Apariencia"), footer: Text("Opciones de configuracion")) {
                        Toggle(isOn: $isDarkModeOn) {
                            Text("Dark Mode")
                        }
                    }
                    
                }//: Form
            }
            .navigationTitle("Settings")
        }
    }
    
    func openWhatsApp(){
        let whatsappUrl = URL(string: "https://api.whatsapp.com/send?phone=4432282860&text=Hola")!
        if UIApplication.shared.canOpenURL(whatsappUrl) {
            UIApplication.shared.open(whatsappUrl)
        } else {
            print("No tiene la app WhatsApp instalada ")
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
