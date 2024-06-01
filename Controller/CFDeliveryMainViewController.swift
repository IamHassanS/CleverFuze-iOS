//
//  CFDeliveryMainViewController.swift
//  CleverFuze
//
//  Created by Anilkumar on 30/08/22.
//

import UIKit

class CFDeliveryMainViewController: CFRecordController {


    override init() {
        super.init()
        self.endPoint = .viewDelivery
    }
    override func loadData() {
        self.recordData = [0: [.buttonFooter(.single(.addCustomer)), .deliveryList]]
    }



override func callAPI() {

    CFCommunicationController.networkRequest(endPoint: self.endPoint) { [weak self] (data, error, statusCode) in
        if let error = error{
            self?.delegate?.apiFailure?(error)
        }else{
            guard let data = data, let repose = try? JSONDecoder().decode(CFDeliveryResponse.self, from: data) else{
                self?.delegate?.apiFailure?(CFErrorMessage.defaultError)
                return
            }
            self?.loadData()
            self?.chunckData = (repose.data ?? []).chunked(by: 10)
            self?.delegate?.apiSucess?()
}
}
}
}
