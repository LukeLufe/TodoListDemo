//
//  MainViewController.swift
//  TodoListDemo
//
//  Created by Luke on 2022/3/29.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Input IBOutlet
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var inputErrorLabel: UILabel!
    @IBOutlet weak var inputButton: UIButton!
    @IBOutlet weak var inputViewBottomLayout: NSLayoutConstraint!
    
    let indicatorView = UIActivityIndicatorView(style: .large)
    
    // MARK: - Page IBOutlet
    
    @IBOutlet weak var pageSegmentedControl: UISegmentedControl!
    @IBOutlet weak var pageScrollView: UIScrollView!
    
    // MARK: - Children Vc
    
    lazy var UnFinishVc: UnFinishTableViewController? = children.compactMap { $0 as? UnFinishTableViewController }.first
    lazy var finishVc: FinishTableViewController? = children.compactMap { $0 as? FinishTableViewController }.first
    
    // MARK: - View Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        updateUI(.normal)
        configDelegate()
        configKeyboardNotify()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        pageSegmentedControl.configUnderlineSelectedSegment(selectColor: .systemBlue)
        indicatorView.frame = inputButton.bounds
    }
    
    private func configUI() {
        titleLabel.attributedText = titleLabel.text?.insertRedStar(at: .first)
//        pageSegmentedControl.configUnderlineSelectedSegment(selectColor: .systemBlue)
        indicatorView.hidesWhenStopped = true
        inputButton.addSubview(indicatorView)
//        indicatorView.frame = inputButton.bounds
    }
    
    private func updateUI(_ state: InputState) {
        switch state {
        case .normal:
            inputTextField.configBorderColor(UIColor.clear.cgColor)
            inputErrorLabel.isHidden = true
            inputButton.isEnabled = true
            inputTextField.isEnabled = true
            inputButton.setTitle("送出", for: .normal)
            indicatorView.stopAnimating()
        case .errored:
            inputTextField.configBorderColor(UIColor.red.cgColor)
            inputErrorLabel.isHidden = false
            inputButton.isEnabled = false
            inputTextField.isEnabled = true
        case .submiting:
            inputButton.isEnabled = false
            inputTextField.isEnabled = false
            inputButton.setTitle("", for: .normal)
            indicatorView.startAnimating()
        }
    }
    
    private func configDelegate() {
        inputTextField.delegate = self
        pageScrollView.delegate = self
        UnFinishVc?.delegate = self
    }
    
    private func configKeyboardNotify() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShown),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHidden),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardShown(_ notification: Notification) {
        guard let keyboard = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        let keyboardSize = keyboard.cgRectValue
        inputViewBottomLayout.constant = keyboardSize.height
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.2, delay: 0.0) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardHidden(_ sender: Notification) {
        inputViewBottomLayout.constant = 0
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.2, delay: 0.0) {
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: Enum
    
    enum InputState {
        case normal, errored, submiting
    }
    
    // MARK: - Input TextField Edit Change
    
    @IBAction func inputTextFieldEditChanged(_ sender: UITextField) {
        guard let text = sender.text, !text.isEmpty else {
            updateUI(.errored)
            return
        }
        updateUI(.normal)
    }
    
    // MARK: - Input Button Pressed
    
    @IBAction func inputBtnPressed(_ sender: Any) {
        guard let text = inputTextField.text, !text.isEmpty else {
            updateUI(.errored)
            return
        }
        updateUI(.submiting)
        let manager = WorkManager()
        manager.submitWork(text: text) { [weak self] work, error in
            self?.updateUI(.normal)
            guard let work = work, error == nil else {
                print("inputBtnPressed \(String(describing: error))")
                return
            }
            self?.UnFinishVc?.unFinishData.append(work)
            self?.UnFinishVc?.updateUI()
            self?.inputTextField.text = nil
            if let sender = self?.pageSegmentedControl {
                sender.selectedSegmentIndex = 0
                self?.pageSegmentedDidChanged(sender)
            }
        }
    }

    // MARK: - Page SegmentedController Did Change
    
    @IBAction func pageSegmentedDidChanged(_ sender: UISegmentedControl) {
        sender.changeUnderlinePosition()
        let index = sender.selectedSegmentIndex
        let contentOffsetX = pageScrollView.bounds.width * CGFloat(index)
        let offsetX = CGPoint(x: contentOffsetX, y: 0)
        pageScrollView.setContentOffset(offsetX, animated: true)
        childrenUpdateUI(at: index)
    }
    
    private func childrenUpdateUI(at index: Int) {
        if index == 0 {
            UnFinishVc?.updateUI()
        } else {
            finishVc?.updateUI()
        }
    }
    
}

extension MainViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

extension MainViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        pageSegmentedControl.selectedSegmentIndex = index
        pageSegmentedControl.changeUnderlinePosition()
        childrenUpdateUI(at: index)
    }
    
}

// MARK: - Finish Work

extension MainViewController {
    
    func finishWork(_ work: Work) {
        finishVc?.finishData.append(work)
        finishVc?.updateUI()
    }
    
}
