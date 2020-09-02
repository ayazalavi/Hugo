//
//  ConsultationPopover.swift
//  Hugo Med
//
//  Created by Miranz  Technologies on 8/27/20.
//  Copyright © 2020 Ayaz Alavi. All rights reserved.
//

import Foundation
import UIKit

class AlertPopover:  HugoMedUIViewController {
    
    // MARK: DATA
    var popoverDimension: CGSize {
        return CGSize(width: 318, height: 225)
    }
    
    let titleText: String
    let descriptionText: String
    let iconImage: UIImage?
    
    
    let doctor: DoctorCard
    
    // MARK: LIFE CYCLE METHODS, INITIALIZERS, ACTIONS AND EVENTS
    init(title: String, description: String, icon: UIImage? = nil, doctor: DoctorCard) {
        self.titleText = title
        self.descriptionText = description
        self.iconImage = icon
        self.doctor = doctor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(white: 0, alpha: 0)
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissPopover(_:)))
        self.view.addGestureRecognizer(tap)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.2, animations: {
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        }, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        NSLayoutConstraint.activate([
            self.content.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.content.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.content.widthAnchor.constraint(equalToConstant: 318),
            self.content.heightAnchor.constraint(equalToConstant: 225),
            self.icon.topAnchor.constraint(equalTo: self.content.topAnchor, constant: -30),
            self.icon.centerXAnchor.constraint(equalTo: self.content.centerXAnchor),
            self.icon.widthAnchor.constraint(equalToConstant: 60),
            self.icon.heightAnchor.constraint(equalToConstant: 60),
            self.button.widthAnchor.constraint(equalTo: self.content.widthAnchor, constant: -54),
//            self.button.heightAnchor.constraint(equalToConstant: 44),
//            self.titleLabel.centerXAnchor.constraint(equalTo: self.content.centerXAnchor),
            self.titleLabel.widthAnchor.constraint(equalTo: self.content.widthAnchor, constant: -32),
//            self.subtitleText.centerXAnchor.constraint(equalTo: self.content.centerXAnchor),
            self.subtitleText.widthAnchor.constraint(equalTo: self.content.widthAnchor, constant: -32),
            self.emptyView1.heightAnchor.constraint(equalToConstant: 37),
            self.emptyView2.heightAnchor.constraint(equalToConstant: 16),
            self.emptyView3.heightAnchor.constraint(equalToConstant: 16),
        ])
    }
    
    @objc func dismissPopover(_ sender: UIGestureRecognizer) {
        print(sender.location(in: self.content), sender.location(in: self.icon))
        if let sender  = sender as? UITapGestureRecognizer, sender.state == .ended, (sender.location(in: content).y < 0 && sender.location(in: icon).x < 0) || ((sender.location(in: content).y < 0 && sender.location(in: icon).x > icon.frame.size.width) || ((sender.location(in: content).y < 0 && sender.location(in: icon).y < 0)) || sender.location(in: content).x < 0 || sender.location(in: content).x > content.frame.size.width || sender.location(in: content).y > content.frame.size.height) {
           self.view.backgroundColor = .clear
           self.dismiss(animated: true) {
               
           }
       }
    }
    
    @objc func agree(_ sender: UIView) {
        self.view.backgroundColor = .clear
        self.dismiss(animated: true) {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: ConsulationStatus.requested.rawValue), object: nil, userInfo: ["doctor": self.doctor])
        }
    }
    
    // MARK: VIEWs
    lazy private var content: UIView = {
        let stackview_ = UIStackView(arrangedSubviews: [self.emptyView1, self.titleLabel, self.emptyView3, self.subtitleText, self.button, self.emptyView2])
        stackview_.frame = CGRect(x: 16, y: 0, width: 286, height: 225)
        stackview_.axis = .vertical
        stackview_.distribution = .fillProportionally
        stackview_.alignment = .center
        let view_ = UIView(frame: .zero)
        view_.layer.masksToBounds = true
        view_.layer.cornerRadius = 6
        view_.backgroundColor = .white
        view_.translatesAutoresizingMaskIntoConstraints = false
        view_.addSubview(stackview_)
        self.view.addSubview(view_)
        self.view.addSubview(self.icon)
        return view_
    }()
    
    private var emptyView: UIView  {
        let textView = UIView(frame: .zero)
        textView.backgroundColor = .clear
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }
    
    lazy var emptyView1 = {
        return emptyView
    }()
    lazy var emptyView2 = {
        return emptyView
    }()
    lazy var emptyView3 = {
        return emptyView
    }()
    
    lazy private var icon: UIImageView = {
        let imageView = UIImageView.photo()
        imageView.image = self.iconImage
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 30
        return imageView
    }()
    
    lazy private var titleLabel: UILabel  = {
        let content = String.scanFor(key: .alert_title)
        let textView = UILabel.label()
        textView.backgroundColor = .clear
        textView.font = content.getFont()
        textView.textColor = content.getTextColor()
        textView.textAlignment = .center
        textView.text = self.titleText
        return textView
    }()
    
    lazy private var subtitleText: UITextView  = {
        let textView = UITextView.textView()
        let content = String.scanFor(key: .alert_description)
        textView.backgroundColor = .clear
        textView.font = content.getFont()
        textView.textColor = content.getTextColor()
        textView.textAlignment = .center
        textView.text = self.descriptionText
        return textView
    }()

    lazy var button: UIButton = {
        let buttonContent = String.scanFor(key: ContentKeys.welcome_button)
        let button = UIButton.mainButton(text: NSMutableAttributedString(string: "ESTOY DE ACUERDO", attributes: [NSAttributedString.Key.font: buttonContent.getFont(), NSAttributedString.Key.foregroundColor: buttonContent.getTextColor()]), radius: CGFloat(buttonContent.getRadius()), backGroundColor: buttonContent.getBackgroundColor(), spacing: 1.73)
        button.frame = CGRect(x: 27, y: 0, width: 264, height: 44)
        button.addTarget(self, action: #selector(agree(_:)), for: .touchUpInside)
        return button
    }()
}
