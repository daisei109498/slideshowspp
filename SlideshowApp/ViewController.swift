import UIKit
 
class ViewController: UIViewController {
    
    @IBOutlet weak var UIimageView: UIImageView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    var image: UIImage!
    // タイマー
    var timer: Timer!
    // タイマー用の時間のための変数
    //var timer_sec: Float = 0
    
    //画像配列カウント用
    var imageIndex = 0

    let imageArr = [
        UIImage(named: "gazou-1.jpeg")!,
        UIImage(named: "gazou-2.jpeg")!,
        UIImage(named: "gazou-3.jpeg")!,
        UIImage(named: "gazou-4.jpeg")!
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //縮小表示
        UIimageView.image = resize(image: imageArr[0], width: 200.0)
    }

    // selector: #selector(updatetimer(_:)) で指定された関数
    //2秒毎に呼び出され続ける
    @objc func updateTimer(_ timer: Timer) {
        //self.timer_sec += 0.1
        //self.timerLabel.text = String(format: "%.1f", self.timer_sec)
        if imageIndex == imageArr.count-1 {
            imageIndex = 0
        } else {
            imageIndex += 1
        }
        UIimageView.image = resize(image: imageArr[imageIndex], width: 200.0)
    }

    // 再生・停止ボタン IBAction
    @IBAction func startTimer(_ sender: Any) {
        
        // 再生中か停止しているかを判定
        if (timer == nil) {
            // 再生時の処理を実装
            self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(updateTimer(_:)), userInfo: nil, repeats: true)
            // ボタンの名前を停止に変える
            startButton.setTitle("停止", for: .normal)
            
            nextButton.isEnabled = false
            backButton.isEnabled = false
            
            
            
        } else {
            // 停止時の処理を実装
            // タイマーを停止する
            timer.invalidate()

            // タイマーを削除しておく(timer.invalidateだけだとtimerがnilにならないため)
            timer = nil

            // ボタンの名前を再生に直しておく
            startButton.setTitle("再生", for: .normal)
            
            nextButton.isEnabled = true
            backButton.isEnabled = true
        }

    }
    
    func resize(image: UIImage, width: Double) -> UIImage {
            
        // オリジナル画像のサイズからアスペクト比を計算
        let aspectScale = image.size.height / image.size.width
        
        // widthからアスペクト比を元にリサイズ後のサイズを取得
        let resizedSize = CGSize(width: width, height: width * Double(aspectScale))
        
        // リサイズ後のUIImageを生成して返却
        UIGraphicsBeginImageContext(resizedSize)
        image.draw(in: CGRect(x: 0, y: 0, width: resizedSize.width, height: resizedSize.height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resizedImage!
    }
    
    // 進むボタン IBAction
    @IBAction func nextImage(_ sender: Any) {
        // 再生中か停止しているかを判定
        if (timer == nil) {
            if imageIndex == imageArr.count-1 {
                imageIndex = 0
            } else {
                imageIndex += 1
            }
            UIimageView.image = resize(image: imageArr[imageIndex], width: 200.0)
        }
        
    }

    @IBAction func backImage(_ sender: Any) {
        // 再生中か停止しているかを判定
        if (timer == nil) {
            if imageIndex == 0 {
                imageIndex = imageArr.count-1
            } else {
                imageIndex -= 1
            }
            UIimageView.image = resize(image: imageArr[imageIndex], width: 200.0)
        }
    }
    
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
        // 他の画面から segue を使って戻ってきた時に呼ばれる
    }
    
    @IBAction func tapAction(_ sender: Any) {
        if (timer != nil) {
            // 停止時の処理を実装
            // タイマーを停止する
            timer.invalidate()
            // タイマーを削除しておく(timer.invalidateだけだとtimerがnilにならないため)
            timer = nil
            // ボタンの名前を再生に直しておく
            startButton.setTitle("再生", for: .normal)
        }
        self.performSegue(withIdentifier: "toZoom", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // segueから遷移先のResultViewControllerを取得する
        let resultViewController:resultViewController = segue.destination as! resultViewController
        // 遷移先のResultViewControllerで宣言しているx, yに値を代入して渡す
        resultViewController.image = imageArr[imageIndex]
    }
}
