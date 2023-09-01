//
//  ListMainPage.swift
//  youNature Project
//
//  Created by HARSHID PATEL on 28/08/23.
//

import UIKit

class ListMainPage: UIViewController{
    
    @IBOutlet weak var emptyImage: UIImageView!
    @IBOutlet weak var emptyLable: UILabel!
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var addTableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    
    var listOfArr: [List] = []
    var list: List!
    var indexPath: IndexPath!
    var indax = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSet()
        buttonView.layer.cornerRadius = buttonView.frame.size.width/2
        buttonView.layer.shadowColor = UIColor.gray.cgColor
        buttonView.layer.shadowOpacity = 4.4
        buttonView.layer.shadowRadius = 6.0
        
    }
    
    func tableViewSet(){
        addTableView.register(UINib(nibName: "listTableViewCell", bundle: nil), forCellReuseIdentifier: "listTableViewCell")
        addTableView.delegate = self
        addTableView.dataSource = self
        addTableView.separatorStyle = .none
    }
    
    func alertAction(with indexPath: IndexPath){
        let alert = UIAlertController(title: "Are you sure", message: "You want to remove this list", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .default))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive,handler: { [self] _ in
            listOfArr.remove(at: indexPath.row)
            addTableView.reloadData()
        }))
        
        present(alert, animated: true)

    }
    
    @IBAction func addListButtonAction(_ sender: Any) {
        let navigate = storyboard?.instantiateViewController(identifier: "detailsPage") as! detailsPage
        navigate.delegate = self
        present(navigate, animated: true)
    }
    
}

// TABLE VIEW

extension ListMainPage: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listTableViewCell") as! listTableViewCell
        let arr = listOfArr[indexPath.row]
        cell.mainImage.image = arr.image
        cell.nameLb.text = arr.city
        cell.countryLb.text = arr.country
        cell.menuButton.tag = indexPath.row
        cell.indexPath = indexPath
        cell.delegate = self
        self.indexPath = indexPath
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            alertAction(with: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let navigate = storyboard?.instantiateViewController(identifier: "detailsPage") as! detailsPage
        addButton.isHidden = true
        navigate.button = true
        navigate.delegate = self
        navigate.image = listOfArr[indexPath.row].image
        navigate.placeName = listOfArr[indexPath.row].place
        navigate.CountryName = listOfArr[indexPath.row].country
        navigate.cityName = listOfArr[indexPath.row].city
        navigate.placeRating = listOfArr[indexPath.row].plaseRating
        navigate.location = listOfArr[indexPath.row].location
        navigate.index = indexPath.row
        self.indexPath = indexPath
        present(navigate, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

// PROTOCOL

extension ListMainPage: AddListVcDelegate{
    
    func passMyList(with list: List) {
        addButton.isHidden = false
        emptyImage.isHidden = true
        emptyLable.isHidden = true
        
        if listOfArr.isEmpty {
            listOfArr.append(list)
            addTableView.reloadData()
        } else {
            if list.index == indexPath.row {
                listOfArr[indexPath.row] = list
                addTableView.reloadData()
            } else {
                listOfArr.append(list)
                addTableView.reloadData()
            }
        }
    }
    
    func setButtonState() {
        addButton.isHidden = false
    }
    
}

extension ListMainPage: AddListTableViewCellDelegate{
    func editlist(with index: IndexPath) {
        let navigate = storyboard?.instantiateViewController(identifier: "detailsPage") as! detailsPage
        addButton.isHidden = true
        navigate.button = true
        navigate.delegate = self
        navigate.image = listOfArr[indexPath.row].image
        navigate.placeName = listOfArr[indexPath.row].place
        navigate.CountryName = listOfArr[indexPath.row].country
        navigate.cityName = listOfArr[indexPath.row].city
        navigate.placeRating = listOfArr[indexPath.row].plaseRating
        navigate.location = listOfArr[indexPath.row].location
        navigate.index = indexPath.row
        self.indexPath = index
        present(navigate, animated: true)
    }
    
    func deleteList(with index: IndexPath) {
        alertAction(with: index)
    }
}
