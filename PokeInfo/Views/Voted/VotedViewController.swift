//
//  VotedViewController.swift
//  PokeInfo
//
//  Created by Bryan Andres Gomez Hernandez on 8/21/21.
//

import UIKit

class VotedViewController: UIViewController {
    @IBOutlet weak var segmentedController: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    weak var viewModel = VotedViewModel.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        registerCells()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    @IBAction func registerCells() {
        tableView.register(UINib(nibName: "PokemonCell", bundle: nil), forCellReuseIdentifier: "pokeNameCell")
    }

    @IBAction func indexChanged(_ sender: Any) {
        switch segmentedController.selectedSegmentIndex {
            case 0:
                self.viewModel?.userLikeFilter = true
            case 1:
                self.viewModel?.userLikeFilter = false
            default:
                break
        }
        tableView.reloadData()
    }
}
extension VotedViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}

extension VotedViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.localPokemons.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "pokeNameCell") as? PokedexTableViewCell else {
            return UITableViewCell()
        }
        guard let pokemon = viewModel?.localPokemons[indexPath.row] else {
            return UITableViewCell()
        }
        cell.name.text = pokemon.name.capitalized
        cell.number.text = String(pokemon.id)
        cell.pokeImageView.downloaded(from: API.getPokemonsImagesUrl(game: "platinum", id: String(pokemon.id)))
        return cell
    }
    
    
}
