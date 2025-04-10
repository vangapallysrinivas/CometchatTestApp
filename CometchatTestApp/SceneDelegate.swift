//
//  SceneDelegate.swift
//  CometchatTestApp
//
//  Created by Srinivas Vangapally on 10/04/25.
//

import UIKit
import CometChatSDK
import CometChatUIKitSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let uikitSettings = UIKitSettings()
            .set(appID: "2729923f7f9e5695")
            .set(authKey: "27ae4b82a254521957c10ffea3cad0dcdc118e9a")
            .set(region: "IN")
            .subscribePresenceForAllUsers()
            .build()
        
        CometChatUIKit.init(uiKitSettings: uikitSettings) { result in
            switch result {
            case .success:
                debugPrint("CometChatUIKit initialization succeeded")
                
                let uid = "cometchat-uid-1"
                
                CometChatUIKit.login(uid: uid) { loginResult in
                    switch loginResult {
                    case .success:
                        debugPrint("CometChatUIKit login succeeded")
                        // open CometChat Conversations
                        DispatchQueue.main.async {
                            self.navigateToCommentChatUsersConversation()
                        }
                        
                    case .onError(let error):
                        debugPrint("CometChatUIKit login failed with error: \(error.description)")
                    @unknown default:
                        break
                    }
                }
                
            case .failure(let error):
                debugPrint("CometChatUIKit initialization failed with error: \(error.localizedDescription)")
            }
        }
    }
    
    func navigateToCommentChatConversation() {
        let conversationRequestBuilder = ConversationRequest.ConversationRequestBuilder(limit: 20).setConversationType(conversationType: .group)
        let cometChatConversations = CometChatConversations()
        CometChatStatusIndicator.style.cornerRadius = CometChatCornerStyle(cornerRadius: 8)
        CometChatStatusIndicator.style.backgroundColor = UIColor(hex: "#F76808")
        cometChatConversations.set(conversationRequestBuilder: conversationRequestBuilder)
        
        let navController = UINavigationController(rootViewController: cometChatConversations)
        //Conversations onItemClick click
        cometChatConversations.set(onItemClick: { [weak self] conversation, indexPath in
            // Your code to handlelick
            let messages = MessagesVC()
            messages.group = (conversation.conversationWith as? Group)
            messages.user = (conversation.conversationWith as? CometChatSDK.User)
            navController.pushViewController(messages, animated: true)
        })

        self.window?.rootViewController = navController
        self.window?.makeKeyAndVisible()
    }
    
    /**
            
     */
    func navigateToCommentChatUsersConversation() {
        let cometChatUsers = CometChatUsers()
        let navController = UINavigationController(rootViewController: cometChatUsers)
        //Conversations onItemClick click
        cometChatUsers.set(onItemClick: { user, indexPath in
            // Your code to handlelick
            let messages = MessagesVC()
            messages.user = user
            navController.pushViewController(messages, animated: true)
        })

        self.window?.rootViewController = navController
        self.window?.makeKeyAndVisible()
    }


    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

