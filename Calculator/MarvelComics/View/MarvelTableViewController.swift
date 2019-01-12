//
//  MarvelTableViewController.swift
//  Calculator
//
//  Created by Diego Fernando Cuesta Arevalo on 1/11/19.
//  Copyright © 2019 Diego Fernando Cuesta Arevalo. All rights reserved.
//

import UIKit

enum TypeList: String {
    case Comic
    case Character
    case Creators
    case Series
    case Events
    case Stories
}

class MarvelTableViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    lazy var viewModel: MarvelTableViewModel = {
        return MarvelTableViewModel( )
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setBindingData()
        viewModel.loadData()
        tableView.accessibilityIdentifier = "testTable"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func setTypeData(type: TypeList){
        viewModel.typeData = type
        navigationItem.title = type.rawValue
    }
    
    func setBindingData(){
        viewModel.updateData = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.tableView.reloadData()
        }
        viewModel.addUpdateData = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.tableView.reloadSections(IndexSet(integer: 1), with: .none)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.MarvelDetailSegue {
            let vc: MarvelDetailViewController = segue.destination as! MarvelDetailViewController

            let info: [String : Any] = sender as! [String : Any]
            let tittle = info["tittle"] as? String
            let description = info["description"] as? String
            let image = info["image"] as? Image
    
            vc.viewModel.setGenericDetail(tittle: tittle!, description: description!, image: image!)
        }
    }
}



// table view Functions
extension MarvelTableViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0  {
            return viewModel.dataSource.count
        } else if section == 1 {
            return 1
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ItemMarvelCell
            let index = indexPath.row
            cell.nameCell?.text = viewModel.getNameCell(index: index)
            if let image = viewModel.getImage(index: index){
                cell.imageCell?.af_setImage(withURL: URL(string: image.getImgSquareUrl() )!)
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "loadCell", for: indexPath) as! ItemLoadViewCell
            return cell
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offset > contentHeight - scrollView.frame.height {
            if !viewModel.isLoadMoreData {
                viewModel.addData()
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var data = [String : Any]()
        data["tittle"] = viewModel.getNameCell(index: indexPath.row)
        data["description"] = viewModel.getDescriptionCell(index: indexPath.row)
        data["image"] = viewModel.getImage(index: indexPath.row)
        performSegue(withIdentifier: Constants.MarvelDetailSegue, sender: data)
    }


}
