//
//  ViewController.swift
//  UITextView
//
//  Created by Pin Lu on 5/28/24.
//

import UIKit

class ViewController: UIViewController {
    
    let textView = UITextView()
    let label = UILabel()
    
    var message = "textViewDidChange is only changing when a full string is ... Stack Overflow https://stackoverflow.com › questions › textviewdidcha... textViewDidChange is only changing when a full string is typed. I want it to check every character ... I have a UITextView that dynamically ..."

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        textView.text = message
        textView.backgroundColor = .lightGray
        textView.isScrollEnabled = false
        textView.sizeToFit()
        
        label.text = "I AM A LABEL"
        label.backgroundColor = .systemPink
        
        view.addSubview(textView)
        view.addSubview(label)
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: textView.trailingAnchor, multiplier: 2),
            textView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            
            label.leadingAnchor.constraint(equalTo: textView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: textView.trailingAnchor),
            label.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 10)
        ])
    }

}

