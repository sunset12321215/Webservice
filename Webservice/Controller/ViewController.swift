//
//  ViewController.swift
//  Webservice
//
//  Created by CuongVX-D1 on 6/20/19.
//  Copyright © 2019 CuongVX-D1. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //  MARK: - Outlet
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var jobTextField: UITextField!
    
    //  MARK: - View Life Cycle
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        nameTextField.text = ""
        jobTextField.text = ""
    }
    
    //  MARK: - Networking
    
    private func onPost() {
        let session = URLSession.shared
        let url = URL(string: URLs.post)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Powered by Swift!", forHTTPHeaderField: "X-Powered-By")
        
        let json = [
            "name": "\(nameTextField.text ?? "")",
            "job": "\(jobTextField.text ?? "")"
        ]
        
        let jsonData = try! JSONSerialization.data(withJSONObject: json, options: [])
        
        let task = session.uploadTask(with: request, from: jsonData) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    self.handleServerError(errorMessage: error.debugDescription)
                    return
            }
        }
        task.resume()
        
        guard let userVC = self.storyboard?.instantiateViewController(withIdentifier: "userVC") as? UserTableViewController else { return }
        self.navigationController?.pushViewController(userVC, animated: true)
    }
    
    private func handleServerError(errorMessage: String) {
        let alertController = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func registerButton(_ sender: Any) {
        onPost()
    }
}
