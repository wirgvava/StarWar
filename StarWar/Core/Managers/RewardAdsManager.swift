//
//  RewardAdsManager.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 08.07.24.
//

import Foundation
import GoogleMobileAds

class RewardAdsManager: NSObject, ObservableObject, GADFullScreenContentDelegate {
    @Published var rewardLoaded: Bool = false
    private var rewardAd: GADRewardedAd?
    let rewardedAdUnitID = Bundle.main.infoDictionary?["GADRewardedAd"] as? String ?? ""
    
    func loadReward() {
        GADRewardedAd.load(withAdUnitID: self.rewardedAdUnitID,
                           request: GADRequest()) { [weak self] ad, error in
            guard let self = self else { return }
            if let error = error {
                print("Failed to load ad: \(error.localizedDescription)")
                self.rewardLoaded = false
                return
            }
            self.rewardAd = ad
            self.rewardAd?.fullScreenContentDelegate = self
            self.rewardLoaded = true
            print("Ad loaded successfully.")
        }
    }
    
    func displayReward(from viewController: UIViewController, completion: @escaping () -> ()) {
        guard let ad = rewardAd, rewardLoaded else {
            print("Ad not loaded yet. Call loadReward() first.")
            return
        }
        ad.present(fromRootViewController: viewController) { [weak self] in
            guard let self = self else { return }
            print("Reward earned!")
            
            completion()
            self.rewardLoaded = false
            self.rewardAd = nil
        }
    }
}
