//
//  CFProfileViewController.swift
//  CleverFuze
//
//  Created by Anilkumar on 08/08/22.
//

import UIKit
import Alamofire
import Kingfisher

class CFProfileViewController: CFBaseViewController, UITextFieldDelegate{
    
    lazy var namelbl : UILabel = {
        let namelbl = UILabel()
        namelbl.text = "Name:*"
        namelbl.font = UIFont.boldSystemFont(ofSize: 18)
        namelbl.translatesAutoresizingMaskIntoConstraints = false
        return namelbl
    }()
    
    lazy var validation : UILabel = {
        let validation = UILabel()
        validation.textColor = .red
        validation.translatesAutoresizingMaskIntoConstraints = false
        return validation
    }()
    
    lazy var nametext : UITextField = {
        let nametext = UITextField()
        nametext.placeholder = "Clever"
        nametext.text = StrongboxController.profileData?.name
        nametext.borderStyle = .bezel
        nametext.backgroundColor = .systemGray6
        nametext.layer.cornerRadius = 8
        nametext.translatesAutoresizingMaskIntoConstraints = false
        nametext.delegate = self
        return nametext
    }()
    lazy var emaillbl : UILabel = {
        let emaillbl = UILabel()
        emaillbl.text = "E-mail Address:"
        emaillbl.font = UIFont.boldSystemFont(ofSize: 18)
        emaillbl.translatesAutoresizingMaskIntoConstraints = false
        return emaillbl
    }()
    
    lazy var emailtextfield : UITextField = {
        let emailtextfield = UITextField()
        emailtextfield.translatesAutoresizingMaskIntoConstraints = false
        emailtextfield.text = StrongboxController.profileData?.email
        emailtextfield.borderStyle = .bezel
        emailtextfield.backgroundColor = .systemGray5
        emailtextfield.layer.cornerRadius = 8
        emailtextfield.layer.masksToBounds = true
        emailtextfield.isEnabled = false
        emailtextfield.delegate = self
        return emailtextfield
    }()
    
    lazy var submitbtn : UIButton = {
        let submitbutton = UIButton()
        submitbutton.setTitle("Submit", for: .normal)
        submitbutton.backgroundColor = .systemYellow
        submitbutton.setTitleColor(.black, for: .normal)
        submitbutton.layer.cornerRadius = .ratioHeightBasedOniPhoneX(15)
        submitbutton.layer.masksToBounds = true
        submitbutton.tag = 1
        submitbutton.translatesAutoresizingMaskIntoConstraints = false
        submitbutton.addTarget(self, action: #selector(self.submitaction), for: .touchUpInside)
        return submitbutton
    }()
    
    
    lazy var profilrimg : UIImageView = {
        let profilrimg = UIImageView()
        profilrimg.translatesAutoresizingMaskIntoConstraints = false
        profilrimg.layer.borderWidth = 1.0
        profilrimg.layer.masksToBounds = false
        profilrimg.layer.borderColor = UIColor.white.cgColor
        profilrimg.layer.cornerRadius = .ratioHeightBasedOniPhoneX(60)
        profilrimg.clipsToBounds = true
        profilrimg.contentMode = .scaleAspectFill
        profilrimg.kf.setImage(with: URL(string: StrongboxController.profileData?.profile ?? ""))
        return profilrimg
    }()
    
    lazy var imgbtn : UIButton = {
        let imgbtn = UIButton()
        imgbtn.translatesAutoresizingMaskIntoConstraints = false
        imgbtn.setImage(UIImage(systemName: "camera"), for: .normal)
        imgbtn.layer.borderWidth = 1.0
        imgbtn.layer.masksToBounds = false
        imgbtn.layer.borderColor = UIColor.white.cgColor
        imgbtn.layer.cornerRadius = .ratioHeightBasedOniPhoneX(17.5)
        imgbtn.addTarget(self, action: #selector(imageButton(_:)), for: .touchUpInside)
        imgbtn.clipsToBounds = true
        return imgbtn
    }()
    
    lazy var centerview: UIView = {
        let centerview = UIView()
        centerview.backgroundColor = UIColor(white: 1, alpha: 0.6)
        centerview.layer.cornerRadius = 20
        centerview.translatesAutoresizingMaskIntoConstraints = false
        return centerview
        
    }()
        
    lazy var profileController: CFProfileController! = CFProfileController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setView()
        self.addHeaderView()
        self.profileController.delegate = self
        CFProfileController.getProfileData()
        
        navigationItem.hidesBackButton = true
        self.enableBackButton()

        self.view.backgroundColor = .white

        self.view.addSubview(self.centerview)
        self.centerview.addSubview(self.profilrimg)
        self.centerview.addSubview(self.imgbtn)
        self.centerview.addSubview(self.namelbl)
        self.centerview.addSubview(self.nametext)
        self.centerview.addSubview(self.emaillbl)
        centerview.addSubview(self.emailtextfield)
        self.centerview.addSubview(self.submitbtn)
        self.centerview.addSubview(self.validation)
        
        
        NSLayoutConstraint.activate([
            
            self.centerview.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: .ratioHeightBasedOniPhoneX(20)),
            self.centerview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .ratioWidthBasedOniPhoneX(15)),
            self.centerview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: .ratioWidthBasedOniPhoneX(-15)),
                
            self.profilrimg.topAnchor.constraint(equalTo: centerview.topAnchor, constant: .ratioHeightBasedOniPhoneX(30)),
            self.profilrimg.centerXAnchor.constraint(equalTo: centerview.centerXAnchor),
            self.profilrimg.heightAnchor.constraint(equalToConstant: .ratioHeightBasedOniPhoneX(120)),
            self.profilrimg.widthAnchor.constraint(equalToConstant: .ratioHeightBasedOniPhoneX(120)),
            
            self.imgbtn.bottomAnchor.constraint(equalTo: profilrimg.bottomAnchor),
            self.imgbtn.trailingAnchor.constraint(equalTo: profilrimg.trailingAnchor),
            self.imgbtn.heightAnchor.constraint(equalToConstant: .ratioHeightBasedOniPhoneX(35)),
            self.imgbtn.widthAnchor.constraint(equalToConstant: .ratioHeightBasedOniPhoneX(35)),

            self.namelbl.topAnchor.constraint(equalTo: profilrimg.bottomAnchor, constant: .ratioHeightBasedOniPhoneX(50)),
            self.namelbl.leadingAnchor.constraint(equalTo: centerview.leadingAnchor, constant: .ratioWidthBasedOniPhoneX(32)),
            self.namelbl.trailingAnchor.constraint(equalTo: centerview.trailingAnchor, constant: .ratioWidthBasedOniPhoneX(-100)),
            self.namelbl.bottomAnchor.constraint(equalTo: nametext.topAnchor, constant: .ratioHeightBasedOniPhoneX(-10)),

            self.nametext.topAnchor.constraint(equalTo: namelbl.bottomAnchor, constant: .ratioHeightBasedOniPhoneX(50)),
            self.nametext.leadingAnchor.constraint(equalTo: namelbl.leadingAnchor),
            self.nametext.trailingAnchor.constraint(equalTo: centerview.trailingAnchor, constant: .ratioWidthBasedOniPhoneX(-32)),
            self.nametext.bottomAnchor.constraint(equalTo: validation.topAnchor, constant: .ratioHeightBasedOniPhoneX(-10)),
            
            self.validation.leadingAnchor.constraint(equalTo: centerview.leadingAnchor, constant: .ratioWidthBasedOniPhoneX(32)),
            self.validation.trailingAnchor.constraint(equalTo: centerview.trailingAnchor, constant: .ratioWidthBasedOniPhoneX(-100)),
            self.validation.bottomAnchor.constraint(equalTo: emaillbl.topAnchor, constant: .ratioHeightBasedOniPhoneX(-7)),
            
            self.emaillbl.topAnchor.constraint(equalTo: nametext.bottomAnchor, constant: .ratioHeightBasedOniPhoneX(10)),
            self.emaillbl.leadingAnchor.constraint(equalTo: centerview.leadingAnchor, constant: .ratioWidthBasedOniPhoneX(32)),
            self.emaillbl.trailingAnchor.constraint(equalTo: centerview.trailingAnchor, constant: .ratioWidthBasedOniPhoneX(-100)),
            self.emaillbl.bottomAnchor.constraint(equalTo: emailtextfield.topAnchor, constant: .ratioHeightBasedOniPhoneX(-10)),
            
            self.emailtextfield.topAnchor.constraint(equalTo: emaillbl.bottomAnchor, constant: .ratioHeightBasedOniPhoneX(10)),
            self.emailtextfield.leadingAnchor.constraint(equalTo: centerview.leadingAnchor, constant: .ratioWidthBasedOniPhoneX(32)),
            self.emailtextfield.trailingAnchor.constraint(equalTo: centerview.trailingAnchor, constant: .ratioWidthBasedOniPhoneX(-32)),
            self.emailtextfield.bottomAnchor.constraint(equalTo: submitbtn.topAnchor, constant: .ratioHeightBasedOniPhoneX(-35)),
            
            self.submitbtn.topAnchor.constraint(equalTo: emailtextfield.bottomAnchor, constant: .ratioHeightBasedOniPhoneX(30)),
            self.submitbtn.leadingAnchor.constraint(equalTo: centerview.leadingAnchor, constant: .ratioWidthBasedOniPhoneX(110)),
            self.submitbtn.trailingAnchor.constraint(equalTo: centerview.trailingAnchor, constant: .ratioWidthBasedOniPhoneX(-110)),
            self.submitbtn.bottomAnchor.constraint(equalTo: self.centerview.bottomAnchor, constant: .ratioHeightBasedOniPhoneX(-20)),
            self.submitbtn.heightAnchor.constraint(equalToConstant: .ratioHeightBasedOniPhoneX(40)),
            self.submitbtn.widthAnchor.constraint(equalToConstant: .ratioWidthBasedOniPhoneX(70)),
            
            
        ])
        
    }
    @objc func imageButton(_ sender : UIButton){
        
        let vc = UIAlertController(title: "select image", message: "select images from?", preferredStyle: .actionSheet)
        let camerabtn = UIAlertAction(title: "Camera", style: .default) {[weak self] (_) in
            self?.showImagePicker(selectedSource: .camera)
            
        }
        let librarybtn = UIAlertAction(title: "Library", style: .default) {[weak self] (_) in
            self?.showImagePicker(selectedSource: .photoLibrary)
            
        }
        
        
        let cancelbtn = UIAlertAction(title: "Cancel", style: .cancel,handler: nil)
        vc.addAction(camerabtn)
        vc.addAction(librarybtn)
        vc.addAction(cancelbtn)
        self.present(vc, animated: true,completion: nil)
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nametext{
            nametext.isHidden = false
            
            nametext.resignFirstResponder()
        }
        return true
    }
    
    @objc func submitaction(_ sender : UIButton!) {
        
        guard let data = self.profilrimg.image?.jpegData(compressionQuality: 0.5) else {
            self.showErrorAlert("Please select the profile picture", autoDissmiss: true)
            return
        }
        
        guard let name = nametext.text, !name.isEmpty else {
            self.showErrorAlert("Please enter the name", autoDissmiss: true)
            return
        }
        self.loadingView.setLoadingScreen(view: self.view)
        CFCommunicationController.imageUpload(.editProfile, method: .post, parameter: ["userId": StrongboxController.userData?.userID ?? 0,
                                                                                       "userPropic": data,
                                                                                       "userName": name], success: { (data, string, statusCode) in
            DispatchQueue.main.async { [weak self] in
                self?.showErrorAlert(title: "Profile updated successfully", string, autoDissmiss: true)
                CFProfileController.getProfileData()
                self?.loadingView.removeLoadingScreen()
            }
        })
    }
    
    @objc func homeButton(_ sender : UIButton) {
        let vc = CFHomeDashBaordViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension CFProfileViewController{
    func setView(){
        self.headerView.labelTitle.text = "Profile"
        self.headerView.rightButton.isHidden = true
    }
}

extension CFProfileViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func showImagePicker(selectedSource: UIImagePickerController.SourceType){
        guard UIImagePickerController.isSourceTypeAvailable(selectedSource)else{
            print("not available")
            return
        }
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = selectedSource
        imagePickerController.allowsEditing = true
        self.present(imagePickerController, animated:true , completion: nil )
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let seletedimage = info[.originalImage] as? UIImage{
            profilrimg.image = seletedimage
        }
        else{
            print("Image not found")
        }
        picker.dismiss(animated: true,completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension CFProfileViewController {
    
    override func leftButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension CFProfileViewController {
    
    override func apiSucess() {
        DispatchQueue.main.async { [weak self] in
            self?.profilrimg.kf.setImage(with: URL(string: (StrongboxController.profileData?.profile ?? "")))
            self?.nametext.text = StrongboxController.profileData?.name ?? ""
        }
    }
    
    override func apiFailure(_ error: String) {
        
    }
    
}
