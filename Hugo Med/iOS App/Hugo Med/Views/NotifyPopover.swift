//
//  ConsultationPopover.swift
//  Hugo Med
//
//  Created by Miranz  Technologies on 8/27/20.
//  Copyright © 2020 Ayaz Alavi. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class NotifyPopover:  HugoMedUIViewController {
    
    // MARK: DATA
    var consulation: EnterConsultation
    
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
        guard OpenTok.current == nil else { return }
        APIRequests.shared.delegate = self
        APIRequests.shared.fetch(url: MED_API_URL.GET_DOCTOR_BY_ID(self.consulation.doctor.id)).every(seconds: 5)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        APIRequests.shared.stop()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // MARK: VIEWs
        let content: UIView = {
            let view_ = UIView(frame: .zero)
            view_.layer.masksToBounds = true
            view_.layer.cornerRadius = 9
            view_.backgroundColor = self.contentStyle.getBackgroundColor()
            view_.layer.shadowColor = UIColor.hexStringToUIColor(hex: "#80788C").cgColor
            view_.layer.shadowOffset = CGSize(width: 0, height: -2)
            view_.layer.shadowOpacity = 0.11            
            return view_
        }()

        
        let titleText: UILabel  = {
            let textView = UILabel.label()
            textView.backgroundColor = .clear
            textView.font = self.contentStyle.getFont()
            textView.textColor = self.contentStyle.getTextColor()
            textView.textAlignment = .left
            textView.text = self.titleTextString
            return textView
        }()
        
        let subtitleText: UILabel  = {
            let textView = UILabel.label()
            textView.backgroundColor = .clear
            textView.font = String.scanFor(key: .short_popover_subtitle).getFont()
            textView.textColor = self.contentStyle.getTextColor()
            textView.textAlignment = .left
            textView.text = self.consulation.doctor.name
            return textView
        }()

        let bottomButton: UIButton = {
            let content = String.scanFor(key: .doctors_collection_button_connect)
            let button = UIButton.customButton(text: NSAttributedString(string: "Entrar", attributes: [NSAttributedString.Key.font: content.getFont(), NSAttributedString.Key.foregroundColor: UIColor.white]), icon: #imageLiteral(resourceName: "white"), selector: #selector(startConsulation), target: self)
            button.contentHorizontalAlignment = .left
            button.contentVerticalAlignment = .center
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 43, bottom: 0, right: 0)
            button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -28, bottom: 0, right: 0)
            return button
        }()
        
        let unavailableText: UITextView  = {
            let textView = UITextView.textView()
            let contentStyle = String.scanFor(key: .short_popover_unavailable_text)
            textView.backgroundColor = .clear
            textView.font = contentStyle.getFont()
            textView.textColor = contentStyle.getTextColor()
            textView.textAlignment = .right
            textView.text = "Te avisaremos cuando \ntodo este listo."
            return textView
        }()
        self.view.subviews.forEach{$0.removeFromSuperview()}
        self.view.addSubview(content)
        self.view.addSubview(self.doctorPhoto)
        content.addSubview(titleText)
        content.addSubview(subtitleText)
        content.addSubview(isDoctorAvailable ? bottomButton : unavailableText)
        print("notify view: ", view.bounds, self.view.subviews.count, content.subviews.count)
        content.frame = CGRect(x: 0, y: view.bounds.size.height - self.popoverHeight, width: view.bounds.size.width, height: self.popoverHeight+8)
        self.doctorPhoto.frame = CGRect(x: 26, y: view.bounds.size.height - self.popoverHeight-8, width: 54, height: 54)
        titleText.frame = CGRect(x: 94, y: 15, width: 150, height: 10)
        subtitleText.frame = CGRect(x: 94, y: 25, width: 250, height: 18)
        bottomButton.frame = CGRect(x: view.bounds.size.width - 72 - 18, y: 11, width: 72, height: 28)
        unavailableText.frame = CGRect(x: view.bounds.size.width - 112 - 16, y: 11, width: 112, height: 35)
        unavailableText.sizeToFit()
    }
    
    lazy var doctorPhoto: UIImageView = {
        let imageView = UIImageView.photo()
        AF.request("http://\(self.consulation.doctor.photo)").response (queue: DispatchQueue.global(qos: .background)) {[self] (response) in
            guard let response = response.data else { return }
            DispatchQueue.main.async {
                imageView.image = UIImage(data: response)
            }            
        }
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 27
        imageView.layer.shadowColor = UIColor.hexStringToUIColor(hex: "#171121").withAlphaComponent(0.29).cgColor
        imageView.layer.shadowOffset = CGSize(width: 0, height: 2)
        return imageView
    }()
    
    @objc func startConsulation() {
        self.dismiss(animated: true) {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: ConsulationStatus.in_progress.rawValue), object: nil, userInfo: ["doctor": self.consulation.doctor, "restart": OpenTok.current != nil])
        }
    }
    
    @objc func recheckStatus(_ sender: UIGestureRecognizer) {
        print("tapped")
    }
    
}

extension NotifyPopover: NetworkStatus {
    func success(response: Data) throws {
//        guard let response = response else {
//            throw AppErrors.NoResponse
//        }
        let decoder = JSONDecoder()
        switch APIRequests.shared.current_api_url {
            case .GET_DOCTOR_BY_ID(_):
                guard let doctor = try? decoder.decode(Doctor.self, from: response) else {
                    throw AppErrors.DoctorsError
                }
                print("doctor: ", doctor)
                let doc = AppData.shared.getDoctorCard(doctor: doctor)
                AppData.shared.current_doctor = doc
                self.consulation.doctor = doc
                AppData.shared.checkNotification(doctor: doc, reschedule: true)                
                self.view.setNeedsLayout()
               
            default:
                print("error")
        }
    }
    
    func error(error: AFError?) {
        print("error: \(String(describing: error))")
    }
    
    func started() {
        
    }
    
    func progress(progress: Double) {
        
    }
    
    func completed() {
        
    }
    
    
}
