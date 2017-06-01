//
//  multiplayerHandler.swift
//  textRecognition
//
//  Created by Burak Gunerhanal on 10/04/2017.
//  Copyright © 2017 Burak Gunerhanal. All rights reserved.
//

import Foundation
import MultipeerConnectivity

class multiplayerHandler: NSObject, MCSessionDelegate {
    
    var session:MCSession!
    var peersID:MCPeerID!
    var browser:MCBrowserViewController!
    var advert:MCAdvertiserAssistant!
    
    func setupPeerWithDisplay(_ showName:String){
        peersID = MCPeerID(displayName: showName)
    }
    func setSession()
    {
        session = MCSession(peer: peersID)
        session.delegate = self
    }
    func setBrowser(){
        browser = MCBrowserViewController(serviceType: "my-game", session: session)
    }
    func selfAdvertise(_ advertise:Bool){
        if advertise{
            advert = MCAdvertiserAssistant(serviceType: "my-game", discoveryInfo: nil, session: session)
            advert!.start()
        }else{
            advert!.stop()
            advert = nil
        }
    }
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        let userInfo = ["peerID": peersID, "state": state.rawValue] as [String : Any]
        let notificationName = Notification.Name("MPC_DidChangeStateNotification")
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: notificationName, object: nil, userInfo: userInfo)
        }
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        
        let userInfo = ["data":data, "peerID":peersID] as [String : Any]
        let notificationName = Notification.Name("MPC_DidChangeReceiveDataNotification")
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: notificationName, object: nil, userInfo: userInfo)
        }
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL, withError error: Error?) {
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
    }
}
