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

    private let resizableView = DraggableResizableView()

    override func loadView() {
        view        = NSView()
        view.size >= 500
        view.addSubview(NSButton(title: "RESET", target: self, action: #selector(resetFrame))) {
            $0.centerX == $1.centerX
        }
        view.addSubview(resizableView)
        resetFrame()
    }

    @objc func resetFrame() {
        resizableView.frame = NSRect(x: 100, y: 200, width: 100, height: 100)
    }
}
