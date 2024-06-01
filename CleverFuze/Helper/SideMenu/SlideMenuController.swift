//
//  SlideMenuController.swift
//
//  Created by Yuji Hato on 12/3/14.
//

import UIKit

@objc public protocol SlideMenuControllerDelegate {
    @objc optional func leftWillOpen()
    @objc optional func leftDidOpen()
    @objc optional func leftWillClose()
    @objc optional func leftDidClose()
}
let screenSize = UIScreen.main.bounds
public struct SlideMenuOptions {
    public static var leftViewWidth: CGFloat = screenSize.width //- ((screenSize.width/2)/2)
    public static var leftBezelWidth: CGFloat? = 16.0
    public static var contentViewScale: CGFloat = 1
    public static var contentViewOpacity: CGFloat = 0.5
    public static var contentViewDrag: Bool = false
    public static var shadowOpacity: CGFloat = 0.0
    public static var shadowRadius: CGFloat = 0.0
    public static var shadowOffset: CGSize = CGSize(width: 0,height: 0)
    public static var panFromBezel: Bool = true
    public static var animationDuration: CGFloat = 0.4
    public static var animationOptions: UIView.AnimationOptions = []
    public static var hideStatusBar: Bool = false
    public static var pointOfNoReturnWidth: CGFloat = 44.0
    public static var simultaneousGestureRecognizers: Bool = false
    public static var opacityViewBackgroundColor: UIColor = UIColor.black
    public static var panGesturesEnabled: Bool = true
    public static var tapGesturesEnabled: Bool = false
}

public class SlideMenuController: UIViewController, UIGestureRecognizerDelegate {

    public enum SlideAction {
        case open
        case close
    }
    
    public enum TrackAction {
        case leftTapOpen
        case leftTapClose
        case leftFlickOpen
        case leftFlickClose
    }
    
    
    struct PanInfo {
        var action: SlideAction
        var shouldBounce: Bool
        var velocity: CGFloat
    }
    
    open weak var delegate: SlideMenuControllerDelegate?
    
    open var opacityView = UIView()
    open var mainContainerView = UIView()
    open var leftContainerView = UIView()
    open var mainViewController: UIViewController?
    open var leftViewController: UIViewController?
    open var leftPanGesture: UIPanGestureRecognizer?
    open var leftTapGesture: UITapGestureRecognizer?
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    public convenience init(mainViewController: UIViewController, leftMenuViewController: UIViewController) {
        self.init()
        self.mainViewController = mainViewController
        leftViewController = leftMenuViewController
        initView()
    }
    open override func awakeFromNib() {
        initView()
    }

    deinit { }
    
    open func initView() {
        mainContainerView = UIView(frame: view.bounds)
        mainContainerView.backgroundColor = UIColor.clear
        mainContainerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        view.insertSubview(mainContainerView, at: 0)

      var opacityframe: CGRect = view.bounds
        let opacityOffset: CGFloat = 0
        opacityframe.origin.y = opacityframe.origin.y + opacityOffset
        opacityframe.size.height = opacityframe.size.height - opacityOffset
        opacityView = UIView(frame: opacityframe)
        opacityView.backgroundColor = SlideMenuOptions.opacityViewBackgroundColor
        opacityView.autoresizingMask = [UIView.AutoresizingMask.flexibleHeight, UIView.AutoresizingMask.flexibleWidth]
        opacityView.layer.opacity = 0.0
        view.insertSubview(opacityView, at: 1)
      
      if leftViewController != nil {
        var leftFrame: CGRect = view.bounds
        leftFrame.size.width = SlideMenuOptions.leftViewWidth
        leftFrame.origin.x = leftMinOrigin()
        let leftOffset: CGFloat = 0
        leftFrame.origin.y = leftFrame.origin.y + leftOffset
        leftFrame.size.height = leftFrame.size.height - leftOffset
        leftContainerView = UIView(frame: leftFrame)
        leftContainerView.backgroundColor = UIColor.clear
        leftContainerView.autoresizingMask = UIView.AutoresizingMask.flexibleHeight
        view.insertSubview(leftContainerView, at: 2)
        addLeftGestures()
      }

    }
  
    open override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        mainContainerView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        leftContainerView.isHidden = true
      
        coordinator.animate(alongsideTransition: nil, completion: { (context: UIViewControllerTransitionCoordinatorContext!) -> Void in
            self.closeLeftNonAnimation()
            self.leftContainerView.isHidden = false
      
            if self.leftPanGesture != nil && self.leftPanGesture != nil {
                self.removeLeftGestures()
                self.addLeftGestures()
            }
            
        })
    }
  
    open override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = UIRectEdge()
    }

    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    open override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        if let mainController = self.mainViewController{
            return mainController.supportedInterfaceOrientations
        }
        return UIInterfaceOrientationMask.all
    }
    
    open override var shouldAutorotate : Bool {
        return mainViewController?.shouldAutorotate ?? false
    }
        
    open override func viewWillLayoutSubviews() {
        setUpViewController(mainContainerView, targetViewController: mainViewController)
        setUpViewController(leftContainerView, targetViewController: leftViewController)
    }
    
      func openLeft() {
        guard let _ = leftViewController else {
            return
        }
        
        self.delegate?.leftWillOpen?()
        
        setOpenWindowLevel()
        leftViewController?.beginAppearanceTransition(isLeftHidden(), animated: true)
        openLeftWithVelocity(0.0)
        
        track(.leftTapOpen)
    }
     func closeLeft() {
        guard let _ = leftViewController else {
            return
        }
        
        self.delegate?.leftWillClose?()
        
        leftViewController?.beginAppearanceTransition(isLeftHidden(), animated: true)
        closeLeftWithVelocity(0.0)
        setCloseWindowLevel()
    }

    public func addLeftGestures() {
    
        if leftViewController != nil {
            if SlideMenuOptions.panGesturesEnabled {
                if leftPanGesture == nil {
                    leftPanGesture = UIPanGestureRecognizer(target: self, action: #selector(self.handleLeftPanGesture(_:)))
                    leftPanGesture!.delegate = self
                    leftPanGesture?.maximumNumberOfTouches = 1
                    leftPanGesture?.cancelsTouchesInView = false
                    view.addGestureRecognizer(leftPanGesture!)
                }
            }
            
            if SlideMenuOptions.tapGesturesEnabled {
                if leftTapGesture == nil {
                    leftTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.toggleLeft))
                    leftTapGesture!.delegate = self
                    leftTapGesture?.numberOfTouchesRequired = 1
                    leftTapGesture?.numberOfTapsRequired = 1
                    leftTapGesture?.cancelsTouchesInView = false
                    view.addGestureRecognizer(leftTapGesture!)
                }
            }
        }
    
    }
   
    
    public func removeLeftGestures() {
        
        if leftPanGesture != nil {
            view.removeGestureRecognizer(leftPanGesture!)
            leftPanGesture = nil
        }
        
        if leftTapGesture != nil {
            view.removeGestureRecognizer(leftTapGesture!)
            leftTapGesture = nil
        }
    }
   
    
    open func isTagetViewController() -> Bool {
        // Function to determine the target ViewController
        // Please to override it if necessary
        return true
    }
    
    open func track(_ trackAction: TrackAction) {
        // function is for tracking
        // Please to override it if necessary
    }
    
    struct LeftPanState {
        static var frameAtStartOfPan: CGRect = CGRect.zero
        static var startPointOfPan: CGPoint = CGPoint.zero
        static var wasOpenAtStartOfPan: Bool = false
        static var wasHiddenAtStartOfPan: Bool = false
        static var lastState : UIGestureRecognizer.State = .ended
    }
    
    @objc func handleLeftPanGesture(_ panGesture: UIPanGestureRecognizer) {
        
        if !isTagetViewController() {
            return
        }
        
        switch panGesture.state {
        case UIGestureRecognizer.State.began:
                if LeftPanState.lastState != .ended &&  LeftPanState.lastState != .cancelled &&  LeftPanState.lastState != .failed {
                    return
                }
                
                if isLeftHidden() {
                    self.delegate?.leftWillOpen?()
                } else {
                    self.delegate?.leftWillClose?()
                }
                
                LeftPanState.frameAtStartOfPan = leftContainerView.frame
                LeftPanState.startPointOfPan = panGesture.location(in: view)
                LeftPanState.wasOpenAtStartOfPan = isLeftOpen()
                LeftPanState.wasHiddenAtStartOfPan = isLeftHidden()
                
                leftViewController?.beginAppearanceTransition(LeftPanState.wasHiddenAtStartOfPan, animated: true)
                addShadowToView(leftContainerView)
                setOpenWindowLevel()
        case UIGestureRecognizer.State.changed:
                if LeftPanState.lastState != .began && LeftPanState.lastState != .changed {
                    return
                }
                
                let translation: CGPoint = panGesture.translation(in: panGesture.view!)
                leftContainerView.frame = applyLeftTranslation(translation, toFrame: LeftPanState.frameAtStartOfPan)
                applyLeftOpacity()
                applyLeftContentViewScale()
        case UIGestureRecognizer.State.ended, UIGestureRecognizer.State.cancelled:
                if LeftPanState.lastState != .changed {
                    setCloseWindowLevel()
                    return
                }
                
                let velocity:CGPoint = panGesture.velocity(in: panGesture.view)
                let panInfo: PanInfo = panLeftResultInfoForVelocity(velocity)
                
                if panInfo.action == .open {
                    if !LeftPanState.wasHiddenAtStartOfPan {
                        leftViewController?.beginAppearanceTransition(true, animated: true)
                    }
                    openLeftWithVelocity(panInfo.velocity)
                    
                    track(.leftFlickOpen)
                } else {
                    if LeftPanState.wasHiddenAtStartOfPan {
                        leftViewController?.beginAppearanceTransition(false, animated: true)
                    }
                    closeLeftWithVelocity(panInfo.velocity)
                    setCloseWindowLevel()
                    
                    track(.leftFlickClose)

                }
        case UIGestureRecognizer.State.failed, UIGestureRecognizer.State.possible:
                break
        default:
            break
        }
        
        LeftPanState.lastState = panGesture.state
    }
    

    open func openLeftWithVelocity(_ velocity: CGFloat) {
        let xOrigin: CGFloat = leftContainerView.frame.origin.x
        let finalXOrigin: CGFloat = 0.0
        
        var frame = leftContainerView.frame
        frame.origin.x = finalXOrigin
        
        var duration: TimeInterval = Double(SlideMenuOptions.animationDuration)
        if velocity != 0.0 {
            duration = Double(abs(xOrigin - finalXOrigin) / velocity)
            duration = Double(fmax(0.1, fmin(1.0, duration)))
        }
        
        addShadowToView(leftContainerView)
        
        UIView.animate(withDuration: duration, delay: 0.0, options: SlideMenuOptions.animationOptions, animations: { [weak self]() -> Void in
            if let strongSelf = self {
                strongSelf.leftContainerView.frame = frame
                strongSelf.opacityView.layer.opacity = Float(SlideMenuOptions.contentViewOpacity)
              
                SlideMenuOptions.contentViewDrag == true ? (strongSelf.mainContainerView.transform = CGAffineTransform(translationX: SlideMenuOptions.leftViewWidth, y: 0)) : (strongSelf.mainContainerView.transform = CGAffineTransform(scaleX: SlideMenuOptions.contentViewScale, y: SlideMenuOptions.contentViewScale))
                
            }
            }) { [weak self](Bool) -> Void in
                if let strongSelf = self {
                    strongSelf.disableContentInteraction()
                    strongSelf.leftViewController?.endAppearanceTransition()
                    strongSelf.delegate?.leftDidOpen?()
                }
        }
    }
    

    open func closeLeftWithVelocity(_ velocity: CGFloat) {
        
        let xOrigin: CGFloat = leftContainerView.frame.origin.x
        let finalXOrigin: CGFloat = leftMinOrigin()
        
        var frame: CGRect = leftContainerView.frame
        frame.origin.x = finalXOrigin
    
        var duration: TimeInterval = Double(SlideMenuOptions.animationDuration)
        if velocity != 0.0 {
            duration = Double(abs(xOrigin - finalXOrigin) / velocity)
            duration = Double(fmax(0.1, fmin(1.0, duration)))
        }
        
        UIView.animate(withDuration: duration, delay: 0.0, options: SlideMenuOptions.animationOptions, animations: { [weak self]() -> Void in
            if let strongSelf = self {
                strongSelf.leftContainerView.frame = frame
                strongSelf.opacityView.layer.opacity = 0.0
                strongSelf.mainContainerView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }
            }) { [weak self](Bool) -> Void in
                if let strongSelf = self {
                    strongSelf.removeShadow(strongSelf.leftContainerView)
                    strongSelf.enableContentInteraction()
                    strongSelf.leftViewController?.endAppearanceTransition()
                    strongSelf.delegate?.leftDidClose?()
                }
        }
    }
    
  
    
    @objc public func toggleLeft() {
        if isLeftOpen() {
            closeLeft()
            setCloseWindowLevel()
            // Tracking of close tap is put in here. Because closeMenu is due to be call even when the menu tap.

            track(.leftTapClose)
        } else {
            openLeft()
        }
    }
    
    open func isLeftOpen() -> Bool {
        return leftViewController != nil && leftContainerView.frame.origin.x == 0.0
    }
    
    open func isLeftHidden() -> Bool {
        return leftContainerView.frame.origin.x <= leftMinOrigin()
    }
    
    open func changeMainViewController(_ mainViewController: UIViewController,  close: Bool) {
        
        removeViewController(self.mainViewController)
        self.mainViewController = mainViewController
        setUpViewController(mainContainerView, targetViewController: mainViewController)
        if close {
            closeLeft()
        }
    }
    
    open func changeLeftViewWidth(_ width: CGFloat) {
        
        SlideMenuOptions.leftViewWidth = width
        var leftFrame: CGRect = view.bounds
        leftFrame.size.width = width
        leftFrame.origin.x = leftMinOrigin()
        let leftOffset: CGFloat = 0
        leftFrame.origin.y = leftFrame.origin.y + leftOffset
        leftFrame.size.height = leftFrame.size.height - leftOffset
        leftContainerView.frame = leftFrame
    }
    
    public func changeLeftViewController(_ leftViewController: UIViewController, closeLeft:Bool) {
        
        removeViewController(self.leftViewController)
        self.leftViewController = leftViewController
        setUpViewController(leftContainerView, targetViewController: leftViewController)
        if closeLeft {
            self.closeLeft()
        }
    }
    
    public func leftMinOrigin() -> CGFloat {
        return  -SlideMenuOptions.leftViewWidth
    }
    
     func panLeftResultInfoForVelocity(_ velocity: CGPoint) -> PanInfo {
        
        let thresholdVelocity: CGFloat = 1000.0
        let pointOfNoReturn: CGFloat = CGFloat(floor(leftMinOrigin())) + SlideMenuOptions.pointOfNoReturnWidth
        let leftOrigin: CGFloat = leftContainerView.frame.origin.x
        
        var panInfo: PanInfo = PanInfo(action: .close, shouldBounce: false, velocity: 0.0)
        
        panInfo.action = leftOrigin <= pointOfNoReturn ? .close : .open
        
        if velocity.x >= thresholdVelocity {
            panInfo.action = .open
            panInfo.velocity = velocity.x
        } else if velocity.x <= (-1.0 * thresholdVelocity) {
            panInfo.action = .close
            panInfo.velocity = velocity.x
        }
        
        return panInfo
    }
    
    public func applyLeftTranslation(_ translation: CGPoint, toFrame:CGRect) -> CGRect {
        
        var newOrigin: CGFloat = toFrame.origin.x
        newOrigin += translation.x
        
        let minOrigin: CGFloat = leftMinOrigin()
        let maxOrigin: CGFloat = 0.0
        var newFrame: CGRect = toFrame
        
        if newOrigin < minOrigin {
            newOrigin = minOrigin
        } else if newOrigin > maxOrigin {
            newOrigin = maxOrigin
        }
        
        newFrame.origin.x = newOrigin
        return newFrame
    }
    
    public func getOpenedLeftRatio() -> CGFloat {
        
        let width: CGFloat = leftContainerView.frame.size.width
        let currentPosition: CGFloat = leftContainerView.frame.origin.x - leftMinOrigin()
        return currentPosition / width
    }
    
    public func applyLeftOpacity() {
        
        let openedLeftRatio: CGFloat = getOpenedLeftRatio()
        let opacity: CGFloat = SlideMenuOptions.contentViewOpacity * openedLeftRatio
        opacityView.layer.opacity = Float(opacity)
    }
    
    public func applyLeftContentViewScale() {
        let openedLeftRatio: CGFloat = getOpenedLeftRatio()
        let scale: CGFloat = 1.0 - ((1.0 - SlideMenuOptions.contentViewScale) * openedLeftRatio)
        let drag: CGFloat = SlideMenuOptions.leftViewWidth + leftContainerView.frame.origin.x
        
        SlideMenuOptions.contentViewDrag == true ? (mainContainerView.transform = CGAffineTransform(translationX: drag, y: 0)) : (mainContainerView.transform = CGAffineTransform(scaleX: scale, y: scale))
    }
    
    public func addShadowToView(_ targetContainerView: UIView) {
        targetContainerView.layer.masksToBounds = false
        targetContainerView.layer.shadowOffset = SlideMenuOptions.shadowOffset
        targetContainerView.layer.shadowOpacity = Float(SlideMenuOptions.shadowOpacity)
        targetContainerView.layer.shadowRadius = SlideMenuOptions.shadowRadius
        targetContainerView.layer.shadowPath = UIBezierPath(rect: targetContainerView.bounds).cgPath
    }
    
    public func removeShadow(_ targetContainerView: UIView) {
        targetContainerView.layer.masksToBounds = true
        mainContainerView.layer.opacity = 1.0
    }
    
    public func removeContentOpacity() {
        opacityView.layer.opacity = 0.0
    }
    

    public func addContentOpacity() {
        opacityView.layer.opacity = Float(SlideMenuOptions.contentViewOpacity)
    }
    
    public func disableContentInteraction() {
        mainContainerView.isUserInteractionEnabled = false
    }
    
    public func enableContentInteraction() {
        mainContainerView.isUserInteractionEnabled = true
    }
    
    public func setOpenWindowLevel() {
        if SlideMenuOptions.hideStatusBar {
            DispatchQueue.main.async(execute: {
                if let window = UIApplication.shared.keyWindow {
                    window.windowLevel = UIWindow.Level.statusBar + 1
                }
            })
        }
    }
    
    public func setCloseWindowLevel() {
        if SlideMenuOptions.hideStatusBar {
            DispatchQueue.main.async(execute: {
                if let window = UIApplication.shared.keyWindow {
                    window.windowLevel = UIWindow.Level.normal
                }
            })
        }
    }
    
    public func setUpViewController(_ targetView: UIView, targetViewController: UIViewController?) {
        if let viewController = targetViewController {
            viewController.view.frame = targetView.bounds
            
            if (!children.contains(viewController)) {
                addChild(viewController)
                targetView.addSubview(viewController.view)
                viewController.didMove(toParent: self)
            }
        }
    }
    
    
    public func removeViewController(_ viewController: UIViewController?) {
        if let _viewController = viewController {
            _viewController.view.layer.removeAllAnimations()
            _viewController.willMove(toParent: nil)
            _viewController.view.removeFromSuperview()
            _viewController.removeFromParent()
        }
    }
    
    public func closeLeftNonAnimation(){
        setCloseWindowLevel()
        let finalXOrigin: CGFloat = leftMinOrigin()
        var frame: CGRect = leftContainerView.frame
        frame.origin.x = finalXOrigin
        leftContainerView.frame = frame
        opacityView.layer.opacity = 0.0
        mainContainerView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        removeShadow(leftContainerView)
        enableContentInteraction()
    }
    
    // MARK: UIGestureRecognizerDelegate
    open func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        let point: CGPoint = touch.location(in: view)
        
        if gestureRecognizer == leftPanGesture {
            return slideLeftForGestureRecognizer(gestureRecognizer, point: point)
        }
        else if gestureRecognizer == leftTapGesture {
            return isLeftOpen() && !isPointContainedWithinLeftRect(point)
        }
        return true
    }
    
    // returning true here helps if the main view is fullwidth with a scrollview
    open func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return SlideMenuOptions.simultaneousGestureRecognizers
    }
    
    public func slideLeftForGestureRecognizer( _ gesture: UIGestureRecognizer, point:CGPoint) -> Bool{
        return isLeftOpen() || SlideMenuOptions.panFromBezel && isLeftPointContainedWithinBezelRect(point)
    }
    
    public func isLeftPointContainedWithinBezelRect(_ point: CGPoint) -> Bool{
        if let bezelWidth = SlideMenuOptions.leftBezelWidth {
            var leftBezelRect: CGRect = CGRect.zero
            let tuple = view.bounds.divided(atDistance: bezelWidth, from: CGRectEdge.minXEdge)
            leftBezelRect = tuple.slice
            return leftBezelRect.contains(point)
        } else {
            return true
        }
    }
    
    public func isPointContainedWithinLeftRect(_ point: CGPoint) -> Bool {
        return leftContainerView.frame.contains(point)
    }
}

extension UIViewController {

    public func slideMenuViewController() -> SlideMenuController? {
        var viewController: UIViewController? = self
        while viewController != nil {
            if viewController is SlideMenuController {
                return viewController as? SlideMenuController
            }
            viewController = viewController?.parent
        }
        return nil
    }
    
    // Please specify if you want menu gesuture give priority to than targetScrollView
    public func addPriorityToMenuGesuture(_ targetScrollView: UIScrollView) {
        let slideController = SlideMenuController()
      guard let recognizers = slideController.view.gestureRecognizers else {
            return
        }
        for recognizer in recognizers where recognizer is UIPanGestureRecognizer {
            targetScrollView.panGestureRecognizer.require(toFail: recognizer)
        }
    }
}
