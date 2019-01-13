//
//  DashboardViewController.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 1/11/19.
//  Copyright © 2019 KidsSaveOcean. All rights reserved.
//

import UIKit
import AVFoundation

//typealias DashboardTopIconType = UIButton

class DashboardViewController: UIViewController {

    @IBOutlet weak var topTaskIcon1: DashboardTopIcon!
    @IBOutlet weak var topTaskIcon2: DashboardTopIcon!
    @IBOutlet weak var topTaskIcon3: DashboardTopIcon!
    @IBOutlet weak var topTaskIcon4: DashboardTopIcon!
    @IBOutlet weak var topTaskIcon5: DashboardTopIcon!
    @IBOutlet weak var topTaskIcon6: DashboardTopIcon!
    
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
    var currentTaskSwitched = -1
    var previousTaskSwitched = -1
    let halfOfPi = CGFloat.pi/CGFloat(2)
    
    let taskScope = ["Research plastic ocean pollution",
                 "Write your goverment a letter",
                 "Spread Fatechanger by sharing",
                 "Start a letter writing campaign",
                 "Seek change throuhg local goverment",
                 "Taks part in or orgonize a protest"]
    
    var completionTasksStates = Settings.getCompletionTasksStatus()
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setUpTopIcons()
        let firstIncompetedTask = completionTasksStates.firstIndex(of: false)
        chooseTaskWithNum(firstIncompetedTask ?? 0) // it call this function from viewDidAppear, the wheelPointer will be moved to the start position
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
    
    @IBAction func howToAction(_ sender: Any) {
        print("HOW TO?")
    }
    
    @IBAction func completeAction(_ sender: Any) {
        let newState = !completionTasksStates[currentTaskSwitched]
        completionTasksStates[currentTaskSwitched] = newState
        Settings.saveCompletionTasksStatus(completionTasksStates)
        
        topIcons[currentTaskSwitched]?.completed = newState
        selectTopIcon()
        setUpDidItSection()
        
    }
    
    // MARK: Private methods
    private func chooseTaskWithNum(_ num:Int) {
        if num == currentTaskSwitched { return }
        previousTaskSwitched = currentTaskSwitched
        currentTaskSwitched = num
        
        selectTopIcon()
        switchWheelPointerPosition()
        rotateMeterPointer()
        setTaskLabel()
        setUpDidItSection()
        
        // change target for howButton
        setUpHowToButton()
        playSound()
    }
    
    private func setUpTopIcons() {
        for (num, icon) in topIcons.enumerated() {
            icon?.completed = completionTasksStates[num]
            icon?.setUnselected()
        }
    }
    
    private func setTaskLabel() {
        taskLabel.text = taskScope[currentTaskSwitched]
    }
    
    private func setUpDidItSection() {
        if completionTasksStates[currentTaskSwitched] {
            completedFistImage.image = #imageLiteral(resourceName: "fist_xvmush")
            didItButton.setTitle("Not yet", for: .normal)
        } else {
            completedFistImage.image = #imageLiteral(resourceName: "Fist grey")
            didItButton.setTitle("I did it!", for: .normal)
        }
    }
    
    private func setUpHowToButton() {
        
    }
    
    private func selectTopIcon() {
        topIcons[currentTaskSwitched]!.setSelected()
        
        // clear previous icon
        if previousTaskSwitched < 0 { return }
        topIcons[previousTaskSwitched]!.setUnselected()
    }
    
    lazy var center = self.meterPointer.layer.position
    private func rotateMeterPointer() {
        
        meterPointer.layer.anchorPoint = CGPoint(x: 1.0, y: 0.5)
        if meterPointer.layer.position == center {
            meterPointer.layer.position = CGPoint(x:center.x + meterPointer.bounds.width/2, y:center.y)
        }
        
        let oneAngle = CGFloat.pi / CGFloat(6)
        let angle = oneAngle * CGFloat(currentTaskSwitched + 1)
        let time = Double(abs(previousTaskSwitched - currentTaskSwitched)) * 0.2
        UIView.animate(withDuration: time) {
            self.meterPointer.transform = CGAffineTransform(rotationAngle: angle)
        }
    }
    
    private func switchWheelPointerPosition() {
        let keyFrameAnimation = CAKeyframeAnimation()
        let path = CGMutablePath()
        
        let center = CGPoint(x:wheelVolume.center.x, y:wheelVolume.center.y - 3)
        let oneAngle = 2 * CGFloat.pi / CGFloat(7)
        
        let clockWise = previousTaskSwitched > currentTaskSwitched
        let startAngle = halfOfPi + oneAngle * CGFloat(previousTaskSwitched + 1)
        let endAngle = startAngle + oneAngle * CGFloat(currentTaskSwitched - previousTaskSwitched)
        
        path.addArc(center: center, radius: 25, startAngle: startAngle, endAngle: endAngle, clockwise: clockWise)
        
        keyFrameAnimation.path = path
        keyFrameAnimation.duration = 0.2 * Double(abs(currentTaskSwitched - previousTaskSwitched))
        keyFrameAnimation.isRemovedOnCompletion = true
        wheelPoint.layer.add(keyFrameAnimation, forKey: "position")
        wheelPoint.layer.position = path.currentPoint
    }
    
    private func playSound() {
        audioPlayer.play()
    }
}
