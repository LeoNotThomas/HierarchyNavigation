//
//  InsetLabel.swift
//  OPPC
//
//  Created by Thomas Leonhardt on 03.08.18.
//  Copyright © 2018 PROMOS Consult. All rights reserved.
//

import UIKit

class InsetLabel: UILabel {
	@objc var topInset = CGFloat(0)
	@objc var bottomInset = CGFloat(0)
	@objc var leftInset = CGFloat(8)
	@objc var rightInset = CGFloat(8)
	
	typealias RoundCorners = (corners: UIRectCorner, radius: CGFloat)
	var roundCorners: RoundCorners?
	
	override func drawText(in rect: CGRect) {
		let insets: UIEdgeInsets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
		super.drawText(in: rect.inset(by: insets))
	}
	
	override public var intrinsicContentSize: CGSize {
		var intrinsicSuperViewContentSize = super.intrinsicContentSize
		intrinsicSuperViewContentSize.height += topInset + bottomInset
		intrinsicSuperViewContentSize.width += leftInset + rightInset
		return intrinsicSuperViewContentSize
	}
}

extension InsetLabel {
	func height(width: CGFloat) -> CGFloat {
		let label = InsetLabel(frame: CGRect(x: 0, y: 0, width: width - (leftInset + rightInset), height: CGFloat.greatestFiniteMagnitude))
		label.topInset = self.topInset
		label.bottomInset = self.bottomInset
		label.leftInset = self.leftInset
		label.rightInset = self.rightInset
		label.numberOfLines = self.numberOfLines
		label.lineBreakMode = self.lineBreakMode
		label.font = self.font
		label.text = self.text
		label.sizeToFit()
		
		return label.frame.height + topInset + bottomInset
	}
}
