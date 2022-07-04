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

    @IBOutlet weak var deviceXbackground: UIImageView!

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

    @IBOutlet weak var didButtonsStackView: UIStackView!
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var howButton: UIButton!
    @IBOutlet weak var didItButton: DashboardDidButton!
    @IBOutlet weak var didItMiddleButton: DashboardDidButton!
    
    @IBOutlet weak var actionAlertButton: ActionAlertButton!

    @IBOutlet weak var wheelPositionButton1: UIButton!
    @IBOutlet weak var wheelPositionButton2: UIButton!
    @IBOutlet weak var wheelPositionButton3: UIButton!
    @IBOutlet weak var wheelPositionButton4: UIButton!
    @IBOutlet weak var wheelPositionButton5: UIButton!
    @IBOutlet weak var wheelPositionButton6: UIButton!

    @IBOutlet weak var wheelPointConstraintX: NSLayoutConstraint!
    @IBOutlet weak var wheelPointConstraintY: NSLayoutConstraint!
    @IBOutlet weak var topSpaceContraint: KSOLayoutConstraint!

    @IBOutlet weak var actionAlertView: UIView!
    
    @IBOutlet weak var blur: UIVisualEffectView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var currentTaskSwitched = -1
    var previousTaskSwitched = -1
    let halfOfPi = CGFloat.pi/CGFloat(2)

    let taskScope: [DashboardTask] = DashboardTask.allCases

    lazy var topIcons = [self.topTaskIcon1, self.topTaskIcon2, self.topTaskIcon3, self.topTaskIcon4, self.topTaskIcon5, self.topTaskIcon6]

    var audioPlayers = [AVAudioPlayer]()

    lazy var userTasks = UserTaskViewModel.shared

    // MARK: Lifecyrcle methods
    override func viewDidLoad() {
        super.viewDidLoad()

        if UIScreen.main.bounds.height > 800 {
            deviceXbackground.image = #imageLiteral(resourceName: "IPHONE X background")
        } else {
            deviceXbackground.image = #imageLiteral(resourceName: "blueMetalBackground")
        }

        NotificationCenter.default.addObserver(self, selector: #selector(self.setUserDataLoadingState), name: .userDataHasBeenLoaded, object: nil)
        setUserDataLoadingState()
        
        for _ in 0...2 {
            guard let audioPlayer = setUpAudioPlayer() else {continue}
            audioPlayers.append(audioPlayer)
        }

        setUpTopIcons()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        actionAlertButton.delegate = self
        actionAlertButton.setState()
        
        actionAlertView.alpha = 0
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(closeActionAlertView))
        actionAlertView.addGestureRecognizer(tapGesture)

        navigationController?.setStatusBarColor(UIColor.clear)
        self.chooseTaskWithNum( 0 )

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let firstIncompetedTask = taskScope.map{ userTasks.getTaskStatus($0) }.firstIndex(of: false) ?? 0
        self.chooseTaskWithNum( firstIncompetedTask )
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        userTasks.saveUser()
        navigationController?.navigationBar.isHidden = false
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

    @IBAction func howToAction(_ sender: Any) {
        switch self.currentTaskSwitched {
        case 0:
            tabBarController?.switchToStudentResourcesScreen()

        case 1, 2:
            
            let taskViewController = WriteToWhereViewController.instantiate()
            taskViewController.title = ""
            navigationController?.pushViewController(taskViewController, animated: true)

        case 3:
            ShareKidsSaveOcean.share(target: self) {
                //self.chooseTaskWithNum(3)
            }
            
        case 4:
            let taskViewController = CreateNewEnvironmentPolicyViewController.instantiate()
            taskViewController.title = ""
            self.navigationController?.pushViewController(taskViewController, animated: true)

        case 5:
            let taskViewController = ActivistViewContoller.instantiate()
            taskViewController.title = ""
            navigationController?.pushViewController(taskViewController, animated: true)

        default:
            break
        }
    }

    @IBAction func completeAction(_ sender: Any) {

        let task = taskScope[currentTaskSwitched]
        let newState = !userTasks.getTaskStatus(task)
        userTasks.setTaskStatus(task: task, value: newState)
        topIcons[currentTaskSwitched]?.completed = newState
        
        saveTaskStates()
    }
    
    @IBAction func completeMiddleButtonAction(_ sender: Any) {
        // ?
    }

    @IBAction func actionAlertViewButtonAction(_ sender: Any) {
        closeActionAlertView()
    }
    
    private func saveTaskStates() {
        guard userTasks.userDataHasBeenLoaded else { return }
        userTasks.saveUser()
        selectTopIcon()
        setUpDidItSection()
    }

    @objc func closeActionAlertView() {
        actionAlertView.alpha = 0
    }

    // MARK: Private methods
    @objc private func setUserDataLoadingState() {

        if !userTasks.userDataHasBeenLoaded {

            blur.frame = view.bounds
            blur.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            blur.alpha = 0.7
            activityIndicator.alpha = 1
            activityIndicator.startAnimating()
        } else {

            blur.frame = .zero
            blur.alpha = 0.0
            activityIndicator.alpha = 0
            activityIndicator.stopAnimating()
            setUpTopIcons()
        }
    }
    
    private func chooseTaskWithNum(_ num: Int) {

        previousTaskSwitched = currentTaskSwitched
        currentTaskSwitched = num

        selectTopIcon()
        playSound()
        rotateMeterPointer()
        setTaskLabel()
        setUpDidItSection()
        switchWheelPointerPosition()
    }

    private func setUpTopIcons() {

        for (num, icon) in topIcons.enumerated() {
            icon?.completed =  userTasks.getTaskStatus( DashboardTask.allCases[num] )
            icon?.setUnselected()
        }
    }

    private func setTaskLabel() {
        taskLabel.text = taskScope[currentTaskSwitched].title
    }

    private func setUpDidItSection() {

        getDidButtonsStackView(narrow: true)

        if userTasks.getTaskStatus(taskScope[currentTaskSwitched]) {
            completedFistImage.image = #imageLiteral(resourceName: "fist_xvmush")
            completedLabel.text = "Completed!"
            didItButton.setTitle("Not yet", for: .normal)
        } else {
            completedFistImage.image = #imageLiteral(resourceName: "Incomplete fist and writing")
            completedLabel.text = "Incomplete"
            didItButton.setTitle("I did it!", for: .normal)
        }
    }
    
    private func getDidButtonsStackView(narrow: Bool) {

        if didItMiddleButton.isHidden == narrow {
            return
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            self.didItMiddleButton.isHidden = narrow
            self.didButtonsStackView.spacing = narrow ? 80 : 10
        })
    }
    
    private func selectTopIcon() {

        guard let selectedIcon = topIcons[currentTaskSwitched] else { return }

        // clear previous icon
        if topIcons.indices.contains(previousTaskSwitched) {
            topIcons[previousTaskSwitched]!.setUnselected()
        }
        selectedIcon.setSelected()
    }

   private func rotateMeterPointer() {

        let oneAngle = CGFloat.pi / CGFloat(5)
        let angle = currentTaskSwitched < 2 ? oneAngle * CGFloat(currentTaskSwitched + 1) : oneAngle * CGFloat(currentTaskSwitched)
        let time = Double(abs(previousTaskSwitched - currentTaskSwitched)) * 0.2
        UIView.animate(withDuration: time) {
            self.meterPointer.transform = CGAffineTransform(rotationAngle: angle)
        }
    }

    private func switchWheelPointerPosition() {

        let keyFrameAnimation = CAKeyframeAnimation()
        let path = CGMutablePath()

        let center = CGPoint(x: wheelVolume.center.x, y: wheelVolume.center.y - 3)
        let oneAngle = 2 * CGFloat.pi / CGFloat(7)

        let clockWise = previousTaskSwitched > currentTaskSwitched
        let startAngle = halfOfPi + oneAngle * CGFloat(previousTaskSwitched + 1)
        let endAngle = startAngle + oneAngle * CGFloat(currentTaskSwitched - previousTaskSwitched)
        let radius = 25 * KSOLayoutConstraint.screenDimensionCorrectionFactor

        path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: clockWise)

        keyFrameAnimation.path = path
        keyFrameAnimation.duration = 0.2 * Double(abs(currentTaskSwitched - previousTaskSwitched))
        keyFrameAnimation.isRemovedOnCompletion = true
        wheelPoint.layer.add(keyFrameAnimation, forKey: "position")

        let newPosition = CGPoint(x: path.currentPoint.x - wheelPoint.bounds.width/2, y: path.currentPoint.y - wheelPoint.bounds.width/2)
        wheelPointConstraintX.constant = newPosition.x
        wheelPointConstraintY.constant = newPosition.y
    }

    private func setUpAudioPlayer() -> AVAudioPlayer? {

        do {
            guard let soundURL = Bundle.main.url(forResource: "knobClick", withExtension: "mp3") else {return nil}
            let audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer.numberOfLoops = 1
            audioPlayer.prepareToPlay()
            return audioPlayer
        } catch {
            return nil
        }
    }

    private func playSound() {

        let audioPlayerNum = currentTaskSwitched.remainderReportingOverflow(dividingBy: 3).partialValue
        let audioPlayer: AVAudioPlayer = audioPlayers[audioPlayerNum]
        guard audioPlayers.indices.contains(audioPlayerNum) else { return }
        audioPlayer.play()
    }
    
    override func didReceiveMemoryWarning() {
        userTasks.saveUser()
        super.didReceiveMemoryWarning()
    }
}

extension DashboardViewController: ActionAlertProtocol {
    func showActionAlertView() {
        actionAlertView.alpha = 1
    }
    
    func gotoActionAlertViewController() {
        let alertActionVC = AlertActionDashboardViewController()
        present(alertActionVC, animated: true) {
            self.updateViews()
        }
        actionAlertView.alpha = 0
    }
}

extension DashboardViewController: NotificationProtocol {
    func updateViews() {
        actionAlertButton?.setState()
    }
}
