//
//  OpenTok.swift
//  Hugo Med
//
//  Created by Miranz  Technologies on 12/23/20.
//  Copyright © 2020 Ayaz Alavi. All rights reserved.
//

import Foundation
import UIKit
import OpenTok


class OpenTok: NSObject {
    var session: OTSession?
    var publisher: OTPublisher?
    var subscriber: OTSubscriber?
    var apiKey, sessionID, token: String
    var error: OTError? {
        didSet {
            print("opentok: errors: \(String(describing: oldValue)) --- \(String(describing: error))")
        }
    }
    
    static var current: OpenTok?
    
    weak var delegate: OTSessionDelegate? {
        didSet {
            print ("delegate is set")
        }
    }
    
    init (apiKey: String, sessionID: String, token: String) {
        
        self.apiKey = apiKey
        self.sessionID = sessionID
        self.token = token
        super.init()
        OpenTok.current = self
    }
    
    func connect() throws {
        if delegate == nil {
            delegate = self
        }
        print("opentok: apikey: \(self.apiKey)---session:\(self.sessionID)---token:\(self.token)---")
        self.session = OTSession(apiKey: "47057204", sessionId: "1_MX40NzA1NzIwNH5-MTYwODgxMjI5NTk4N35hVHNEWkVKYXhyV1RTaUhtN2RqYmpKcGJ-fg", delegate: delegate)
        self.session?.connect(withToken: "T1==cGFydG5lcl9pZD00NzA1NzIwNCZzaWc9OGEwZTc2NDU5NzU5MmNhMjYzMDQwNTc5ZjVlOGFhMWFiY2Y2YzZhZjpzZXNzaW9uX2lkPTFfTVg0ME56QTFOekl3Tkg1LU1UWXdPRGd4TWpJNU5UazROMzVoVkhORVdrVktZWGh5VjFSVGFVaHROMlJxWW1wS2NHSi1mZyZjcmVhdGVfdGltZT0xNjA4ODEyMzEyJm5vbmNlPTAuNDM4ODQyNTA0NDY4MjQ0OSZyb2xlPXB1Ymxpc2hlciZleHBpcmVfdGltZT0xNjA4ODk4NzExJmluaXRpYWxfbGF5b3V0X2NsYXNzX2xpc3Q9", error: &error)
        if error != nil {
            throw AppErrors.OpenTokConnectionNoMade
        }
    }
    
    func disconnect() {
        self.session = nil
        OpenTok.current = nil
        print("Opentok: disconnect called")
    }
    
    func subscribe (stream: OTStream, session: OTSession) {
        subscriber = OTSubscriber(stream: stream, delegate: self)
        guard let subscriber = subscriber else {
            return
        }

        var error: OTError?
        session.subscribe(subscriber, error: &error)
        guard error == nil else {
            print(error!)
            return
        }
    }
}


extension OpenTok: OTSessionDelegate {
    func sessionDidConnect(_ session: OTSession) {
       print("opentok: The client connected")
    }

    func sessionDidDisconnect(_ session: OTSession) {
       print("opentok: The client disconnected")
    }

    func session(_ session: OTSession, didFailWithError error: OTError) {
        print("opentok: \(error.code).")
        
    }

    func session(_ session: OTSession, streamCreated stream: OTStream) {
       print("opentok: A stream was created")
    }

    func session(_ session: OTSession, streamDestroyed stream: OTStream) {
       print("opentok: A stream was destroyed")
    }
}

extension OpenTok: OTSubscriberDelegate {
    public func subscriberDidConnect(toStream subscriber: OTSubscriberKit) {
        print("opentok: The subscriber did connect to the stream.")
    }

    public func subscriber(_ subscriber: OTSubscriberKit, didFailWithError error: OTError) {
        print("opentok: The subscriber failed to connect to the stream.")
    }
}
