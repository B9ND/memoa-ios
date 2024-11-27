//
//  TokenUrl.swift
//  MEMOA
//
//  Created by dgsw30 on 10/24/24.
//

import Foundation

struct TokenUrl {
    var token = "eyJhbGciOiJIUzI1NiJ9.eyJjYXRlZ29yeSI6ImFjY2VzcyIsImVtYWlsIjoia2ltZXVuY2hhbjI4MTVAZ21haWwuY29tIiwicm9sZSI6IlJPTEVfVVNFUiIsImRldmljZSI6Ik1vemlsbGEvNS4wIChNYWNpbnRvc2g7IEludGVsIE1hYyBPUyBYIDEwXzE1XzcpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS8xMzAuMC4wLjAgU2FmYXJpLzUzNy4zNl8yMjEuMTY4LjIyLjIwNSIsImlhdCI6MTczMDI1NTI3NSwiZXhwIjoxNzMwMjU1ODc1fQ.r6RiO71SzBmh9ke00kpcDoYln-szeyf_UF3tFkal_jI"
    
    static let shared = TokenUrl()
    
    private init() {}
}
