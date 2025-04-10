//
//  MessagesVC.swift
//  CometchatTestApp
//
//  Created by Srinivas Vangapally on 09/04/25.
//

import UIKit
import CometChatSDK
import CometChatUIKitSwift

class MessagesVC: UIViewController {
    var user: User?
    var group: Group?

    //Setting up header
    lazy var headerView: CometChatMessageHeader = {
        let headerView = CometChatMessageHeader()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        if let user = user { headerView.set(user: user) }
        if let group = group { headerView.set(group: group) }
        headerView.set(controller: self) //passing controller needs to be mandatory
        return headerView
    }()
    
    //Setting up composer
    lazy var composerView: CometChatMessageComposer = {
        let messageComposer = CometChatMessageComposer(frame: .null)
        if let user = user { messageComposer.set(user: user) }
        if let group = group { messageComposer.set(group: group) }
        messageComposer.set(controller: self)
        messageComposer.translatesAutoresizingMaskIntoConstraints = false
        return messageComposer
    }()

    //Setting up message list
    lazy var messageListView: CometChatMessageList = {
        let messageListView = CometChatMessageList(frame: .null)
        messageListView.translatesAutoresizingMaskIntoConstraints = false
        if let user = user { messageListView.set(user: user) }
        if let group = group { messageListView.set(group: group) }
        messageListView.set(controller: self)
        return messageListView
    }()


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.view.backgroundColor = .systemBackground
        buildUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func buildUI() {

        view.addSubview(headerView)
        view.addSubview(messageListView)
        view.addSubview(composerView)

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            messageListView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            messageListView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            messageListView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            composerView.topAnchor.constraint(equalTo: messageListView.bottomAnchor),
            composerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            composerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            composerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
