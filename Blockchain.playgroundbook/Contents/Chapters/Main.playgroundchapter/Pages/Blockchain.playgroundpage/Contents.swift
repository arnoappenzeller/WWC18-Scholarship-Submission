//#-hidden-code
import Foundation
import UIKit
import PlaygroundSupport

public protocol BlockChainUpdateDelegate{
    func blockchainUpdated(blockchain:Blockchain)
}

public class Blockchain {
    
    public var isMining = false
    
    public var currentChain:[Block] = []
    var currentTransactionList:[Transaction] = []
    public var viewUpdateDelegate:BlockChainUpdateDelegate?
    
    public init(){
        //on first creation of the Blockchain create an initial block and append it to the Blockchain
        let firstBlock = Block(index:0,creationDate:Date(),proofOfWork:20)
        currentChain.append(firstBlock)
    }
    
    public func addTransaction(transaction:Transaction){
        currentTransactionList.append(transaction)
    }
    
    func validateProofOfWork(newHash:Int) -> Bool{
        let hashString = "\(newHash)"
        //3 that equal nil makes a good mix to benchmark the creation
        return hashString.suffix(3) == "000"
    }
    
    func searchForProofOfWork(previousHash:String) -> Double {
        var proof:Double = 0
        var hash = 0
        while !validateProofOfWork(newHash: hash){
            var theHasher = SipHasher()
            theHasher.append(previousHash)
            theHasher.append(proof)
            hash = theHasher.finalize()
            proof += 1
        }
        return proof
    }
    
    //TODO: Implement the proof of work as user task with an extension
    
}

extension BlockchainViewController{
    public func showBlockchain(blockchain:Blockchain){
        //initial setup
        blockScrollView?.removeFromSuperview()
        blockScrollView = nil
        let arrowImage = UIImage(named:"arrow.png")
        var startX:CGFloat = 5
        
        //setup the scrollview
        let playgroundWidth = self.initWidth
        let blockchainFrame = CGRect(x: 25, y: 10, width: playgroundWidth, height: 250)
        let theBlockchainScrollView = UIScrollView(frame:blockchainFrame)
        //theBlockchainScrollView.center =  self.initCenter
        theBlockchainScrollView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin, .flexibleLeftMargin, .flexibleRightMargin]
        blockScrollView = theBlockchainScrollView
        self.view.addSubview(theBlockchainScrollView)
        let scrollViewCenterY:CGFloat = 125
        
        
        //place all blocks
        for block in blockchain.currentChain{
            //create arrowImageView
            let arrowImageView = UIImageView(image:arrowImage)
            arrowImageView.frame.origin.x = startX
            arrowImageView.center.y = scrollViewCenterY
            theBlockchainScrollView.addSubview(arrowImageView)
            
            //calc pos of block
            startX += arrowImageView.frame.size.width + 5
            
            //create blockView
            let blockView = BlockView(withBlock:block)
            blockView.frame.origin.x = startX
            blockView.center.y = scrollViewCenterY
            theBlockchainScrollView.addSubview(blockView)
            
            startX += blockView.frame.size.width + 5
        }
        
        //update scrollView Contentsize
        theBlockchainScrollView.contentSize.width = startX + 100
        
    }
}

extension BlockchainViewController:BlockChainUpdateDelegate{
    public func blockchainUpdated(blockchain:Blockchain){
        DispatchQueue.main.async {
            self.showBlockchain(blockchain:blockchain)
        }
    }
}

let blockVC = BlockchainViewController()
PlaygroundPage.current.liveView = blockVC
//#-end-hidden-code
/*:
 Now since you know about the function of the Block in deep lets chain the Blocks together.
 
 We have a class called `Blockchain` where the Blocks are stored. Lets create an instance of it.
 */
let blockchain = Blockchain()
//#-hidden-code
blockchain.viewUpdateDelegate = blockVC

public func showCurrentBlockchain(){
    blockVC.showBlockchain(blockchain:blockchain)
}
//#-end-hidden-code

/*:
 On the first launch the Blockchain will be initialised with a base Block that contains no transaction and arbitrary values for the other properties.
 Lets have a look at our Blockchain with `showCurrentBlockchain()`
 */

/*#-editable-code*/<#Show current Blockchain#>/*#-end-editable-code*/

/*:
 Now we'll create some Transactions and store them in the blockchain with `blockchain.addTransaction(transaction:)`
 */

//#-editable-code
let transaction1 = Transaction(senderID: "<#T##Sender name##String#>", receiverID: "<#T##Receiver name##String#>", amount: <#T##Amount to send##Double#>)
let transaction2 = Transaction(senderID: "<#T##Sender name##String#>", receiverID: "<#T##Receiver name##String#>", amount: <#T##Amount to send##Double#>)
//add them to the blockchain
<#Add transaction 1 to blockchain#>
<#Add transaction 2 to blockchain#>
//#-end-editable-code

/*:
 Those transactions are now pending. They are not valid until they are part of a new Block. To create a new Block the Block needs to be *mined*.
 Mining means we are looking for a matching Proof of Work for the previous hash. When we found it we can create a new Block with those values.
 
 Lets create a mining function for the `Blockchain` class:
 1. Get the current last Block of the Blockchain with `self.currentChain.last!`
 2. Get the `previousHash` of the last Block with `lastBlock.hash()`
 3. Search for a Proof of Work to the `previousHash`. The Blockchain has a function for this called `self.searchForProofOfWork(previousHash:)`. *This is where the major work of the mining is done*
 4. Now get index of the last Block and add 1 to it for the new index
 5. Create the new Block and add it to the `self.currentChain`
 */


extension Blockchain{
    public func startMining(){
        //#-hidden-code
        DispatchQueue.global(qos: .background).async {
            //wait when other thread is mining previous block
            while(self.isMining){}
            self.isMining = true
            //#-end-hidden-code
            let lastBlock = /*#-editable-code*/<#Get last block#>/*#-end-editable-code*/
            let previousHash:String = /*#-editable-code*/<#Hash the last block#>/*#-end-editable-code*/
            let newProofOfWork:Double = /*#-editable-code*/<#Search for proof of work#>/*#-end-editable-code*/
            let newIndex:Int =  /*#-editable-code*/<#lastBlock.index + 1#>/*#-end-editable-code*/
            let newBlock = Block(index:newIndex,creationDate:Date(),transactionList:self.currentTransactionList ,proofOfWork:newProofOfWork,previousHash:previousHash)
            self.currentChain.append(newBlock)
            //emtpy current transaction List
            self.currentTransactionList = []
            //#-hidden-code
            self.isMining = false
            self.viewUpdateDelegate?.blockchainUpdated(blockchain: self)
        }
        //#-end-hidden-code
    }
}
/*:
 Now start the mining with `blockchain.startMining()` (The view should automatically show the new Block):
 */
/*#-editable-code*/<#Start mining the new Block#>/*#-end-editable-code*/

/*:
 * callout(Bonus task):
 If you want to you can mine more blocks. Just repeat the previous steps (add Transactions and then mine)
 The result will automatically update.
 If you have several blocks pick one and think about if you could substitute this with a block with another transactions and values.*/

//#-editable-code Enter Bonus task code here

//#-end-editable-code

/*:
 # Conclusion
 We saw how to create a basic Block, what the Proof of Work is and how the Blocks are chained together. With this technique we can make a manipulation safe transaction list. If an attacker wants to manipulate the values of one block in the chain he needs to manipulate all blocks before and after this block which will be a *hard* task depending on the Proof of Work.
 
 
 *I hope you enjoyed my Playground* 👨‍💻
 */

