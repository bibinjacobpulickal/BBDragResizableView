//
//  ViewController.swift
//  AppKit Cocoa Resizable NSView
//
//  Created by Bibin Jacob Pulickal on 06/06/19.
//  Copyright © 2019 Bibin Jacob Pulickal. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    override func loadView() {
        view        = NSView()
        let resizableView = ResizableView(frame: NSRect(x: 100, y: 100, width: 100, height: 100))
        view.addSubview(resizableView)
    }
}
