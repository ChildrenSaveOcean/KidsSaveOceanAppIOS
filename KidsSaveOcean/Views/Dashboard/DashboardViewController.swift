//
//  DashboardViewController.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 1/11/19.
//  Copyright © 2019 KidsSaveOcean. All rights reserved.
//

import UIKit
import AVFoundation

class DashboardViewController: UIViewController {

    @IBOutlet weak var topTaskIcon1: UIButton!
    @IBOutlet weak var topTaskIcon2: UIButton!
    @IBOutlet weak var topTaskIcon3: UIButton!
    @IBOutlet weak var topTaskIcon4: UIButton!
    @IBOutlet weak var topTaskIcon5: UIButton!
    @IBOutlet weak var topTaskIcon6: UIButton!
    
    @IBOutlet weak var meterPointer: UIImageView!
    @IBOutlet weak var wheelPoint: UIImageView!
    
    @IBOutlet weak var wheelVolume: UIImageView!
    @IBOutlet weak var completedFistImage: UIImageView!
    @IBOutlet weak var completedLabel: UILabel!
    
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var howButton: UIButton!
    @IBOutlet weak var didItButton: UIButton!
    
    @IBOutlet weak var actionAlertButton: UIButton!
    
    @IBOutlet weak var wheelPositionButton1: UIButton!
    
    @IBOutlet weak var wheelPositionButton2: UIButton!
    
    @IBOutlet weak var wheelPositionButton3: UIButton!
    @IBOutlet weak var wheelPositionButton4: UIButton!
    @IBOutlet weak var wheelPositionButton5: UIButton!
    @IBOutlet weak var wheelPositionButton6: UIButton!
    
    var audioPlayer = AVAudioPlayer()
    var previousTaskSwitched = -1
    lazy var topIcons = [self.topTaskIcon1, self.topTaskIcon2, self.topTaskIcon3,  self.topTaskIcon4, self.topTaskIcon5, self.topTaskIcon6]
    
    // MARK: Lifecyrcle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            guard let url = Bundle.main.url(forResource: "knobClick", withExtension: "mp3") else { return }
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.prepareToPlay()
            audioPlayer.numberOfLoops = 1
        } catch {
            return
        }

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let placeholder = self.view!
        Bundle.main.loadNibNamed("DashboardViewController", owner: self, options: nil)
        placeholder.superview?.insertSubview(self.view, aboveSubview: placeholder)
        placeholder.removeFromSuperview()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        chooseTaskWithNum(0) // it call this function from viewDidAppear, the wheelPointer will be moved to the start position
    }
    
    // MARK: actions methods
    @IBAction func switchTask1(_ sender: Any) {
        chooseTaskWithNum(0)
    }
    
    @IBAction func switchTask2(_ sender: Any) {
        chooseTaskWithNum(1)
    }
    
    @IBAction func switchTask3(_ sender: Any) {
        chooseTaskWithNum(2)
    }
    
    @IBAction func switchTask4(_ sender: Any) {
        chooseTaskWithNum(3)
    }
    
    @IBAction func switchTask5(_ sender: Any) {
        chooseTaskWithNum(4)
    }
    
    @IBAction func switchTask6(_ sender: Any) {
        chooseTaskWithNum(5)
    }
    
    
    @IBAction func actionAlertAction(_ sender: Any) {
        // show custom alert view
    }
    

    // MARK: Private methods
    private func chooseTaskWithNum(_ num:Int) {
        
        if num == previousTaskSwitched { return }
        
        selectTopIcon(num)
        switchWheelPointerPosition(num)
        
        // rotate Meter Pointer
        // show Task on the task label
        // change target for howButton
        
        playSound()
        
        // completed or not:
        //    change color of icon , add halo,
        //    show completed Image (fist)
        //    completed Label text
        //    set didItButton title
        
        previousTaskSwitched = num
    }
    
    private func rotateMeterPointer(to position:CGPoint) {
        
    }
    private func selectTopIcon(_ num:Int) {
        
        /*Peder [3:15 PM]
        1) if selected and incomplete: halo added, background white, icon red
        2) I selected and complete: halo, background white, icon blue
        3) If unselected and incomplete: background darker, icon red
        4) If unselected and complete: background white, icon blue */
        
        let icon:UIButton = topIcons[num]!
        icon.setImage(#imageLiteral(resourceName: "dashboardIconRed"), for: .normal)
        icon.backgroundColor = .clear
        icon.layer.shadowColor = UIColor.white.cgColor
        icon.layer.shadowRadius = 15.0
        icon.layer.shadowOpacity = 1.0
        icon.layer.shadowOffset = CGSize(width: 2, height: 2)
        icon.layer.masksToBounds = false
        
        // clear previous icon
        if previousTaskSwitched < 0 { return }
        let previousIcon:UIButton = topIcons[previousTaskSwitched]!
        previousIcon.setImage(#imageLiteral(resourceName: "dashboardIconRedNotFinished"), for: .normal)
        previousIcon.layer.shadowRadius = 0
        previousIcon.layer.shadowOpacity = 0
        previousIcon.layer.shadowOffset = .zero
    }
    
    
    private func switchWheelPointerPosition(_ num:Int) {
        let keyFrameAnimation = CAKeyframeAnimation()
        let path = CGMutablePath()
        
        let center = CGPoint(x:wheelVolume.center.x, y:wheelVolume.center.y - 3)
        let oneAngle = 2 * CGFloat.pi / CGFloat(7)
        let halfOfPi = CGFloat.pi/CGFloat(2)
        
        let clockWise = previousTaskSwitched > num
        let startAngle = halfOfPi + oneAngle * CGFloat(previousTaskSwitched + 1)
        let endAngle = startAngle + oneAngle * CGFloat(num - previousTaskSwitched)
        
        path.addArc(center: center, radius: 25, startAngle: startAngle, endAngle: endAngle, clockwise: clockWise)
        
        keyFrameAnimation.path = path
        keyFrameAnimation.duration = 0.2 * Double(abs(num - previousTaskSwitched))
        keyFrameAnimation.isRemovedOnCompletion = true
        wheelPoint.layer.add(keyFrameAnimation, forKey: "position")
        wheelPoint.layer.position = path.currentPoint
    }
    
    private func playSound() {
        audioPlayer.play()
    }
}
