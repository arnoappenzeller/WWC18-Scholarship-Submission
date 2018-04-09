import Foundation

public class Block: SipHashable{
    public var index: Int
    public var creationDate: Date
    public var transactionList: [Transaction]
    public var proofOfWork: Double
    public var previousHash: String
    
    public init(index:Int,creationDate:Date,transactionList:[Transaction] = [],proofOfWork:Double,previousHash:String = "0"){
        self.index = index
        self.creationDate = creationDate
        self.transactionList = transactionList
        self.proofOfWork = proofOfWork
        self.previousHash = previousHash
    }
    
    public func appendHashes(to hasher: inout SipHasher) {
        hasher.append(index)
        hasher.append(creationDate.timeIntervalSinceReferenceDate)
        hasher.append(proofOfWork)
        //NOTE: In a real world application the transaction list should also be part of the blocks hash
        hasher.append(previousHash)
    }
    
    public func hash() -> String{
        var hasher = SipHasher()
        hasher.append(self)
        let hashValue = hasher.finalize()
        return "\(hashValue)"
    }
    
    public static func ==(left: Block, right: Block) -> Bool {
         //NOTE: In a real world application the transaction list should also be part when you compare two blocks
        return left.index == right.index && left.creationDate == right.creationDate && left.creationDate == right.creationDate && left.previousHash == right.previousHash
    }
    
    
    
    public func addTransaction(transaction:Transaction){
        self.transactionList.append(transaction)
    }
    
    public func addTransactionList(transactionList:[Transaction]){
        self.transactionList = transactionList
    }
}
