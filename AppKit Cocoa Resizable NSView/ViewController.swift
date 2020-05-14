//
//  ViewController.swift
//  AppKit Cocoa Resizable NSView
//
//  Created by Bibin Jacob Pulickal on 06/06/19.
//  Copyright © 2019 Bibin Jacob Pulickal. All rights reserved.
//

import Cocoa
import AutoLayoutProxy

class ViewController: NSViewController {

    private let draggableResizableView = DraggableResizableView()

    override func loadView() {
        view        = NSView()
        view.size >= 500
        view.addSubview(NSButton(title: "RESET", target: self, action: #selector(resetFrame))) {
            $0.centerX == $1.centerX
        }
        view.addSubview(draggableResizableView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        perform(#selector(resetFrame), with: nil, afterDelay: 1)
    }

    @objc func resetFrame() {
        let width                               = view.bounds.width / 5
        let height                              = view.bounds.height / 5
        let x                                   = (view.bounds.width - width) * 0.5
        let y                                   = (view.bounds.height - height) * 0.5
        draggableResizableView.frame            = CGRect(x: x, y: y, width: width, height: height)
        draggableResizableView.autoresizingMask = [.minXMargin, .minYMargin, .maxXMargin, .maxYMargin]
    }
}
