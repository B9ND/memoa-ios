//
//  TokenUrl.swift
//  MEMOA
//
//  Created by dgsw30 on 10/24/24.
//

import Foundation

struct TokenUrl {
    var token = "eyJhbGciOiJIUzI1NiJ9.eyJjYXRlZ29yeSI6ImFjY2VzcyIsImVtYWlsIjoia2ltZXVuY2hhbjI4MTVAZ21haWwuY29tIiwicm9sZSI6IlJPTEVfVVNFUiIsImRldmljZSI6Ik1vemlsbGEvNS4wIChNYWNpbnRvc2g7IEludGVsIE1hYyBPUyBYIDEwXzE1XzcpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS8xMjguMC4wLjAgU2FmYXJpLzUzNy4zNl8yMjEuMTY4LjIyLjIwNSIsImlhdCI6MTczMDExMzc5NywiZXhwIjoxNzMwMTE0Mzk3fQ.9KCn0Wcnx3Smentveqq7NpqVy0GsfFdOSq2gEXbJCxM"
    
    static let shared = TokenUrl()
    
    private init() {}
}
