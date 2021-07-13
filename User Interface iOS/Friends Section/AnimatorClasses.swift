//
//  AnimatorClasses.swift
//  User Interface iOS
//
//  Created by Pavel Otverchenko on 28.06.2021.
//

import UIKit

class CustomPushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let source = transitionContext.viewController(forKey: .from) else { return }
        guard let destination = transitionContext.viewController(forKey: .to) else { return }

        transitionContext.containerView.addSubview(destination.view)

        destination.view.setAnchorPoint(anchorPoint: .zero)
        destination.view.frame = CGRect(x: 0, y: 0, width: destination.view.frame.size.width, height: destination.view.frame.size.height)
        destination.view.transform = CGAffineTransform(rotationAngle: -(.pi / 2))

        UIView.animate(withDuration: self.transitionDuration(using: transitionContext)) {
            source.view.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            destination.view.transform = CGAffineTransform(rotationAngle: 0)
        } completion: { finished in
            transitionContext.completeTransition(finished)
        }
    }
}


class CustomPopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let source = transitionContext.viewController(forKey: .from) else { return }
        guard let destination = transitionContext.viewController(forKey: .to) else { return }

        transitionContext.containerView.addSubview(destination.view)
        transitionContext.containerView.sendSubviewToBack(destination.view)

        source.view.setAnchorPoint(anchorPoint: .zero)
        destination.view.frame = source.view.frame
        destination.view.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)

        UIView.animate(withDuration: self.transitionDuration(using: transitionContext)) {
            source.view.transform = CGAffineTransform(rotationAngle: -.pi/2)
            destination.view.transform = CGAffineTransform(scaleX: 1, y: 1)

        } completion: { finished in
            transitionContext.completeTransition(finished)
        }
    }
}

/// Class for UIScreenEdgePanGestureRecognizer
class CustomInteractivrTransition: UIPercentDrivenInteractiveTransition, UIGestureRecognizerDelegate {
    
    var hasStarted: Bool = false
    var shouldFinish: Bool = false
    var viewController: UIViewController? {
        didSet {
            let recognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleEdgePanGesture(recognizer:)))
            recognizer.edges = .left
            recognizer.delegate = self
            viewController?.view.addGestureRecognizer(recognizer)
            
//            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
//            viewController?.view.addGestureRecognizer(tapGesture)
        }
    }
    
    @objc
    private func handleTap(_ sender: UITapGestureRecognizer) {
        print("tapped")
    }
    
    @objc
    private func handleEdgePanGesture (recognizer: UIScreenEdgePanGestureRecognizer) {
        print("left edge trigger")
        switch recognizer.state {
        case .began:
            self.hasStarted = true
            self.viewController?.navigationController?.popViewController(animated: true)
        case .changed:
            let translation = recognizer.translation(in: recognizer.view)
            let relativeTranslation = translation.x / (recognizer.view?.bounds.width ?? 1)
            let progress = max(0, min(1, relativeTranslation))
            
            self.shouldFinish = progress > 0.33
            
            self.update(progress)
        case .ended:
            self.hasStarted = false
            self.finish()
            recognizer.view?.setNeedsLayout()
        case .cancelled:
            self.hasStarted = false
            self.cancel()
        default:
            return
        }
    }
}

//MARK: - Extensions
extension UIView{
    func setAnchorPoint(anchorPoint: CGPoint) {

        var newPoint = CGPoint(x: self.bounds.size.width * anchorPoint.x, y: self.bounds.size.height * anchorPoint.y)
        var oldPoint = CGPoint(x: self.bounds.size.width * self.layer.anchorPoint.x, y: self.bounds.size.height * self.layer.anchorPoint.y)

        newPoint = newPoint.applying(self.transform)
        oldPoint = oldPoint.applying(self.transform)

        var position : CGPoint = self.layer.position

        position.x -= oldPoint.x
        position.x += newPoint.x;

        position.y -= oldPoint.y;
        position.y += newPoint.y;

        self.layer.position = position;
        self.layer.anchorPoint = anchorPoint;
    }
}
