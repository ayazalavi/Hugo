//
//  ConsultationPopover.swift
//  Hugo Med
//
//  Created by Miranz  Technologies on 8/27/20.
//  Copyright © 2020 Ayaz Alavi. All rights reserved.
//

import Foundation
import UIKit

class NotifyPopover:  HugoMedUIViewController {
    
    // MARK: DATA
    let consulation: EnterConsultation
    
    var popoverHeight: CGFloat {
        return 63
    }
    
    var isDoctorAvailable: Bool {
        return self.consulation.doctor.isAvailable
    }
    
    var contentStyle: Content {
        return String.scanFor(key: self.isDoctorAvailable ? .short_popover_available : .short_popover_unavailable)
    }
    
    var titleTextString: String {
        return "\(self.isDoctorAvailable ? "Consulta en progreso" : "Consulta solicitada" )"
    }
    
    // MARK: LIFE CYCLE METHODS, INITIALIZERS, ACTIONS AND EVENTS
    init(doctor: DoctorCard) {
        self.consulation = EnterConsultation(doctor: doctor)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(recheckStatus))
        self.view.addGestureRecognizer(tap)
        print(consulation)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.view.backgroundColor = UIColor(white: 0, alpha: 0)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print(view.bounds)
        self.content.frame = CGRect(x: 0, y: view.bounds.size.height - self.popoverHeight, width: view.bounds.size.width, height: self.popoverHeight+8)
        self.doctorPhoto.frame = CGRect(x: 26, y: view.bounds.size.height - self.popoverHeight-8, width: 54, height: 54)
        self.titleText.frame = CGRect(x: 94, y: 15, width: 150, height: 10)
        self.subtitleText.frame = CGRect(x: 94, y: 25, width: 250, height: 18)
        self.bottomButton.frame = CGRect(x: view.bounds.size.width - 72 - 18, y: 11, width: 72, height: 28)
        self.unavailableText.frame = CGRect(x: view.bounds.size.width - 112 - 16, y: 11, width: 112, height: 35)
        self.unavailableText.sizeToFit()
    }
    
    @objc func startConsulation() {
        self.dismiss(animated: true) {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: ConsulationStatus.in_progress.rawValue), object: nil, userInfo: ["doctor": self.consulation.doctor])
        }
        
    }
    
    @objc func recheckStatus(_ sender: UIGestureRecognizer) {
        print("tapped")
    }
    
    // MARK: VIEWs
    lazy private var content: UIView = {
        let view_ = UIView(frame: .zero)
        view_.layer.masksToBounds = true
        view_.layer.cornerRadius = 9
        view_.backgroundColor = self.contentStyle.getBackgroundColor()
        view_.layer.shadowColor = UIColor.hexStringToUIColor(hex: "#80788C").cgColor
        view_.layer.shadowOffset = CGSize(width: 0, height: -2)
        view_.layer.shadowOpacity = 0.11
        self.view.addSubview(view_)
        self.view.addSubview(self.doctorPhoto)
        view_.addSubview(self.titleText)
        view_.addSubview(self.subtitleText)
        view_.addSubview(self.isDoctorAvailable ? self.bottomButton : self.unavailableText)
        return view_
    }()
    
    lazy private var doctorPhoto: UIImageView = {
        let imageView = UIImageView.photo(name: consulation.doctor.photo)
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 27
        imageView.layer.shadowColor = UIColor.hexStringToUIColor(hex: "#171121").withAlphaComponent(0.29).cgColor
        imageView.layer.shadowOffset = CGSize(width: 0, height: 2)
        return imageView
    }()
    
    lazy private var titleText: UILabel  = {
        let textView = UILabel.label()
        textView.backgroundColor = .clear
        textView.font = self.contentStyle.getFont()
        textView.textColor = self.contentStyle.getTextColor()
        textView.textAlignment = .left
        textView.text = self.titleTextString
        return textView
    }()
    
    lazy private var subtitleText: UILabel  = {
        let textView = UILabel.label()
        textView.backgroundColor = .clear
        textView.font = String.scanFor(key: .short_popover_subtitle).getFont()
        textView.textColor = self.contentStyle.getTextColor()
        textView.textAlignment = .left
        textView.text = self.consulation.doctor.name
        return textView
    }()

    public var bottomButton: UIButton = {
        let content = String.scanFor(key: .doctors_collection_button_connect)
        let button = UIButton.customButton(text: NSAttributedString(string: "Entrar", attributes: [NSAttributedString.Key.font: content.getFont(), NSAttributedString.Key.foregroundColor: UIColor.white]), icon: #imageLiteral(resourceName: "white"), selector: #selector(startConsulation), target: self)
        button.contentHorizontalAlignment = .left
        button.contentVerticalAlignment = .center
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 43, bottom: 0, right: 0)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -28, bottom: 0, right: 0)
        return button
    }()
    
    lazy private var unavailableText: UITextView  = {
        let textView = UITextView.textView()
        let contentStyle = String.scanFor(key: .short_popover_unavailable_text)
        textView.backgroundColor = .clear
        textView.font = contentStyle.getFont()
        textView.textColor = contentStyle.getTextColor()
        textView.textAlignment = .right
        textView.text = "Te avisaremos cuando \ntodo este listo."
        return textView
    }()
}
