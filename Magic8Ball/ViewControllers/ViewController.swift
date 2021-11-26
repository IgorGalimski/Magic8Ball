//
//  ViewController.swift
//  Magic8Ball
//
//  Created by Yasser Farahi.
//

import UIKit
import AVFoundation

class ViewController: UIViewController
{
    let initialBackgroundColor: UIColor = #colorLiteral(red: 0.2260648608, green: 0.8779802918, blue: 0.5831124783, alpha: 1)

    let magicianHat: String = "🎩"
    
    let magicAnswers: [String] = ["Definitely Yes 😎", "Definitely Not 😔", "Ask Again Later 🤓", "I Don't Know 🤪", "Yes 😊", "No ☹️", "Would Be Great 🤩", "Bad Idea 🙄", "Absolutely 😍"]
    
    let backgroundColorsCollection: [UIColor] = [#colorLiteral(red: 0.9944964061, green: 0.7785405008, blue: 0.09869512859, alpha: 1), #colorLiteral(red: 0.2581120729, green: 0.7850868106, blue: 0.9436420202, alpha: 1), #colorLiteral(red: 0.6306838754, green: 0.44416107, blue: 1, alpha: 1), #colorLiteral(red: 0.978488028, green: 0.3134756386, blue: 0.430555582, alpha: 1), #colorLiteral(red: 0.2905532709, green: 0.4218296332, blue: 0.9944964061, alpha: 1), #colorLiteral(red: 0.8627327085, green: 0.2279217487, blue: 0.7974209407, alpha: 1)]
    
    var magic8BallView: UIView!

    var magic8BallSubView: UIView!
    
    var magicAnswerLabel: UILabel!
    
    var magicHatLabel: UILabel!
    
    var hapticFeedback = UINotificationFeedbackGenerator()
    
    var animationStarted: Bool = false
    
    var player: AVAudioPlayer?

    override func viewDidLoad()
    {
        super.viewDidLoad()

        view.backgroundColor = initialBackgroundColor
        
        SetupMagicEightBall()
    }
    
    func SetupMagicEightBall()
    {
        let frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 320, height: 320))
        magic8BallView = UIView(frame: frame)
        magic8BallView.backgroundColor = .black
        magic8BallView.layer.cornerRadius = frame.height/2
        view.addSubview(magic8BallView)
        
        magic8BallView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        magic8BallView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50).isActive = true
        magic8BallView.widthAnchor.constraint(equalToConstant: magic8BallView.frame.width).isActive = true
        magic8BallView.heightAnchor.constraint(equalToConstant: magic8BallView.frame.height).isActive = true
        
        magic8BallView.translatesAutoresizingMaskIntoConstraints = false
        
        
        SetupMagicEightBallSubview()
    }

    func SetupMagicEightBallSubview()
    {
        let frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 225, height: 225))
        magic8BallSubView = UIView(frame: frame)
        magic8BallSubView.backgroundColor = .white
        magic8BallSubView.layer.cornerRadius = frame.height/2
        magic8BallView.addSubview(magic8BallSubView)
        
        magic8BallSubView.centerXAnchor.constraint(equalTo: magic8BallView.centerXAnchor).isActive = true
        magic8BallSubView.centerYAnchor.constraint(equalTo: magic8BallView.centerYAnchor).isActive = true
        magic8BallSubView.widthAnchor.constraint(equalToConstant: magic8BallSubView.frame.width).isActive = true
        magic8BallSubView.heightAnchor.constraint(equalToConstant: magic8BallSubView.frame.height).isActive = true
        
        magic8BallSubView.translatesAutoresizingMaskIntoConstraints = false
        
        SetupMagicEightBallTextLabel()
    }
    
    func SetupMagicEightBallTextLabel()
    {
        let frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 215, height: 100))
        magicAnswerLabel = UILabel(frame: frame)
        magicAnswerLabel.text = "Ask a question. Shake the phone to get the answer"
        magicAnswerLabel.numberOfLines = .zero
        magicAnswerLabel.textColor = .black
        magicAnswerLabel.textAlignment = .center
        magicAnswerLabel.font = UIFont(name: "Helvetica-Bold", size: 20)
        magic8BallSubView.addSubview(magicAnswerLabel)
        
        magicAnswerLabel.centerXAnchor.constraint(equalTo: magic8BallSubView.centerXAnchor).isActive = true
        magicAnswerLabel.centerYAnchor.constraint(equalTo: magic8BallSubView.centerYAnchor).isActive = true
        magicAnswerLabel.widthAnchor.constraint(equalToConstant: magicAnswerLabel.frame.width).isActive = true
        magicAnswerLabel.heightAnchor.constraint(equalToConstant: magicAnswerLabel.frame.height).isActive = true
        magicAnswerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        AddTheHat()
    }
    
    func AddTheHat()
    {
        let frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 250, height: 250))
        magicHatLabel = UILabel(frame: frame)
        magicHatLabel.text = magicianHat
        magicHatLabel.font = UIFont.systemFont(ofSize: 200)

        view.addSubview(magicHatLabel)
        
        magicHatLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 25).isActive = true
        magicHatLabel.bottomAnchor.constraint(equalTo: magic8BallSubView.topAnchor, constant: 25).isActive = true
        magicHatLabel.widthAnchor.constraint(equalToConstant: magicHatLabel.frame.width).isActive = true
        magicHatLabel.heightAnchor.constraint(equalToConstant: magicHatLabel.frame.height).isActive = true
        magicHatLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?)
    {
        if !animationStarted
        {
            animationStarted = true
            
            SetupAudioPlayer()
            
            UIView.animate(withDuration: 2.0, delay: .zero, usingSpringWithDamping: 10, initialSpringVelocity: 1.0, options: .curveEaseInOut)
            {
                
                self.view.backgroundColor = self.backgroundColorsCollection.shuffled().first
                
                self.hapticFeedback.notificationOccurred(.error)
                
                self.magicHatLabel.transform = CGAffineTransform(translationX: .zero, y: 160)
                
                self.magic8BallSubView.transform = CGAffineTransform(rotationAngle: .pi)
                
                self.magic8BallSubView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
                
                self.magic8BallView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                
                
            } completion: {[weak self] success in
                
                self?.magicAnswerLabel.font = UIFont(name: "Helvetica-Bold", size: 30)
                
                self?.magicAnswerLabel.text = self?.magicAnswers.shuffled().first
                
                self?.hapticFeedback.notificationOccurred(.error)
                
                if success
                {
                    
                    UIView.animate(withDuration: 3.5, delay: .zero, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut)
                    {
                        
                        self?.view.backgroundColor = self?.initialBackgroundColor
                        
                        self?.magicHatLabel.transform = CGAffineTransform(translationX: .zero, y: .zero)
                        
                        self?.magic8BallSubView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
                        
                        self?.magic8BallView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                        
                        self?.magic8BallSubView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                        
                        
                    } completion: { [weak self] _ in
                        
                        self?.animationStarted = false
                        
                        if self?.player != nil { self?.player = nil }}}}
        }
    }
    
    func SetupAudioPlayer()
    {
        guard let fileUrl = Bundle.main.url(forResource: "8ballSound", withExtension: "wav") else
        {
            return
        }
        
        do
        {
            player = try AVAudioPlayer(contentsOf: fileUrl)
        
            player?.play()
            
            player?.volume = 0.5
            
        } catch let error
        {
            print(error)
        }
    }
}

