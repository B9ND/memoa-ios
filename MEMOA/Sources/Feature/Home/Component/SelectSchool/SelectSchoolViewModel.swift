//
//  SelectSchoolViewmodel.swift
//  MEMOA
//
//  Created by dgsw30 on 9/27/24.
//

import Foundation

class SelectSchoolViewModel: ObservableObject {
    @Published var school: [schoolitem] = [
        schoolitem(school: "대구소프트웨어마이스터고"),
        schoolitem(school: "부산소프트웨어마이스터고"),
        schoolitem(school: "광주소프트웨어마이스터고"),
        schoolitem(school: "대덕소프트웨어마이스터고")
    ]
    @Published var grade: [gradeitem] = [
        gradeitem(grade: 1),
        gradeitem(grade: 2),
        gradeitem(grade: 3)
    ]
    
    @Published var selectedSchool: String = "대구소프트웨어마이스터고"
    @Published var selectedGrade: Int = 1
}
