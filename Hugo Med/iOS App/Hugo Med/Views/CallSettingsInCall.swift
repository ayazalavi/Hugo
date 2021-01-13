//
//  ConsultationPopover.swift
//  Hugo Med
//
//  Created by Miranz  Technologies on 8/27/20.
//  Copyright © 2020 Ayaz Alavi. All rights reserved.
//

import Foundation
import UIKit
import OpenTok

class CallSettingsInCall:  HugoMedUIViewController {
    
    let doctor: DoctorCard
    let appointment: Appointment_Response
    let comm_keys: Communication
    let openTok: OpenTok
    let contentStyle: Content = String.scanFor(key: .popover_title)
    let contentStyle2: Content = String.scanFor(key: .popover_subtitle)
    let contentStyle3: Content = String.scanFor(key: .welcome_button)
        
    // MARK: LIFE CYCLE METHODS, INITIALIZERS, ACTIONS AND EVENTS
    init?(doctor: DoctorCard) {
        guard let appointment = AppData.shared.appointment_response, let comm_keys = AppData.shared.comm_keys else {  fatalError("no appointment made") }
        self.doctor = doctor
        self.appointment = appointment
        self.comm_keys = comm_keys
        self.openTok = OpenTok(apiKey: comm_keys.api, sessionID: comm_keys.session, token: comm_keys.videotoken)
        super.init(nibName: nil, bundle: nil)
        self.openTok.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBarColor = .clear
        navBarTintColor = .white
        navBarTitle = nil
        navBarTitleImage = "hugo-logo"
        self.view.backgroundColor = .white
        do {
            try self.openTok.connect()
        } catch AppErrors.OpenTokSessionNotMade, AppErrors.OpenTokConnectionNoMade {
            print("opentok error: session/connection not made")
        } catch {
            print("opentok error: \(error)")
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: UIButton.customButton(image: #imageLiteral(resourceName: "back-arrow").withRenderingMode(.alwaysTemplate), tintColor: navBarTintColor, selector: #selector(popViewController), target: self))
        navigationItem.rightBarButtonItem = nil
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let publisherView = openTok.publisher?.view  {
            publisherView.frame = view.bounds
            publisherView.setNeedsLayout()
        }
        self.cameraview.frame = view.bounds
        NSLayoutConstraint.activate([
            controls.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            textandButtons.widthAnchor.constraint(equalTo: view.widthAnchor),
            textandButtons.topAnchor.constraint(equalTo: controls.bottomAnchor, constant: 23),
            textandButtons.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -74)
        ])
    }
    
    // MARK: ACTIONS
    
    @objc func popViewController() {
        var error: OTError?
        openTok.session?.disconnect(&error)
        
    }
    
    @objc func toggleAudio(_ sender: UIView) {
        if let audio = sender as? UIButton {
            audio.isSelected = !audio.isSelected
            openTok.publisher?.publishAudio = !audio.isSelected
        }
    }
    
    @objc func toggleVideo(_ sender: UIView) {
        if let video = sender as? UIButton {
            video.isSelected = !video.isSelected
            self.cameraview.backgroundColor = video.isSelected ? .black : .gray
            openTok.publisher?.publishVideo = !video.isSelected
        }
    }
    
    @objc func startCall() {
        let controller = InCall(doctor: self.doctor, openTok: openTok)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    // MARK: VIEWs
    lazy private var controls: UIStackView = {
        let button1 = UIButton.customButton(image: #imageLiteral(resourceName: "audio-on"), tintColor: .clear, selector: #selector(toggleAudio), target: self)
        button1.setImage(#imageLiteral(resourceName: "audio-off"), for: .selected)
        button1.widthAnchor.constraint(equalToConstant: 60).isActive = true
        button1.heightAnchor.constraint(equalToConstant: 60).isActive = true
        let button2 = UIButton.customButton(image: #imageLiteral(resourceName: "video-on"), tintColor: .clear, selector: #selector(toggleVideo), target: self)
        button2.setImage(#imageLiteral(resourceName: "video-off"), for: .selected)
        button2.widthAnchor.constraint(equalToConstant: 60).isActive = true
        button2.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        let view_ = UIStackView(arrangedSubviews: [button1, button2])
        view_.axis = .horizontal
        view_.alignment = .center
        view_.distribution = .equalSpacing
        view_.spacing = 26
        view_.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(view_)
        return view_
    }()
    
    // MARK: VIEWs
    lazy private var textandButtons: UIStackView = {
        let label_ = UILabel.label()
        label_.text = "Estamos a punto de comenzar"
        label_.font = self.contentStyle.getFont()
        label_.textColor = .white
        label_.sizeToFit()
        let label__ = UILabel.label()
        label__.text = "Configura tu opciones de inicio"
        label__.font = self.contentStyle2.getFont()
        label__.textColor = .white
        label__.sizeToFit()
        let button1 = UIButton.mainButton(text: NSAttributedString(string: "INICIAR", attributes: [NSAttributedString.Key.font: self.contentStyle3.getFont(), NSAttributedString.Key.foregroundColor: UIColor.white]), radius: 22, backGroundColor: UIColor.hexStringToUIColor(hex: "#6ADBC4"), spacing: 1.73)
        button1.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width - 54, height: 44)
        button1.widthAnchor.constraint(equalToConstant: self.view.frame.size.width - 54).isActive = true
        button1.heightAnchor.constraint(equalToConstant: 44).isActive = true
        button1.addTarget(self, action: #selector(startCall), for: .touchUpInside)
        button1.layer.shadowColor = UIColor.hexStringToUIColor(hex: "#878787").withAlphaComponent(0.14).cgColor
        button1.layer.shadowOffset = CGSize(width: 0, height: 2)
        let view_ = UIStackView(arrangedSubviews: [label_, label__, button1])
        view_.alignment = .center
        view_.spacing = 8
        view_.axis = .vertical
        view_.translatesAutoresizingMaskIntoConstraints = false
        view_.setCustomSpacing(23, after: label__)
        self.view.addSubview(view_)
        return view_
    }()
    
    lazy private var cameraview: UIView = {
        let imageview = UIView()
        imageview.backgroundColor = .gray
        self.view.addSubview(imageview)
        return imageview
    }()
    
    var emptyView: UIView {
        return UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
    }

}

extension CallSettingsInCall: OTSessionDelegate {
    func sessionDidConnect(_ session: OTSession) {
       print("settings: The client connected")
        
        let settings = OTPublisherSettings()
        settings.name = UIDevice.current.name
        openTok.publisher = OTPublisher(delegate: self, settings: settings)

        guard let publisher = openTok.publisher else { return }
        
        var error: OTError?
        session.publish(publisher, error: &error)
        guard error == nil else {
            print(error!)
            return
        }

        guard let publisherView = publisher.view else {
            return
        }
        
        let screenBounds = UIScreen.main.bounds
        publisherView.frame = screenBounds
        cameraview.addSubview(publisherView)
    }

    func sessionDidDisconnect(_ session: OTSession) {
       print("settings: The client disconnected")
        self.navigationController?.popViewController(animated: true)
    }

    func session(_ session: OTSession, didFailWithError error: OTError) {
        print("settings: \(error.code).")
        self.navigationController?.popViewController(animated: true)
        
    }

    func session(_ session: OTSession, streamCreated stream: OTStream) {
        print("settings: A stream was created")
        openTok.subscribe(stream: stream, session: session)
        openTok.subscriber?.delegate = self
    }

    func session(_ session: OTSession, streamDestroyed stream: OTStream) {
       print("settings: A stream was destroyed")
    }
}

// MARK: - OTPublisherDelegate callbacks
extension CallSettingsInCall: OTPublisherDelegate {
   func publisher(_ publisher: OTPublisherKit, didFailWithError error: OTError) {
        print("settings: The publisher failed: \(error)")
        self.navigationController?.popViewController(animated: true)
   }
}

// MARK: - OTSubscriberDelegate callbacks
extension CallSettingsInCall: OTSubscriberDelegate {
   public func subscriberDidConnect(toStream subscriber: OTSubscriberKit) {
       print("settings: The subscriber did connect to the stream.")
   }

   public func subscriber(_ subscriber: OTSubscriberKit, didFailWithError error: OTError) {
       print("settings: The subscriber failed to connect to the stream.")
   }
}
