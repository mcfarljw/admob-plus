class AMSRewardVideo: AMSAdBase, GADRewardedAdDelegate {
    var rewardBasedVideo: GADRewardedAd?

    deinit {
        rewardBasedVideo = nil
    }

    func isReady() -> Bool {
        return (rewardBasedVideo?.isReady == true)
    }

    func load(request: GADRequest) {
        rewardBasedVideo = GADRewardedAd(adUnitID: adUnitID)

        if rewardBasedVideo?.isReady == false {
            rewardBasedVideo?.load(GADRequest()) { error in
                if error != nil {
                    self.plugin.emit(eventType: AMSEvents.rewardVideoLoadFail)
                } else {
                    self.plugin.emit(eventType: AMSEvents.rewardVideoLoad)
                }
            }
        }
    }

    func show() {
        if isReady() {
            rewardBasedVideo?.present(fromRootViewController: plugin.viewController, delegate: self)
        }
    }
    
    func rewardedAd(_ rewardedAd: GADRewardedAd, userDidEarn reward: GADAdReward) {
        plugin.emit(eventType: AMSEvents.rewardVideoReward)
    }
    
    func rewardedAd(_ rewardedAd: GADRewardedAd, didFailToPresentWithError error: Error) {
        plugin.emit(eventType: AMSEvents.rewardVideoLoadFail)
    }
    
    func rewardedAdDidDismiss(_ rewardedAd: GADRewardedAd) {
        plugin.emit(eventType: AMSEvents.rewardVideoClose)
    }
    
    func rewardedAdDidPresent(_ rewardedAd: GADRewardedAd) {
        plugin.emit(eventType: AMSEvents.rewardVideoOpen)
    }
}
