import SwiftUI
import SwiftData

@Model
class Transaction {
    var id: UUID = UUID()
    var title: String
    var comments: String?
    var amount: Double
    var category: String
    var date: Date
    var type: String // "income" or "expense"
    var paymentMethod: String
    
    init(title: String, amount: Double, category: String, date: Date, type: String, paymentMethod: String, comments: String? = nil) {
        self.title = title
        self.amount = amount
        self.category = category
        self.date = date
        self.type = type
        self.paymentMethod = paymentMethod
        self.comments = comments
    }
}
