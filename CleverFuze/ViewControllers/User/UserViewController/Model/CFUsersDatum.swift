//
//  CFUsersDatum.swift
//  CleverFuze
//
//  Created by Anil Kumar on 30/08/22.
//

import Foundation

// MARK: - Datum
struct CFUsersDatum: Codable {
    let id: Int?
    let name, email: String?
    let role: CFUsersRole?
    let updateURL, deleteURL: String?

    enum CodingKeys: String, CodingKey {
        case id, name, email, role
        case updateURL = "update_url"
        case deleteURL = "delete_url"
    }
    
    init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        self.id = try? container?.decodeIfPresent(Int.self, forKey: .id)
        self.name = try? container?.decodeIfPresent(String.self, forKey: .name)
        self.email = try? container?.decodeIfPresent(String.self, forKey: .email)
        self.role = try? container?.decodeIfPresent(CFUsersRole.self, forKey: .role)
        self.updateURL = try? container?.decodeIfPresent(String.self, forKey: .updateURL)
        self.deleteURL = try? container?.decodeIfPresent(String.self, forKey: .deleteURL)
    }
    
}

extension CFUsersDatum: CFRecordDataSource{
    
    
    func getExistData(_ fields: [CFCustomFieldType]) -> [CFCustomFieldType : Any] {
        
        var valueDatas = [CFCustomFieldType : Any]()
        for field in fields {
            switch field{
            case .name:
                valueDatas[field] = self.name
            case .emailAddress:
                valueDatas[field] = self.email
            case .userRole:
                valueDatas[field] = CFDropDownController.dropDownValues?.userRole?.filter{$0.name == self.role?.rawValue}.first
            default:
                break
            }
        }
        return valueDatas
        
    }
    
}
    
