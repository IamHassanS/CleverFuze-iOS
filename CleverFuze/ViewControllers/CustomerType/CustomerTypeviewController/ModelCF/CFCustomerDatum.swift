//
//  CFCustomerDatum.swift
//  CleverFuze
//
//  Created by AIT-iMac-01 on 05/10/23.
//

import Foundation
// MARK: - Datum
struct CFCustomerTypeDatum: Codable {
    let id: Int?
    let caption: String?
    let isActive: Int?
    let updateURL, disableURL: String?
    let status:CFCustomerTypeStatus?

    enum CodingKeys: String, CodingKey {
        case id, caption
        case isActive = "is_active"
        case updateURL = "update_url"
        case disableURL = "disable_url"
        case status
    }
    
    init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        self.id = try? container?.decodeIfPresent(Int.self, forKey: .id)
        self.caption = try? container?.decodeIfPresent(String.self, forKey: .caption)
        self.isActive = try? container?.decodeIfPresent(Int.self, forKey: .isActive)
        self.updateURL = try? container?.decodeIfPresent(String.self, forKey: .updateURL)
        self.disableURL = try? container?.decodeIfPresent(String.self, forKey: .disableURL)
        self.status = try? container?.decodeIfPresent(CFCustomerTypeStatus.self, forKey: .status)
    }
}

extension CFCustomerTypeDatum: CFRecordDataSource {
    

    var name: String? {
        return self.caption
    }
    func getExistData(_ fields: [CFCustomFieldType]) -> [CFCustomFieldType : Any] {
        var valueDatas = [CFCustomFieldType : Any]()
        for field in fields {
            switch field{
            case .CustomTypename:
                valueDatas[field] = self.caption
            default:
                break
            }
        }
        return valueDatas
    }
}
