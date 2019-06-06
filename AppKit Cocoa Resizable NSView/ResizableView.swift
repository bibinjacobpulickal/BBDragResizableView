//
//  ResizableView.swift
//  AppKit Cocoa Resizable NSView
//
//  Created by Bibin Jacob Pulickal on 06/06/19.
//  Copyright © 2019 Bibin Jacob Pulickal. All rights reserved.
//

import Cocoa

class ResizableView: NSView {

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setBackgroundColor(.red)
    }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        addTrackingRect(dirtyRect)
    }

    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func mouseEntered(with event: NSEvent) {
        super.mouseEntered(with: event)
        borderColor     = .white
        borderWidth     = 4
        setBackgroundColor(.green)
    }

    override func mouseExited(with event: NSEvent) {
        super.mouseExited(with: event)
        borderWidth     = 0
        setBackgroundColor(.red)
        NSCursor.arrow.set()
    }

    override func mouseMoved(with event: NSEvent) {
        super.mouseMoved(with: event)
        setBackgroundColor(.green)
        let locationInView = convert(event.locationInWindow, from: nil)
        if locationInView.x < 4 || locationInView.x > bounds.width - 4 {
            NSCursor.resizeLeftRight.set()
        } else if locationInView.y < 4 || locationInView.y > bounds.height - 4 {
            NSCursor.resizeUpDown.set()
        } else {
            NSCursor.arrow.set()
            setBackgroundColor(.red)
        }
    }

    override func mouseDragged(with event: NSEvent) {
        super.mouseDragged(with: event)
        let locationInView = convert(event.locationInWindow, from: nil)
        if locationInView.x < 4 || locationInView.x > bounds.width - 4 ||
            locationInView.y < 4 || locationInView.y > bounds.height - 4 {
            setBackgroundColor(.yellow)
        } else {
            setBackgroundColor(.red)
        }
    }
}
