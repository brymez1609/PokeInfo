//
//  LikeViewController.swift
//  PokeInfo
//
//  Created by Bryan Andres Gomez Hernandez on 8/21/21.
//

import UIKit

class LikeViewController: UIViewController {

    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonImageView: UIView!
    @IBOutlet weak var dislikeButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var pokemonName: UILabel!
    weak var viewModel = PokedexViewModel.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonImageView.addGestureRecognizer(handRecognizer)
        pokemonImageView.dropShadow()
        dislikeButton.addTarget(nil, action: #selector(dismissPokemon), for: .touchUpInside)
        likeButton.addTarget(nil, action: #selector(savePokemon), for: .touchUpInside)
        getRandomPokemon()
        
    }
    
    func getRandomPokemon() {
        viewModel?.getPokemon(id: String(Int.random(in: 0..<493)), handler: { (result) in
            switch result {
            case .success(_):
                guard let pokemon = self.viewModel?.pokemon else {
                    return
                }
                DispatchQueue.main.async {
                    self.pokemonImage.downloaded(from: pokemon.sprites.other?.officialArtwork.frontDefault ?? "")
                    self.pokemonName.fadeTransition(0.4)
                    self.pokemonName.text = pokemon.name.capitalized
                }
            case .failure(_):
                print("error getting pokemon")
            }
        })
    }
    
    @objc func savePokemon() {
        likeButton.animateButtons()
        getRandomPokemon()
        animator = UIViewPropertyAnimator()
        animator = UIViewPropertyAnimator(duration: 1, curve: .easeIn, animations: {
            self.pokemonImageView.transform = CGAffineTransform(translationX: CGFloat(0), y: 0)
            self.pokemonImageView.alpha = 1
        })
        animator.startAnimation()
        
    }
    
    @objc func dismissPokemon() {
        dislikeButton.animateButtons()
        getRandomPokemon()
    }
    
    private lazy var handRecognizer: UIPanGestureRecognizer = {
            let recognizer = UIPanGestureRecognizer()
            recognizer.addTarget(self, action: #selector(handlePan(recognizer:)))
            return recognizer
        }()

    var animator = UIViewPropertyAnimator()
    
    @objc private func handlePan(recognizer: UIPanGestureRecognizer) {
        if case .Right = recognizer.horizontalDirection(target: self.pokemonImageView) {
                animateView(number: 275, recognizer: recognizer)
                likeButton.animateButtons()
            } else {
                dislikeButton.animateButtons()
                animateView(number: -275, recognizer: recognizer)
        }
    }
    func animateView(number:Int,recognizer: UIPanGestureRecognizer) {
            switch recognizer.state {
                case .began:
                    animator = UIViewPropertyAnimator(duration: 1, curve: .easeOut, animations: {
                        self.pokemonImageView.transform = CGAffineTransform(translationX: CGFloat(number), y: 0)
                        self.pokemonImageView.alpha = 0
                    })
                    animator.startAnimation()
                    animator.pauseAnimation()
                case .changed:
                    animator.fractionComplete = recognizer.translation(in: pokemonImageView).x / CGFloat(number)
                case .ended:
                    getRandomPokemon()
                    animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
                    self.pokemonImageView.transform = CGAffineTransform(translationX: 0, y: 0)
                    UIView.animate(withDuration: 1, delay: 0) {
                        self.pokemonImageView.alpha = 1.0
                    }
                default:
                    ()
            }
        
    }
}


