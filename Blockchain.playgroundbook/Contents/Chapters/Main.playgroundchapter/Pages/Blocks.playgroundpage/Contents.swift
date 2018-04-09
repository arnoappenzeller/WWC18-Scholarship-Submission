//#-hidden-code
import Foundation
import PlaygroundSupport
import UIKit

let blockVC = BlockchainViewController()
//#-end-hidden-code

/*:
 As the name Blockchain says it is a chain made of Blocks.
 
 
 On this page we'll have a look on the Blocks. In the view above you can see the layout of an empty Block.
 
 As we said on the last page a Blockchain is a technique for transaction. So the single Blocks contain the transaction of the Blockchain. The simplest use-case for this is a money transaction but there are several more.
 
 A block consists out of those elements:
 * It has an **index** number that says which block it is in the chain
 * A **creation time** to track the Block
 * A **list of transactions** for transactions that are in the given Block
 * A **Proof of Work** -> we get back to this on the next page
 * An **hash** we also look deeper into this on the next page
 
 
 Now it's time to creat your first Blockchain Block. You can create a new Block with the class `Block`.
 Initialise it with an arbitrary index and proof work. As date you should use the current date with `Date()`in Swift. Don't worry about the transaction list and the hash.
 */

let myBlock = /*#-editable-code*/<#Your Block#>/*#-end-editable-code*/


/*:
 Next lets have a look on Transactions.
 Transactions have a `senderID` and `receiverID`. In many cases this is just the name of those parties.
 Transactions also contain the amount (of money) the sender wants to send to the receiver. You can create them with the class `Transaction`.
 You can add transactions to your Block with `myBlock.addTransaction(transaction:Transaction)`
 
 *Create a new a transaction and add it to your Block*
 */



let transaction = /*#-editable-code*/<#Your Transaction#>/*#-end-editable-code*/
/*#-editable-code*/<#Add transaction to your Block#>/*#-end-editable-code*/

/*:
 Finally see the result with `showSingleBlock(block:Block)` and run the code
 */


//#-hidden-code
public func showSingleBlock(block:Block){
    PlaygroundPage.current.liveView = blockVC
    blockVC.showSingleBlock(block: block)
}
//#-end-hidden-code

//#-code-completion(everything, hide)
//#-code-completion(identifier, hide, transaction)
//#-code-completion(identifier, show, showSingleBlock(block:), myBlock)
//#-editable-code
<#Display your block#>
//#-end-editable-code
