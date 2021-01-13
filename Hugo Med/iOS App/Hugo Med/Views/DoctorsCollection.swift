//
//  DoctorsCollection.swift
//  Hugo Med
//
//  Created by Miranz  Technologies on 8/27/20.
//  Copyright © 2020 Ayaz Alavi. All rights reserved.
//

import Foundation
import UIKit
import IGListKit
import Alamofire

// MARK: Life Cycles Events

class DoctorsCollection: HugoMedUIViewController, ListAdapterDataSource, ListAdapterMoveDelegate {
    
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    var items: [Any] = []  //\n
    
    let doctorsCollection = DoctorCollection(id: 1, doctors: [])
    
    let header = NSMutableAttributedString()
    
    lazy var listTitle = CollectionHeading(title: header)
    
    var gotoTerms: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBarColor = .clear
        navBarTintColor = String.scanFor(key: .nav_bar).getTextColor()
        navBarTitle = nil
        navBarTitleImage = nil
        self.setBackground()
        
        header.append(NSAttributedString(string: "Queremos ayudarte\n", attributes:
            [NSAttributedString.Key.font: String.scanFor(key: .doctors_collection_title).getFont(), NSAttributedString.Key.foregroundColor: String.scanFor(key: .doctors_collection_title).getTextColor()])
        )
        header.append(NSAttributedString(string: "¿Con quién deseas consultarte?", attributes:
            [NSAttributedString.Key.font: String.scanFor(key: .doctors_collection_subtitle).getFont(), NSAttributedString.Key.foregroundColor: String.scanFor(key: .doctors_collection_subtitle).getTextColor()])
        )
        
        self.items.append(listTitle)
        self.items.append(doctorsCollection)
        
        collectionView.backgroundColor = .clear
        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        adapter.dataSource = self
        if #available(iOS 9.0, *) {
            adapter.moveDelegate = self
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(showNotifyPopover(_:)), name: NSNotification.Name(rawValue: ConsulationStatus.requested.rawValue), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(startCall(_:)), name: NSNotification.Name(rawValue: ConsulationStatus.in_progress.rawValue), object: nil)
        
        guard let _ = AppData.shared.microuniverse_company_id else {
            print("no company found")
            return
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //navigationItem.leftBarButtonItem = UIBarButtonItem(customView: UIButton.customButton(image: #imageLiteral(resourceName: "back-arrow").withRenderingMode(.alwaysTemplate), tintColor: navBarTintColor, selector: #selector(self.navigationController?.popViewController(animated:)), target: self))
        super.viewWillAppear(animated)
        navigationItem.setRightButton(UIButton.customButton(image: #imageLiteral(resourceName: "faq").withRenderingMode(.alwaysTemplate), tintColor: navBarTintColor, selector: #selector(gotoFAQ), target: self))
        print("doctors view: ", self.backGroundImage.frame)
        print("doctors opentok: \(String(describing: OpenTok.current?.session?.streams.count))")
        APIRequests.shared.delegate = self
        APIRequests.shared.fetch(url: MED_API_URL.GET_DOCTORS_BY_MICROUNIVERSE(5)).every(seconds: 20)
        
        if let _ = OpenTok.current?.session, let doctor = AppData.shared.current_doctor {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: ConsulationStatus.requested.rawValue), object: nil, userInfo: ["doctor": doctor])
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        APIRequests.shared.stop()
        print("doctors view: stop")
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = CGRect(x: 16, y: 0, width: view.bounds.size.width-32, height: view.bounds.height)
    }
    
    
    // MARK: NOTIFICATION METHODS
    
    @objc func showNotifyPopover (_ notification: NSNotification) {
        if let doctor = notification.userInfo?["doctor"] as? DoctorCard {
            let controller = NotifyPopover(doctor: doctor)
            controller.modalPresentationStyle = .overCurrentContext
            self.present(controller, animated: true)
        }
    }
    
    @objc func startCall (_ notification: NSNotification) {
        if let restart = notification.userInfo?["restart"] as? Bool, let doctor = notification.userInfo?["doctor"] as? DoctorCard, restart {
            if let controller = CallSettingsInCall(doctor: doctor)  {
                print("restarting the call")
                self.navigationController?.pushViewController(controller, animated: true)
                return
            }
        }
        if let doctor = notification.userInfo?["doctor"] as? DoctorCard {
            if let patient = AppData.shared.current_patient,
               let service_id = AppData.shared.current_service?.id,
               let company_id = AppData.shared.microuniverse_company_id {
                APIRequests.shared.make_new_appointment(New_Appointment(place_id: 0, type: "D", doctor_id: doctor.id, patient_email: patient.email, appointment_kind: "C", service_id: service_id, motive: "Dolor de Estómago", status_list:  "K", company_id: 5, is_ondemand: true)) { response in
                    let decoder = JSONDecoder()
                    
                    guard let appointment = try? decoder.decode(Appointment_Response.self, from: response) else {
                        throw AppErrors.AppointmentNotMade
                    }
                    _ = APIRequests.shared.fetch(url: MED_API_URL.GET_COMM_KEYS_APPOINTMENT(appointment.code)) { response in
                        guard let communication = try? decoder.decode(Communication.self, from: response) else {
                            throw AppErrors.AppointmentNotExist
                        }
                        AppData.shared.comm_keys = communication
                        print("comm_keys: \(String(describing: AppData.shared.comm_keys))")
                        AppData.shared.appointment_response = appointment
                        print("appointment_communication: ", appointment)
                        if let controller = CallSettingsInCall(doctor: doctor) {
                            self.navigationController?.pushViewController(controller, animated: true)
                        }
                    }
                    
                    _ = APIRequests.shared.fetch(url: MED_API_URL.GET_PATIENT_APPOINTMENT(patient.id)) { response in
                        guard let appointments = try? decoder.decode([Appointment].self, from: response), appointments.count > 0 else {
                            throw AppErrors.AppointmentNotExist
                        }
                        AppData.shared.current_appointment = appointments.filter { $0.code == appointment.code }.first
                        print("current_appointment: \(String(describing: AppData.shared.current_appointment))")
                    }
                    
                }
            }            
        }
    }
    
}

// MARK: Network requests
extension DoctorsCollection: NetworkStatus {
    func success(response: Data) throws {
//        guard let response = response else {
//            throw AppErrors.NoResponse
//        }
        let decoder = JSONDecoder()
        switch APIRequests.shared.current_api_url {
            case .GET_DOCTORS_BY_MICROUNIVERSE(_):
                guard let doctors = try? decoder.decode([Doctor].self, from: response), doctors.count > 0 else {
                    throw AppErrors.DoctorsError
                }
                AppData.shared.setDoctors(doctors)
                doctorsCollection.doctors = AppData.shared.getDoctorsCards()
                adapter.reloadData(completion: nil)
               // self.resetDoctorsAvailability()
            default:
                print("error")
        }
    }
    
    func resetDoctorsAvailability () {
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) {[self] timer in
            if let docs = AppData.shared.doctors {
                AppData.shared.setDoctors(docs.map { doc -> Doctor in
                    var doctor = doc
                    doctor.waiting_time.waiting = 0
                    return doctor
                })
                self.doctorsCollection.doctors = AppData.shared.getDoctorsCards()
                self.adapter.reloadData(completion: nil)
                
            }
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

// MARK: List Adaptar Datasource functions

extension DoctorsCollection {
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return self.items as! [ListDiffable]
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        switch object {
        case is DoctorCollection: return DoctorSectionController(doctorCollection: self.doctorsCollection)
            default:
                return PageHeaderSectionController(bottomMargin: 55)
        }
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    
    func listAdapter(_ listAdapter: ListAdapter, move object: Any, from previousObjects: [Any], to objects: [Any]) {
        
    }
    
}

// MARK: Action Handlers

extension DoctorsCollection {
    
    @objc func gotoFAQ() {
        self.navigationController?.pushViewController(FAQList(), animated: true)
        print("go to faq")
    }
}





