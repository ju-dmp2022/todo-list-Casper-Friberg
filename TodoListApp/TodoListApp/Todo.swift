import Foundation
import SwiftUI

struct Todo: Identifiable {
    let id = UUID()
    var title: String
    var isDone: Bool = false
    var category: TodoCategory
}

enum TodoCategory: String, CaseIterable, Identifiable {
    var id: String { self.rawValue}
    
    case work = "Work"
    case personal = "Personal"
    //We can add some more categories if needed.
    
    func color() -> Color {
        switch self {
        case .work:
            return Color.blue
        case .personal:
            return Color.pink
        }
    }
}

