//
//  EmptyStateView.swift
//  WeatherApp
//
//  Created by Tufyx on 18/06/2017.
//  Copyright © 2017 tufyx. All rights reserved.
//

import Foundation
import UIKit

class EmptyStateView: UIView {
    
    @IBOutlet weak var emptyIcon: UIImageView!
    @IBOutlet weak var emptyTitleLabel: UILabel!
    @IBOutlet weak var emptySubtitleLabel: UILabel!
    
    var view: UIView!
    
    func xibSetupWithName(_ name: String) {
        view = loadViewFromNibWithName(name)
        view.frame = bounds
        
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        addSubview(view)
    }
    
    func loadViewFromNibWithName(_ name: String) -> UIView {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: name, bundle: bundle)
        let view = (nib.instantiate(withOwner: self, options: nil)[0] as? UIView)!
        
        return view
    }
    
    var image: UIImage? = UIImage(named: "umbrella") {
        didSet {
            updateUI()
        }
    }
    
    var emptyTitle: String? = "" {
        didSet {
            updateUI()
        }
    }
    
    var emptySubtitle: String? = "" {
        didSet {
            updateUI()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetupWithName("EmptyStateView")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetupWithName("EmptyStateView")
    }
    
    fileprivate func updateUI() {
        emptyIcon.image = image
        emptyIcon.contentMode = .scaleAspectFit
        emptyTitleLabel.text = emptyTitle
        emptySubtitleLabel.text = emptySubtitle
    }
    
}

