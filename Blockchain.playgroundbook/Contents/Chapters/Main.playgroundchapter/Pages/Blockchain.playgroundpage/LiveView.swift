import Foundation
import UIKit
import PlaygroundSupport

let vc = UIViewController()
vc.view.backgroundColor = UIColor.white
PlaygroundPage.current.liveView = vc

let thePoWLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 400, height: 200))
thePoWLabel.font = UIFont.systemFont(ofSize: 100)
thePoWLabel.adjustsFontSizeToFitWidth = true
thePoWLabel.numberOfLines = 0
thePoWLabel.minimumScaleFactor = 0.1
thePoWLabel.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin, .flexibleLeftMargin, .flexibleRightMargin]
thePoWLabel.text = "Blockchain"
thePoWLabel.textAlignment = .center
thePoWLabel.center = PlaygroundCenterHelper.getPlaygroundViewCenterPoint()
vc.view.addSubview(thePoWLabel)
