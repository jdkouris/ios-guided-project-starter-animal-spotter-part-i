//
//  AnimalDetailViewController.swift
//  AnimalSpotter
//
//  Created by John Kouris on 9/11/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class AnimalDetailViewController: UIViewController {
    
    @IBOutlet weak var spottedOnLabel: UILabel!
    @IBOutlet weak var coordinatesLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var animalImageView: UIImageView!
    
    var apiController: APIController?
    var animalName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getDetails()
    }
    
    private func getDetails() {
        guard let apiController = apiController, let animalName = animalName else { return }
        apiController.fetchDetails(for: animalName) { (result) in
            if let animal = try? result.get() {
                DispatchQueue.main.async {
                    self.updateViews(with: animal)
                }
            }
        }
    }
    
    private func updateViews(with animal: Animal) {
        title = animal.name
        descriptionLabel.text = animal.description
        coordinatesLabel.text = "lat: \(animal.latitude), long: \(animal.longitude)"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        
        spottedOnLabel.text = dateFormatter.string(from: animal.timeSeen)
    }
    
}
