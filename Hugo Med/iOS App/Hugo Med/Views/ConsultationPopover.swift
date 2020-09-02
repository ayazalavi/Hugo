//
//  ConsultationPopover.swift
//  Hugo Med
//
//  Created by Miranz  Technologies on 8/27/20.
//  Copyright © 2020 Ayaz Alavi. All rights reserved.
//

import Foundation
import UIKit

class ConsultationPopover:  HugoMedUIViewController {
    
    // MARK: DATA
    let consulation: Consultation
    
    var popoverHeight: CGFloat {
        return self.isDoctorAvailable ? 393 : 434
    }
    
    var start = 0.0
    
    var y: CGFloat {
        get {
            return CGFloat(start)
        }
        set {
            start = Double(newValue)
        }
    }
    
    var onStartConsulation: ((DoctorCard) -> Void)!
    
    var isDoctorAvailable: Bool {
        return self.consulation.doctor.isAvailable
    }
    
    // MARK: LIFE CYCLE METHODS, INITIALIZERS, ACTIONS AND EVENTS
    init(doctor: DoctorCard) {
        self.consulation = Consultation(doctor: doctor, payment: Payment(cards: [PaymentCard(type: "VISA", number: "1234")], amount: 10, comission: 10))
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(white: 0, alpha: 0)
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissPopover(_:)))
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(dismissPopover(_:)))
        swipe.direction = .down
        self.view.addGestureRecognizer(tap)
        self.view.addGestureRecognizer(swipe)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
            self.view.backgroundColor = UIColor(white: 0, alpha: 0.2)
        }, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let contentTextWidth = view.bounds.size.width - 32
        self.content.frame = CGRect(x: 0, y: view.bounds.size.height - self.popoverHeight, width: view.bounds.size.width, height: self.popoverHeight+37)
        self.doctorPhoto.frame = CGRect(x: content.bounds.size.width/2 - 37, y: view.bounds.size.height - self.popoverHeight-37, width: 75, height: 75)
        y = 37+16
        self.name.frame = CGRect(x: 16, y: y, width: contentTextWidth, height: 22)
        y += 22+2
        self.category.frame = CGRect(x: 16, y: y, width: contentTextWidth, height: 14)
        y += 14+20
        let buttonWidth: CGFloat  = self.isDoctorAvailable ? 159.0 : 111.0
        self.availabilityButton.frame = CGRect(x:( content.bounds.size.width/2 - buttonWidth/2), y: y, width: buttonWidth, height: 28)
        y += 28 + (self.isDoctorAvailable ? 33 : 18)
        if !self.isDoctorAvailable {
            self.availableIn.frame = CGRect(x: 16, y: y, width: contentTextWidth, height: 17)
            y += 17+30
        }
        self.centerText.frame = CGRect(x: 16, y: y, width: contentTextWidth, height: 66)
        y += 66+30
        self.cardButton.frame = CGRect(x: 27, y: y, width: 110, height: 20)
        self.amount.frame = CGRect(x: view.bounds.size.width - 27 - 93, y: y, width: 93, height: 20)
        y += 27+14
        self.bottomButton.frame = CGRect(x: 27, y: y, width: 320, height: 44)
        
        self.centerText.contentInset = UIEdgeInsets(top: 5, left: 5, bottom: -5, right: 5)
    }
    
    @objc func gotoStartScreen() {
        self.view.backgroundColor = .clear
        self.dismiss(animated: true) {
            self.onStartConsulation(self.consulation.doctor)
        }
    }
    
    @objc func showCardListPopover() {
        
    }
    
    @objc func dismissPopover(_ sender: UIGestureRecognizer) {
        
        if let sender  = sender as? UITapGestureRecognizer, sender.state == .ended, (sender.location(in: content).y < 0 && sender.location(in: doctorPhoto).x < 0) || ((sender.location(in: content).y < 0 && sender.location(in: doctorPhoto).x > 75) || ((sender.location(in: content).y < 0 && sender.location(in: doctorPhoto).y < 0))) {
            self.view.backgroundColor = .clear
            self.dismiss(animated: true) {
                
            }
        }
        if let sender  = sender as? UISwipeGestureRecognizer, sender.direction == .down {
            self.view.backgroundColor = .clear
            self.dismiss(animated: true) {
                
            }
        }
    }
    
    // MARK: VIEWs
    lazy private var content: UIView = {
        let view_ = UIView(frame: .zero)
        view_.layer.masksToBounds = true
        view_.layer.cornerRadius = 18
        view_.backgroundColor = .white
        view_.layer.shadowColor = UIColor.hexStringToUIColor(hex: "#4B4B4B").cgColor
        view_.layer.shadowOffset = CGSize(width: 0, height: 2)
        view_.layer.shadowOpacity = 0.15
        self.view.addSubview(view_)
        self.view.addSubview(self.doctorPhoto)
        view_.addSubview(self.name)
        view_.addSubview(self.category)
        view_.addSubview(self.availabilityButton)
        if !self.consulation.doctor.isAvailable {
            view_.addSubview(self.availableIn)
        }
        view_.addSubview(self.centerText)
        view_.addSubview(self.cardButton)
        view_.addSubview(self.amount)
        view_.addSubview(self.bottomButton)
        return view_
    }()
    
    lazy private var doctorPhoto: UIImageView = {
        let imageView = UIImageView.photo(name: consulation.doctor.photo)
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 75/2
        imageView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        imageView.layer.shadowOffset = CGSize(width: 0, height: 2)
        return imageView
    }()
    
    lazy private var name: UILabel  = {
        let textView = UILabel.label()
        textView.backgroundColor = .clear
        textView.font = String.scanFor(key: .popover_title).getFont()
        textView.textColor = String.scanFor(key: .popover_title).getTextColor()
        textView.textAlignment = .center
        textView.text = self.consulation.doctor.name
        return textView
    }()
    
    lazy private var category: UILabel = {
        let textView = UILabel.label()
        textView.backgroundColor = .clear
        textView.font = String.scanFor(key: .popover_subtitle).getFont()
        textView.textColor = String.scanFor(key: .popover_subtitle).getTextColor()
        textView.textAlignment = .center
        textView.text = self.consulation.doctor.category
        return textView
    }()
    
    lazy private var availabilityButton: UIButton = {
        let content = String.scanFor(key: .popover_main_button)
        let attributedString = NSAttributedString(string: consulation.doctor.isAvailable ? "Disponible ahora mismo": "En consulta", attributes: [NSAttributedString.Key.font: content.getFont(), NSAttributedString.Key.foregroundColor: content.getTextColor()])
        let button = UIButton.mainButton(text: attributedString, radius: CGFloat(content.getRadius()), backGroundColor: consulation.doctor.isAvailable ? content.getBackgroundColor(): String.scanFor(key: .doctors_collection_button_offline).getBackgroundColor())
        button.layer.shadowColor = UIColor.hexStringToUIColor(hex: "#878787").cgColor
        button.layer.shadowOpacity = 0.14
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        return button
    }()
    
    lazy private var availableIn: UILabel = {
        let label = UILabel.label()
        let content = String.scanFor(key: .popover_subtitle_available_in)
        label.attributedText = content.getAttributedText(alignment: .center, for: "Disponible en \(self.consulation.doctor.availableIn) min apróx.")
        label.backgroundColor = .clear
        return label
    }()
    
    lazy private var centerText: UITextView = {
        let textView = UITextView.textView()
        let content = String.scanFor(key: .popover_description)
        textView.backgroundColor = content.getBackgroundColor()
        textView.font = content.getFont()
        textView.layer.masksToBounds = true
        textView.textColor = content.getTextColor()
        textView.attributedText = content.getAttributedText(alignment: .center)
        return textView
    }()
    
    lazy var cardButton: UIButton = {
        var styles = String.scanFor(key: .popover_card_text)
        let attachment = NSTextAttachment()
        attachment.image = #imageLiteral(resourceName: "down-arrow")
        attachment.bounds = CGRect(origin: CGPoint(x:0, y: 2), size: CGSize(width: 9, height: 6))
        let attributed = NSMutableAttributedString(attributedString: NSAttributedString(string: self.consulation.payment.cards[0].type, attributes: [NSAttributedString.Key.font: styles.getFont(), NSAttributedString.Key.foregroundColor: styles.getTextColor()]))
        attributed.append(NSAttributedString(string: "\u{20}"))
        attributed.append(NSAttributedString(attachment: attachment))
        let leftCardView = UIButton.customButton(text: attributed, icon: #imageLiteral(resourceName: "logo-card"), selector: #selector(showCardListPopover), target: self)
       // leftCardView.layer.borderWidth = 1
        leftCardView.titleLabel?.adjustsFontSizeToFitWidth = true
        leftCardView.imageEdgeInsets = UIEdgeInsets(top: 0, left: -15, bottom: 0, right: 0)
        leftCardView.titleEdgeInsets = UIEdgeInsets(top: -3, left: 0, bottom: 0, right: 0)
        return leftCardView
    }()
    
    lazy var amount: UILabel = {
        let rightAmountLabel = UILabel.label()
        let styles = String.scanFor(key: .popover_amount)
        rightAmountLabel.text = "$\(self.consulation.payment.amount)"
        rightAmountLabel.font = styles.getFont()
        rightAmountLabel.textColor = styles.getTextColor()
        rightAmountLabel.textAlignment = .right
        rightAmountLabel.backgroundColor = .clear
        return rightAmountLabel
    }()
    
    lazy var bottomButton: UIButton = {
        let buttonContent = String.scanFor(key: ContentKeys.welcome_button)
        let button = UIButton.mainButton(text: NSMutableAttributedString(string: self.consulation.doctor.isAvailable ? "INICIAR CONSULTA" : "SOLICITAR CONSULTA", attributes: [NSAttributedString.Key.font: buttonContent.getFont(), NSAttributedString.Key.foregroundColor: buttonContent.getTextColor()]), radius: CGFloat(buttonContent.getRadius()), backGroundColor: buttonContent.getBackgroundColor(), spacing: 1.73)
        button.addTarget(self, action: #selector(gotoStartScreen), for: .touchUpInside)
        return button
    }()
}
