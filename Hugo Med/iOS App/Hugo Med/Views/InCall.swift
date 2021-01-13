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

class InCall:  HugoMedUIViewController {
    
    let doctor: DoctorCard
    let openTok: OpenTok
    var invoice: Invoice?
    let contentStyle: Content = String.scanFor(key: .popover_title)
    let contentStyle2: Content = String.scanFor(key: .popover_subtitle)
    let contentStyle3: Content = String.scanFor(key: .welcome_button)
    var gotoInvoice = false
    
    // MARK: LIFE CYCLE METHODS, INITIALIZERS, ACTIONS AND EVENTS
    init(doctor: DoctorCard, openTok: OpenTok) {
        self.doctor = doctor
        self.openTok = openTok
        if let service = AppData.shared.current_service, let appointment = AppData.shared.current_appointment {
            let payment = Payment(cards: [PaymentCard(type: "VISA", number: "1234")], amount: service.fee.floatValue, comission: service.fee.floatValue * 0.1)
            let details = ReceiptDetails(id: appointment.code, date: appointment.start_at_date, service: service.name, card: payment.cards[0], amount: payment.amount, comission: payment.comission)
            invoice = Invoice(receipt: Receipt(with: payment, details: details))        
        }
        super.init(nibName: nil, bundle: nil)
        self.openTok.session?.delegate = self
        self.openTok.publisher?.delegate = self
        self.openTok.subscriber?.delegate = self
        
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
        // Do any additional setup after loading the view.
        addSubscriberView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
    navigationItem.leftBarButtonItem = UIBarButtonItem(customView: UIButton.customButton(image: #imageLiteral(resourceName: "back-arrow").withRenderingMode(.alwaysTemplate), tintColor: navBarTintColor, selector: #selector(popViewController), target: self))
       navigationItem.rightBarButtonItem = nil
       super.viewWillAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let publisherView = openTok.subscriber?.view  {
            publisherView.frame = view.bounds
            publisherView.setNeedsLayout()
        }
        self.cameraview.frame = view.bounds
        NSLayoutConstraint.activate([
            controls.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            controls.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -81)
        ])
    }
    
    func addSubscriberView() {
        guard let subscriberView = openTok.subscriber?.view else {
            return
        }
        subscriberView.frame = UIScreen.main.bounds
        cameraview.insertSubview(subscriberView, at: 0)
    }
    
    // MARK: ACTIONS
    
    @objc func popViewController() {
        var error: OTError?
        gotoInvoice = false
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
    
    @objc func endCall() {
        var error: OTError?
        gotoInvoice = true
        openTok.session?.disconnect(&error)
        if let invoice = invoice {
            self.navigationController?.pushViewController(invoice, animated: true)
        }
        else {
            print("incall: unable to disconnect session")
        }
        
    }
    
    // MARK: VIEWs
    lazy private var controls: UIStackView = {
        let button1 = UIButton.customButton(image: #imageLiteral(resourceName: "audio-on"), tintColor: .clear, selector: #selector(toggleAudio), target: self)
        button1.setImage(#imageLiteral(resourceName: "audio-off"), for: .selected)
        button1.widthAnchor.constraint(equalToConstant: 60).isActive = true
        button1.heightAnchor.constraint(equalToConstant: 60).isActive = true
        button1.isSelected = !(self.openTok.publisher?.publishAudio ?? true)
        let button3 = UIButton.customButton(image: #imageLiteral(resourceName: "hangout"), tintColor: .clear, selector: #selector(endCall), target: self)
        button3.setImage(#imageLiteral(resourceName: "hangout"), for: .selected)
        button3.widthAnchor.constraint(equalToConstant: 60).isActive = true
        button3.heightAnchor.constraint(equalToConstant: 60).isActive = true
        let button2 = UIButton.customButton(image: #imageLiteral(resourceName: "video-on"), tintColor: .clear, selector: #selector(toggleVideo), target: self)
        button2.setImage(#imageLiteral(resourceName: "video-off"), for: .selected)
        button2.widthAnchor.constraint(equalToConstant: 60).isActive = true
        button2.heightAnchor.constraint(equalToConstant: 60).isActive = true
        button2.isSelected = !(self.openTok.publisher?.publishVideo ?? true)
        
        let view_ = UIStackView(arrangedSubviews: [button1, button3, button2])
        view_.axis = .horizontal
        view_.alignment = .center
        view_.distribution = .equalSpacing
        view_.spacing = 26
        view_.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(view_)
        return view_
    }()
    
    lazy private var cameraview: UIView = {
        let imageview = UIView()
        imageview.backgroundColor = .orange
        self.view.addSubview(imageview)
        return imageview
    }()
    
    var emptyView: UIView {
        return UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
    }

}

extension InCall: OTSessionDelegate {
    func sessionDidConnect(_ session: OTSession) {
        print("incall: The client connected")
    }

    func sessionDidDisconnect(_ session: OTSession) {
       print("incall: The client disconnected")
        if !gotoInvoice {
            self.navigationController?.popToRootViewController(animated: true)
        }
        else {
            invoice?.disconnected = true
        }
    }

    func session(_ session: OTSession, didFailWithError error: OTError) {
        print("incall: \(error.code).")
        self.navigationController?.popToRootViewController(animated: true)
        
    }

    func session(_ session: OTSession, streamCreated stream: OTStream) {
       print("incall: A stream was created")
        openTok.subscribe(stream: stream, session: session)
        openTok.subscriber?.delegate = self
    }

    func session(_ session: OTSession, streamDestroyed stream: OTStream) {
       print("incall: A stream was destroyed")
    }
}

// MARK: - OTPublisherDelegate callbacks
extension InCall: OTPublisherDelegate {
   func publisher(_ publisher: OTPublisherKit, didFailWithError error: OTError) {
        print("incall: The publisher failed: \(error)")
        self.navigationController?.popToRootViewController(animated: true)
   }
}

extension InCall: OTSubscriberDelegate {
    public func subscriberDidConnect(toStream subscriber: OTSubscriberKit) {
        print("incall: The subscriber did connect to the stream.")
        addSubscriberView()
    }

    public func subscriber(_ subscriber: OTSubscriberKit, didFailWithError error: OTError) {
        print("incall: The subscriber failed to connect to the stream.")
    }
 }

