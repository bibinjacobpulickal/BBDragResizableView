//
//  DraggableResizableView.swift
//  AppKit Cocoa Resizable NSView
//
//  Created by Bibin Jacob Pulickal on 11/06/19.
//  Copyright © 2019 Bibin Jacob Pulickal. All rights reserved.
//

import Cocoa

class DraggableResizableView: NSView {

    private let resizableArea   = CGFloat(2)
    private var draggedPoint    = CGPoint.zero

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        backgroundColor = .red
    }

    override func updateTrackingAreas() {
        super.updateTrackingAreas()
        trackingAreas.forEach { area in
            removeTrackingArea(area)
        }
        addTrackingRect(bounds)
    }

    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func mouseEntered(with event: NSEvent) {
        super.mouseEntered(with: event)
        borderColor     = .white
        borderWidth     = resizableArea
    }

    override func mouseExited(with event: NSEvent) {
        super.mouseExited(with: event)
        NSCursor.arrow.set()
        borderColor     = .clear
        borderWidth     = 0
    }

    override func mouseDown(with event: NSEvent) {
        super.mouseDown(with: event)
        let locationInView = convert(event.locationInWindow, from: nil)
        draggedPoint            = locationInView
    }

    override func mouseUp(with event: NSEvent) {
        super.mouseUp(with: event)
        draggedPoint = .zero
    }

    override func mouseMoved(with event: NSEvent) {
        super.mouseMoved(with: event)
        let locationInView = convert(event.locationInWindow, from: nil)
        cursorBorderPosition(locationInView)
    }

    override func mouseDragged(with event: NSEvent) {
        super.mouseDragged(with: event)
        borderWidth                     = resizableArea
        let locationInView              = convert(event.locationInWindow, from: nil)
        let horizontalDistanceDragged   = locationInView.x - draggedPoint.x
        let verticalDistanceDragged     = locationInView.y - draggedPoint.y
        let cursorPosition              = cursorBorderPosition(draggedPoint)
        if cursorPosition != .none {
            let drag    = CGPoint(x: horizontalDistanceDragged, y: verticalDistanceDragged)
            if checkIfBorder(cursorPosition, touchesSuperviewBorderWithPadding: 12, andDraggedOutward: drag) {
                return
            }
        }
        switch cursorPosition {
        case .top:
            size.height += verticalDistanceDragged
            draggedPoint = locationInView
        case .left:
            origin.x    += horizontalDistanceDragged
            size.width  -= horizontalDistanceDragged
        case .bottom:
            origin.y    += verticalDistanceDragged
            size.height -= verticalDistanceDragged
        case .right:
            size.width  += horizontalDistanceDragged
            draggedPoint = locationInView
        case .none:
            origin.x    += locationInView.x - draggedPoint.x
            origin.y    += locationInView.y - draggedPoint.y
            repositionView(withPadding: 12)
        }
    }

    @discardableResult
    func cursorBorderPosition(_ locationInView: CGPoint) -> BorderPosition {
        if locationInView.x < resizableArea {
            NSCursor.resizeLeftRight.set()
            return .left
        } else if locationInView.x > bounds.width - resizableArea {
            NSCursor.resizeLeftRight.set()
            return .right
        } else if locationInView.y < resizableArea {
            NSCursor.resizeUpDown.set()
            return .bottom
        } else if locationInView.y > bounds.height - resizableArea {
            NSCursor.resizeUpDown.set()
            return .top
        } else {
            NSCursor.arrow.set()
            return .none
        }
    }

    enum BorderPosition {
        case top, left, bottom, right, none
    }

    private func checkIfBorder(_ border: BorderPosition,
                               touchesSuperviewBorderWithPadding padding: CGFloat,
                               andDraggedOutward drag: CGPoint) -> Bool {
        if border == .left && frame.minX <= padding && drag.x < 0 {
            return true
        }
        if border == .bottom && frame.minY <= padding && drag.y < 0 {
            return true
        }
        guard let superView = superview else { return false }
        if border == .right && frame.maxX >= superView.frame.maxX - padding && drag.x > 0 {
            return true
        }
        if border == .top && frame.maxY >= superView.frame.maxY - padding && drag.y > 0 {
            return true
        }
        return false
    }

    private func repositionView(withPadding padding: CGFloat) {
        if frame.minX < padding {
            origin.x    = padding
        }
        if frame.minY < padding {
            origin.y    = padding
        }
        guard let superView = superview else { return }
        if frame.maxX > superView.frame.maxX - padding {
            origin.x    = superView.frame.maxX - frame.width - padding
        }
        if frame.maxY > superView.frame.maxY - padding {
            origin.y    = superView.frame.maxY - frame.height - padding
        }
    }
}
