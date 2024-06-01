//
//  CFDashBoardController.swift
//  CleverFuze
//
//  Created by Anil Kumar on 25/08/22.
//

import UIKit

class CFDashBoardController: NSObject {

    weak var delegate: CFDashboardDelegate?
    var data: CFDashBoardDatum!
    
    func callAPI(){
        
        CFCommunicationController.networkRequest(endPoint: .dashboard) { [weak self] (data, error, statusCode) in
            if let error = error{
                self?.delegate?.apiFailure(error)
            }else{
                guard let data = data, let reponse = try? JSONDecoder().decode(CFDashBoardResponse.self, from: data) else{
                    self?.delegate?.apiFailure(CFErrorMessage.defaultError)
                    return
                }
                self?.data = reponse.data
                self?.delegate?.apiSucess()
            }
        }
        
    }
    
}

extension CFDashBoardController{
    
    func dashBoardData(_ type: CFDashBoardList) -> Int?{
        
        switch type {
        case .totalRecords:
            return self.data?.totalRecords
        case .activeRecords:
            return self.data?.activeRecords
        case .priorWeek:
            return self.data?.dataWeek
        case .priorMonth:
            return self.data?.dataMonth
        case .priorYear:
            return self.data?.dataYear
        }
        
    }
    
}
