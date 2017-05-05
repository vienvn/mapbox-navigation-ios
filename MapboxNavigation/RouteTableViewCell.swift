import UIKit
import MapboxDirections
import MapboxCoreNavigation

class RouteTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: StyleLabel!
    @IBOutlet weak var subtitleLabel: StyleLabel!
    @IBOutlet weak var turnArrowView: TurnArrowView!
    
    let distanceFormatter = DistanceFormatter(approximate: true)
    let routeStepFormatter = RouteStepFormatter()
    
    var step: RouteStep? {
        didSet {
            turnArrowView.isHidden = step == nil
            guard let step = step else {
                return
            }
            
            turnArrowView.step = step
            titleLabel.text = routeStepFormatter.string(for: step)
            subtitleLabel.text = step.distance.toKm()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        contentView.alpha = 1
    }
}

extension CLLocationDistance {
    public func toKm() -> String {
        if self < 0 {
            return ""
        }
        if self > 1000 {
            return "\(((self / 1000.0) * 10).rounded() / 10) km"
        } else {
            return "\(Int(self)) m"
        }
    }
}
