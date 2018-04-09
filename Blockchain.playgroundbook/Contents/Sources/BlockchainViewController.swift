import Foundation
import UIKit

public class BlockchainViewController:UIViewController{
    
    //those values are somekind of hack to preserve the initial values
    public let initCenter = PlaygroundCenterHelper.getPlaygroundViewCenterPoint()
    public let initWidth = PlaygroundCenterHelper.getPlaygroundViewWidth()
    
    var singleBlockView:BlockView?
    
    public var blockScrollView:UIScrollView?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        //initial setup
        self.view.backgroundColor = UIColor.white
    }
    
    public func showEmptyBlock(){
        //at first remove an older BlockView
        singleBlockView?.removeFromSuperview()
        singleBlockView = nil
        let blockView = BlockView.emptyBlock()
        blockView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin, .flexibleLeftMargin, .flexibleRightMargin]
        blockView.center = PlaygroundCenterHelper.getPlaygroundViewCenterPoint()
        self.view.addSubview(blockView)
    }
    
    
    public func showSingleBlock(block:Block){
        //at first remove an older BlockView
        singleBlockView?.removeFromSuperview()
        singleBlockView = nil
        let blockView = BlockView(withBlock: block)
        blockView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin, .flexibleLeftMargin, .flexibleRightMargin]
        blockView.center = PlaygroundCenterHelper.getPlaygroundViewCenterPoint()
        self.view.addSubview(blockView)
    }
    
    
}
