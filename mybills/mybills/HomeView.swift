import SwiftData
import SwiftUI

struct HomeView: View {
    @Environment(\.modelContext) var modelContext
    @Query var transaction: [Transaction]
    
    @State private var navPath = [Transaction]()
    
    var body: some View {
        NavigationStack(path: $navPath) {
            List {
                ForEach(transaction) { transaction in
                    NavigationLink(value: transaction) {
                        VStack(alignment: .leading) {
                            Text(transaction.title)
                            
                            HStack(spacing: 30) {
                                HStack {
                                    Image(systemName: "dollarsign.circle")
                                    Text(String(transaction.amount))
                                }
                                HStack {
                                    Image(systemName: "hand.thumbsup")
                                    Text(String(transaction.category))
                                }
                                HStack {
                                    Image(systemName: "bolt")
                                    Text(String(transaction.type))
                                }
                            }
                        }
                    }
                }
                .onDelete(perform: deleteTransaction)
            }
            .navigationTitle("Transaction")
            .navigationDestination(for: Transaction.self){ transaction in
                EditTransactionView(transaction: transaction)
            }
            .toolbar {
                Button("Add Samples", action: addSamples)
                
                Button(action: addNewTransaction) {
                    Label("Add new transaction", systemImage: "plus")
                }
            }
        }
    }
    
    func addSamples() {
        let a = Transaction(title: "uber", amount: 17, category: "vehicle", date: Date(), type: "vehicle", paymentMethod: "Wechat")
        let b = Transaction(title: "noodle", amount: 13, category: "meal", date: Date(), type: "meal", paymentMethod: "Wechat")
        let c = Transaction(title: "drug", amount: 25, category: "medician", date: Date(), type: "medician", paymentMethod: "alpay")
        
        modelContext.insert(a)
        modelContext.insert(b)
        modelContext.insert(c)
       
    }
    
    func deleteTransaction(_ indexSet: IndexSet) {
        for item in indexSet {
            let object = transaction[item]
            modelContext.delete(object)
        }
    }
    
    func addNewTransaction() {
        let transaction = Transaction(title: "New Transaction", amount: 3, category: "String", date: Date(), type: "String", paymentMethod: "TString")
        modelContext.insert(transaction)
        
        navPath = [transaction]
    }
}
 
#Preview {
    HomeView()
}
