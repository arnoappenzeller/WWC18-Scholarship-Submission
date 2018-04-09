import Foundation

public class Transaction {
    var senderID: String
    var receiverID: String
    var amount: Double
    
    public init(senderID:String,receiverID:String,amount:Double) {
        self.senderID = senderID
        self.receiverID = receiverID
        self.amount = amount
    }
}
