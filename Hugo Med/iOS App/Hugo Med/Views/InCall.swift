//
//  ConsultationPopover.swift
//  Hugo Med
//
//  Created by Miranz  Technologies on 8/27/20.
//  Copyright © 2020 Ayaz Alavi. All rights reserved.
//

import Foundation
import UIKit

class InCall:  HugoMedUIViewController {
    
    let doctor: DoctorCard
    
    let contentStyle: Content = String.scanFor(key: .popover_title)
    let contentStyle2: Content = String.scanFor(key: .popover_subtitle)
    let contentStyle3: Content = String.scanFor(key: .welcome_button)
        
    // MARK: LIFE CYCLE METHODS, INITIALIZERS, ACTIONS AND EVENTS
    init(doctor: DoctorCard) {
        self.doctor = doctor
        super.init(nibName: nil, bundle: nil)
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
    navigationItem.leftBarButtonItem = UIBarButtonItem(customView: UIButton.customButton(image: #imageLiteral(resourceName: "back-arrow").withRenderingMode(.alwaysTemplate), tintColor: navBarTintColor, selector: #selector(popViewController), target: self))
       navigationItem.rightBarButtonItem = nil
       super.viewWillAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.cameraview.frame = view.bounds
        NSLayoutConstraint.activate([
            controls.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            controls.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -81)
        ])
    }
    
    // MARK: ACTIONS
    
    @objc func popViewController() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func toggleAudio(_ sender: UIView) {
        if let audio = sender as? UIButton {
            audio.isSelected = !audio.isSelected
        }
    }
    
    @objc func toggleVideo(_ sender: UIView) {
        if let video = sender as? UIButton {
            video.isSelected = !video.isSelected
            self.cameraview.backgroundColor = video.isSelected ? .black : .gray
        }
    }
    
    @objc func endCall() {
        let payment = Payment(cards: [PaymentCard(type: "VISA", number: "1234")], amount: 15, comission: 5)
        let details = ReceiptDetails(id: "HPY-SOL-073", date: "12-03-20. 08:00 am", service: "hugoMed", card: payment.cards[0], amount: payment.amount, comission: payment.comission)
        let invoice = Invoice(receipt: Receipt(with: payment, details: details))
        self.navigationController?.pushViewController(invoice, animated: true)
    }
    
    // MARK: VIEWs
    lazy private var controls: UIStackView = {
        let button1 = UIButton.customButton(image: #imageLiteral(resourceName: "audio-on"), tintColor: .clear, selector: #selector(toggleAudio), target: self)
        button1.setImage(#imageLiteral(resourceName: "audio-off"), for: .selected)
        button1.widthAnchor.constraint(equalToConstant: 60).isActive = true
        button1.heightAnchor.constraint(equalToConstant: 60).isActive = true
        let button3 = UIButton.customButton(image: #imageLiteral(resourceName: "hangout"), tintColor: .clear, selector: #selector(endCall), target: self)
        button3.setImage(#imageLiteral(resourceName: "hangout"), for: .selected)
        button3.widthAnchor.constraint(equalToConstant: 60).isActive = true
        button3.heightAnchor.constraint(equalToConstant: 60).isActive = true
        let button2 = UIButton.customButton(image: #imageLiteral(resourceName: "video-on"), tintColor: .clear, selector: #selector(toggleVideo), target: self)
        button2.setImage(#imageLiteral(resourceName: "video-off"), for: .selected)
        button2.widthAnchor.constraint(equalToConstant: 60).isActive = true
        button2.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        let view_ = UIStackView(arrangedSubviews: [button1, button3, button2])
        view_.axis = .horizontal
        view_.alignment = .center
        view_.distribution = .equalSpacing
        view_.spacing = 26
        view_.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(view_)
        return view_
    }()
    
    lazy private var cameraview: UIImageView = {
        let imageview = UIImageView.photo()
        imageview.backgroundColor = .orange
        self.view.addSubview(imageview)
        return imageview
    }()
    
    var emptyView: UIView {
        return UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
    }

}
