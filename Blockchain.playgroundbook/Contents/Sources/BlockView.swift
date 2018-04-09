import Foundation
import UIKit

public class Line:UIView{
    required public init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    public init(yPos:CGFloat){
        let theFrame = CGRect(x: 0, y: yPos, width: 200, height: 4)
        super.init(frame: theFrame)
        self.backgroundColor = UIColor.black
    }
}

public class BlockView:UIView{
    
    var theBlock:Block?
    
    var blockNoLabel:UILabel?
    var creationTimeLabel:UILabel?
    var transactionLabel:UILabel?
    var proofOfWorkLabel:UILabel?
    var hashLabel:UILabel?
    
    required public init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    public init(withBlock block:Block){
        
        let blockFrame = CGRect(x: 0, y: 0, width: 200, height: 200)
        super.init(frame: blockFrame)
        
        //view setup
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 4
        self.layer.cornerRadius = 9
        self.backgroundColor = UIColor.white
        createLines()
        
        self.theBlock = block
        initialBlockView()
        
    }
    
    init(){
        let blockFrame = CGRect(x: 0, y: 0, width: 200, height: 200)
        super.init(frame: blockFrame)
        
        //view setup
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 4
        self.layer.cornerRadius = 9
        self.backgroundColor = UIColor.clear
        createLines()
    }
    
    func createLines(){
        let line1 = Line(yPos: 36)
        self.addSubview(line1)
        
        let line2 = Line(yPos: 76)
        self.addSubview(line2)
        
        let line3 = Line(yPos: 116)
        self.addSubview(line3)
        
        let line4 = Line(yPos: 156)
        self.addSubview(line4)
    }
    
    func initialBlockView(){
        guard let block = self.theBlock else {return}
        //add the labels
        blockNoLabel = addLineToBlockView(text: "Block No. \(block.index)", yPos: 5)
        creationTimeLabel = addLineToBlockView(text: "Creation Time: \(block.creationDate.timeIntervalSinceReferenceDate)", yPos: 45)
        transactionLabel = addLineToBlockView(text: "Transaction Count: \(block.transactionList.count)", yPos: 85)
        proofOfWorkLabel = addLineToBlockView(text: "Proof Of Work: \(block.proofOfWork)", yPos: 125)
        hashLabel = addLineToBlockView(text: "Previous Hash: \(block.previousHash)", yPos: 165)
    }
    
    public func updateBlockView(){
        guard let block = self.theBlock else {return}
        //if theres a block we know that the labels are setup
        blockNoLabel!.text = "Block No. \(block.index)"
        creationTimeLabel!.text = "Creation Time: \(block.creationDate.timeIntervalSinceReferenceDate)"
        transactionLabel!.text = "Transaction Count: \(block.transactionList.count)"
        proofOfWorkLabel!.text = "Proof Of Work: \(block.proofOfWork)"
        hashLabel!.text = "asdkjjaksdkj"
    }
    
    func addLineToBlockView(text:String,yPos:CGFloat) -> UILabel{
        let line = UILabel(frame: CGRect(x: 10, y: yPos, width: 180, height: 30))
        line.text = text
        line.numberOfLines = 0
        line.adjustsFontSizeToFitWidth = true
        line.minimumScaleFactor = 0.1
        line.textAlignment = .center
        self.addSubview(line)
        return line
    }
    
    public static func emptyBlock() -> BlockView {
        let blockView = BlockView()
        
       //init empty text
        _ = blockView.addLineToBlockView(text: "Block Number", yPos: 5)
        _ = blockView.addLineToBlockView(text: "Creation Time", yPos: 45)
        _ = blockView.addLineToBlockView(text: "Transactions", yPos: 85)
        _ = blockView.addLineToBlockView(text: "Proof Of Work", yPos: 125)
        _ = blockView.addLineToBlockView(text: "Hash", yPos: 165)
        
        return blockView
    }
}
