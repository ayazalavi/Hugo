//
//  Network.swift
//  Hugo Med
//
//  Created by Miranz  Technologies on 10/18/20.
//  Copyright © 2020 Ayaz Alavi. All rights reserved.
//

import Foundation
import Alamofire

protocol NetworkStatus: NSObject {
    func success(response: Data) throws
    func error(error: AFError?)
    func started()
    func progress(progress: Double)
    func completed()
}

class APIRequests {
    
    static var shared = APIRequests()
    
    weak var delegate: NetworkStatus?
    
    var current_api_url: MED_API_URL?
    
    var seconds: Int = 0
    
    var timer: Timer?
    
    private let headers: HTTPHeaders = [
        "Authorization": "Api-Key \(MED_API_URLS.API_KEY)",
        "Accept": "application/json",
        "Content-Type": "application/json"
    ]
    
    func redirector(_ method: HTTPMethod, _ body: Data? = nil) -> Redirector {
        return Redirector(behavior: .modify({ (session, request, response) -> URLRequest? in
            var request_ = request
            request_.setValue(self.headers["Authorization"], forHTTPHeaderField: "Authorization")
            request_.setValue(self.headers["Content-Type"], forHTTPHeaderField: "Content-Type")
            if let body = body {
                request_.httpBody = body
            }
            request_.method = method
        //    print(self.current_api_url?.url(), request_.method, request_.httpBody, request_.allHTTPHeaderFields)
            return request_
        }))
    }
    
    private init() {
        
    }
    
    func make_new_appointment(_ new_appointment: New_Appointment, _ callback: (@escaping (_ response: Data) throws -> Void)) {
        let url = MED_API_URL.REGISTER_ON_DEMAND_APPOINTMENT
        current_api_url = url
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try? encoder.encode(new_appointment)        
        AF.request(url.url(), method: .post, parameters: new_appointment, headers: headers)
            .redirect(using: redirector(.post, data)).responseJSON(queue: DispatchQueue.global(qos: .background)) {[self] response in
            // print(response)
            DispatchQueue.main.async {
                if response.error != nil {
                    delegate?.error(error: response.error)
                }
                else {
                    guard let responseData = response.data else {
                        print("Unable to get response")
                        return
                    }
                    do {
                        try delegate?.success(response: responseData)
                        try callback(responseData)
                    } catch (AppErrors.PatientNotSet) {
                        print("Unable to set user as a patient")
                    } catch (AppErrors.AppointmentNotMade) {
                        print("Unable to set appointment")
                    }catch {
                        print("Unexpected error: \(String(describing: response.error)).")
                    }
                }
                delegate?.completed()
            }            
        }
    }
    
    func every(seconds: Int) {
        self.seconds = seconds
        self.timer?.invalidate()
        self.timer = nil
        print("timer stopped")
    }
    
    func stop() {
        self.seconds = 0
        self.timer?.invalidate()
        self.timer = nil
        print("timer stopped")
    }
    
    func fetch(url: MED_API_URL, _ callback: (@escaping (_ response: Data) throws -> Void) = { response in }) -> APIRequests {
        current_api_url = url
        if timer == nil {
            seconds = 0
        }
        AF.request(url.url(), headers: headers)
            .redirect(using: redirector(.get)).responseJSON(queue: DispatchQueue.global(qos: .background)) {[self] response in
            // print(response)
            DispatchQueue.main.async {
                if response.error != nil {
                    delegate?.error(error: response.error)
                }
                else {
                    guard let responseData = response.data else {
                        print("Unable to get response")
                        return
                    }
                    do {
                        try delegate?.success(response: responseData)
                        try callback(responseData)
                        if self.seconds > 0 && self.timer == nil {
                            print("timer started")
                            timer = Timer.scheduledTimer(withTimeInterval: Double(self.seconds), repeats: true) { timer in
                                _ = self.fetch(url: url, callback)
                            }
                        }
                    } catch (AppErrors.PatientNotSet) {
                        print("Unable to set user as a patient")
                    } catch (AppErrors.AppointmentNotMade) {
                        print("Unable to set appointment")
                    }catch {
                        print("Unexpected error: \(String(describing: response.error)).")
                    }
                }
                delegate?.completed()
            }
        }
        return self
    }
}
