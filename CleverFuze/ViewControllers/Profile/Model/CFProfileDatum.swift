//
//  CFProfileDatum.swift
//  CleverFuze
//
//  Created by venkat subramaian on 13/09/22.


import Foundation
// MARK: - CFProfileDatum
struct CFProfileViewDatum: Codable {
    let id: Int?
    let name, email: String?
    let emailVerifiedAt: String?
    let role: Int?
    let profilePicture, createdAt, updatedAt: String?
    let deletedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, email
        case emailVerifiedAt = "email_verified_at"
        case role
        case profilePicture = "profile_picture"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
    }
    
    init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        self.id = try? container?.decodeIfPresent(Int.self, forKey: .id)
        self.name = try? container?.decodeIfPresent(String.self, forKey: .name)
        self.email = try? container?.decodeIfPresent(String.self, forKey: .email)
        self.emailVerifiedAt = try? container?.decodeIfPresent(String.self, forKey: .emailVerifiedAt)
        self.role = try? container?.decodeIfPresent(Int.self, forKey: .role)
        self.profilePicture = try? container?.decodeIfPresent(String.self, forKey: .profilePicture)
        self.createdAt = try? container?.decodeIfPresent(String.self, forKey: .createdAt)
        self.updatedAt = try? container?.decodeIfPresent(String.self, forKey: .updatedAt)
        self.deletedAt = try? container?.decodeIfPresent(String.self, forKey: .deletedAt)
        
    }
}

extension CFProfileViewDatum{
    
    var profile: String{
        return "https://staging.reloprosoftware.com" + (self.profilePicture ?? "")
    }
    
}



