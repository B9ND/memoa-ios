//
//  SelectSchoolViewmodel.swift
//  MEMOA
//
//  Created by dgsw30 on 9/27/24.
//

import Foundation

class SelectSchoolViewModel: ObservableObject {
    @Published var grade: [gradeitem] = [
        gradeitem(grade: 1),
        gradeitem(grade: 2),
        gradeitem(grade: 3)
    ]
    
    @Published var selectedGrade: Int = 1
    @Published var selectedSubject: String = ""
}
