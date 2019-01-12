//
//  CharacterDetailViewController.swift
//  Calculator
//
//  Created by Diego Fernando Cuesta Arevalo on 1/11/19.
//  Copyright © 2019 Diego Fernando Cuesta Arevalo. All rights reserved.
//

import UIKit

class MarvelDetailViewController: UIViewController {
    
    @IBOutlet var titleLb: UILabel!
    @IBOutlet var descriptionLb: UILabel!
    @IBOutlet var image: UIImageView!

    lazy var viewModel: MarvelDetailViewModel = {
        return MarvelDetailViewModel( )
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setDataBinding()
    }
    
    func setDataBinding(){
        viewModel.updateDetail = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.titleLb.text = strongSelf.viewModel.tittle
            strongSelf.descriptionLb.text = strongSelf.viewModel.description
            strongSelf.image.af_setImage(withURL: strongSelf.viewModel.getLandscapeUrlImage())
        }
        viewModel.updateDetail?()
    }
    
}
