//#-hidden-code
import Foundation
import UIKit
import PlaygroundSupport

let vc = UIViewController()
vc.view.backgroundColor = UIColor.white
PlaygroundPage.current.liveView = vc

let thePoWLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 350, height: 200))
thePoWLabel.font = UIFont.systemFont(ofSize: 100)
thePoWLabel.adjustsFontSizeToFitWidth = true
thePoWLabel.numberOfLines = 0
thePoWLabel.minimumScaleFactor = 0.1
thePoWLabel.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin, .flexibleLeftMargin, .flexibleRightMargin]
thePoWLabel.text = ""
thePoWLabel.textAlignment = .center
thePoWLabel.center = PlaygroundCenterHelper.getPlaygroundViewCenterPoint()
vc.view.addSubview(thePoWLabel)

func changeLabelToText(text:String){
    UIView.transition(with: thePoWLabel,
                      duration: 0.1,
                      options: [],
                      animations: {
                        thePoWLabel.text = text
    }, completion: nil)
    
    
}

//#-end-hidden-code

/*:
 On the last page we saw that a block has a *previousHash* and a *proofOfWork*
 
 On this page we look into the details of the Proof of Work
 
 A Block in the Blockchain needs to be hashable. That means that you can get an *unique* value from the Block with its properties.
 To hash something we need a hash function. Common hash functions are **SHA** or **MD5**. In this implementation we use **SipHash** since there is a nice small Open Source Implementation [in Swift](https://github.com/attaswift/SipHash).
 
 To create a new Block there needs to be some kind of value creation. Therefore we need the **Proof of Work**. The Proof of Work ensures that a new Block is part of the chain and is not just randomly created or guessed by someone
 
 A Proof of Work has some conditions:
 * It needs to consider the value/hash of the previous block
 * It needs to be *hard* to calculate so that it can't be simply guessed
 
 A good strategy for a Proof of Work is to append a value to the old hash and create a new hash that fulfills some condition.
 A condition could be for example: *Append a value to the previous hash so the new hash ends with 00*
 
 Now lets create our own proof of work:
 */
func validProof(hash:Int) -> Bool{
    //our hash is an number we convert it to a string
    let hashString = "\(hash)"
    //Choose what the last parts of the new hash should like.
    //Make sure the count of the last elements of the hash are equal to the elements you require
    /*#-editable-code*/return hashString.suffix(<#T##Number of last elements of hash##Int#>) == "<#T##Should equal (Please only use digits)##String#>"/*#-end-editable-code*/
}
/*:
 And now lets do some work and seek for a new Block. You can get the hash of a Block with `block.hash()`:
 */
let block = Block(index:0,creationDate:Date(),proofOfWork:0)
//get hash of block
let blockHash = /*#-editable-code*/<#Get hash of block#>/*#-end-editable-code*/

func searchForProofOfWork(){
    //#-hidden-code
    DispatchQueue.global(qos: .background).async {
        //#-end-hidden-code
        var hash = 0
        var proof = 0
        while !validProof(hash: hash){
            var theHasher = SipHasher()
            theHasher.append(blockHash)
            theHasher.append(proof)
            hash = theHasher.finalize()
            proof += 1
            //#-hidden-code
            DispatchQueue.main.async {
                changeLabelToText(text: "Running... \n Current Proof: \(proof)")
            }
            //#-end-hidden-code
        }
        //#-hidden-code
        DispatchQueue.main.async {
            changeLabelToText(text: "Proof of Work is: \(proof)")
        }
        //#-end-hidden-code
        //#-hidden-code
    }
    //#-end-hidden-code
}
/*:
 Run the code with `searchForProofOfWork()` and also execute the Playground
 */
//#-code-completion(everything, hide)
//#-code-completion(identifier, show, searchForProofOfWork())
//#-editable-code
<#Search for the proof of work#>
//#-end-editable-code



