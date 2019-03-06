//
//  DetailViewController.swift
//  json-demo
//
//  Created by Cooper Jones on 3/6/19.
//  Copyright © 2019 Cooper Jones. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    var imageURL: String?

    @IBOutlet weak var pokemonImage: UIImageView!
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let label = detailDescriptionLabel {
                label.text = detail.name
                loadjson(detail.url)
            }
        }
    }
    
    func loadjson(_ urlPath:String){
        guard let url = URL(string: urlPath)
            else {
                print("url error")
                return
        }
        let session = URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            guard statusCode == 200
                else {
                    print("file download error")
                    return
            }
            //download successful
            print(urlPath)
            print("download complete")
            //parse json asynchronously
            DispatchQueue.main.async {self.parsejson(data!)}
        })
        //must call resume to run session
        session.resume()
    }
    
    func parsejson(_ data: Data){
        do
        {
            let api = try JSONDecoder().decode(PokemonInfo.self, from:
                data)
            print(api.name)
            let urlString = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(api.id).png"
            if let url = URL(string: urlString){
                do {
                    let data = try Data(contentsOf: url)
                    self.pokemonImage.image = UIImage(data:data)
                } catch{
                    print("Error: Issue Loading Sprite")
                }
            }
        }
        catch let jsonErr
        {
            print(jsonErr.localizedDescription)
            return
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }

    var detailItem: Pokemon! {
        didSet {
            // Update the view.
            configureView()
        }
    }


}

