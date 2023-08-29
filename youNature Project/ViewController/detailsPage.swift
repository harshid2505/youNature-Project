//
//  detailsPage.swift
//  youNature Project
//
//  Created by HARSHID PATEL on 28/08/23.
//

import UIKit

protocol AddListVcDelegate: AnyObject {
    func passMyList(with list: List)
    func setButtonState()
}

class detailsPage: UIViewController {
    
    @IBOutlet weak var listView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var placeTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var ratingTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var selectImageButton: UIButton!
    
    var list: List!
    var placeName = String()
    var CountryName = String()
    var cityName = String()
    var placeRating = String()
    var location = String()
    var image = UIImage()
    var button: Bool = false
    var index = -1
    
    weak var delegate: AddListVcDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
        setButton()
    }
    
    func setButton(){
        view.alpha = 0
        listView.layer.cornerRadius = 10
        imageView.layer.borderWidth = 3
        imageView.layer.cornerRadius = 10
        imageView.layer.borderColor = UIColor.systemGray.cgColor
        cancelButton.layer.cornerRadius = 10
        cancelButton.layer.borderWidth = 2
        cancelButton.layer.borderColor = UIColor.systemGray.cgColor
        addButton.layer.cornerRadius = 10
        addButton.layer.borderWidth = 2
        addButton.layer.borderColor = UIColor.systemGray.cgColor
    }
    
    func setData(){
        [placeTextField,countryTextField,cityTextField,placeTextField,ratingTextField,locationTextField].forEach { textField in
            textField?.delegate = self
        }
        
        if button{
            addButton.setTitle("Edit", for: .normal)
            selectImageButton.layer.borderWidth = 0
            selectImageButton.setTitleColor(.white, for: .normal)
            selectImageButton.setTitle("Select New Image", for: .normal)
            imageView.image = image
            placeTextField.text = placeName
            countryTextField.text = CountryName
            cityTextField.text = cityName
            ratingTextField.text = placeRating
            locationTextField.text = location
        }
        else{
            addButton.setTitle("Add", for: .normal)
        }
    }
    
    private func getImageGallery() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    private func getImageCamera() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePiker(){
        let alert = UIAlertController(title: "Select Image.", message: "You can select image with photos or camera.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Photos", style: .default,handler: {_ in
            self.getImageGallery()
        }))
        alert.addAction(UIAlertAction(title: "Camera", style: .default,handler: {_ in
            self.getImageCamera()
        }))
        present(alert, animated: true)
    }
    
    private func alertAction() {
        let alert = UIAlertController(title: "Please Enter Detailes.", message: "Please fill a all Details.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive))
        present(alert, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.5, delay: 0,options: .curveLinear) {
            self.view.alpha = 1
        }
    }
    
    func checkData(){
        if imageView.image == nil{
            alertAction()
        }
        else if placeTextField.text == ""{
            alertAction()
        }
        else if countryTextField.text == ""{
            alertAction()
        }
        else if cityTextField.text == ""{
            alertAction()
        }
        else if ratingTextField.text == ""{
            alertAction()
        }
        else if locationTextField.text == ""{
            alertAction()
        }
        else{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.dismiss(animated: true) { [self] in
                    list = List(image: imageView.image!,place: placeName, country: CountryName, city: cityName, plaseRating: placeRating, location: location,index: index)
                    print(CountryName)
                    delegate?.passMyList(with: list)
                }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: false)
    }
    
    @IBAction func selectImageButtonAction(_ sender: UIButton) {
        imagePiker()
    }
    
    @IBAction func cancelButtonAction(_ sender: UIButton) {
        delegate?.setButtonState()
    }
    
    @IBAction func addButtonAction(_ sender: UIButton) {
        checkData()
    }
    
}

// Text Field

extension detailsPage: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case placeTextField:
            placeName = ""
            
        case countryTextField:
            CountryName = ""
            
        case cityTextField:
            cityName = ""
            
        case ratingTextField:
            placeRating = ""
            
        case cityTextField:
            cityName = ""
            
        case locationTextField:
            location = ""
            
        default:
            break
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
            
        case placeTextField:
            if let text = textField.text {
                placeName = text
            }
            
        case countryTextField:
            if let text = textField.text {
                CountryName = text
            }
            
        case cityTextField:
            if let text = textField.text {
                cityName = text
            }
            
        case ratingTextField:
            if let text = textField.text {
                placeRating = text
            }
            
        case locationTextField:
            if let text = textField.text {
                location = text
            }
            
        default:
            break
        }
    }
}

// Image Piker

extension detailsPage: UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    
    func imagePickerController(_ piker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        if let selectedImage = info[.originalImage] as? UIImage {
            imageView.image = selectedImage
            selectImageButton.layer.borderWidth = 0
            selectImageButton.layer.borderColor = UIColor.clear.cgColor
            selectImageButton.setTitleColor(.white, for: .normal)
            selectImageButton.setTitle("Select New Image", for: .normal)
            
            piker.dismiss(animated: true,completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
