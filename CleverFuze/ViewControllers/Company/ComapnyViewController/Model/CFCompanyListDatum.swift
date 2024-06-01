//
//  CFCompanyListDatum.swift
//  CleverFuze
//
//  Created by Anil Kumar on 30/08/22.
//

import Foundation

// MARK: - CFCompanyListDatum
struct CFCompanyListDatum: Codable {
    let id: Int?
    let companyName, address, idNo, serviceNo: String?
    let scacNo, city, state: String?
    let address2: String?
    let zip: String?
    let warehouseLocation: Int?
    let updateURL, deleteURL: String?

    enum CodingKeys: String, CodingKey {
        case id
        case companyName = "company_name"
        case address
        case idNo = "id_no"
        case serviceNo = "service_no"
        case scacNo = "scac_no"
        case city, state, address2, zip
        case warehouseLocation = "warehouse_location"
        case updateURL = "update_url"
        case deleteURL = "delete_url"
    }
    
    init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        self.id = try? container?.decodeIfPresent(Int.self, forKey: .id)
        self.companyName = try? container?.decodeIfPresent(String.self, forKey: .companyName)
        self.address = try? container?.decodeIfPresent(String.self, forKey: .address)
        self.idNo = try? container?.decodeIfPresent(String.self, forKey: .idNo)
        self.serviceNo = try? container?.decodeIfPresent(String.self, forKey: .serviceNo)
        self.scacNo = try? container?.decodeIfPresent(String.self, forKey: .scacNo)
        self.city = try? container?.decodeIfPresent(String.self, forKey: .city)
        self.state = try? container?.decodeIfPresent(String.self, forKey: .state)
        self.address2 = try? container?.decodeIfPresent(String.self, forKey: .address2)
        self.zip = try? container?.decodeIfPresent(String.self, forKey: .zip)
        self.warehouseLocation = try? container?.decodeIfPresent(Int.self, forKey: .warehouseLocation)
        self.updateURL = try? container?.decodeIfPresent(String.self, forKey: .updateURL)
        self.deleteURL = try? container?.decodeIfPresent(String.self, forKey: .deleteURL)
    }
}

extension CFCompanyListDatum: CFRecordDataSource{
    
    var name: String? {
        return self.companyName
    }

    func getExistData(_ fields: [CFCustomFieldType]) -> [CFCustomFieldType : Any] {
        
        var valueDatas = [CFCustomFieldType : Any]()
        for field in fields {
            switch field{
            case .companyName,.companyNamez:
                valueDatas[field] = self.companyName
            case .idNumber,.idNumberz:
                valueDatas[field] = self.idNo
            case .serviceNumber,.serviceNumberz:
                valueDatas[field] = self.serviceNo
            case .scacNumber,.scacNumberz:
                valueDatas[field] = self.scacNo
            case .addressLine1,.addressLine1z:
                valueDatas[field] = self.address
            case .addressLine2:
                valueDatas[field] = self.address2
            case .warehouseLocation:
                valueDatas[field] = CFDropDownController.dropDownValues?.warehouseLocation?.filter{$0.id == self.warehouseLocation}.first
            case .city:
                valueDatas[field] = self.city
            case .state:
                valueDatas[field] = CFDropDownController.dropDownValues?.states?.filter{$0.name?.lowercased() == self.state?.lowercased()}.first
            case .zip:
                valueDatas[field] = self.zip
            default:
                break
            }
        }
        return valueDatas
        
    }
    
}
