import Foundation
import UIKit

public class PlaygroundCenterHelper{
    public static func getPlaygroundViewCenterPoint() -> CGPoint{
        let centerPoint = CGPoint(x:UIScreen.main.bounds.width/2,y:UIScreen.main.bounds.height/2)
        return centerPoint
    }
    
    public static func getPlaygroundViewWidth() -> CGFloat{
        return UIScreen.main.bounds.width
    }
}

