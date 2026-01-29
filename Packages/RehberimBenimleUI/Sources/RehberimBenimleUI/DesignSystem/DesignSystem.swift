//
//  DesignSystem.swift
//  RehberimBenimleUI
//
//  Created by Okan Orkun on 31.12.2025.
//

import UIKit

// MARK: - Design System

/// Uygulama genelinde kullanılan tasarım sistemi sabitleri.
/// Renkler, tipografi, boşluklar ve animasyon kurallarını içerir.
public enum DesignSystem {
    
    // MARK: - Colors
    
    /// Uygulama genelindeki renk paleti.
    /// Tüm renkler Dark ve Light mod uyumludur.
    public enum Colors {
        
        // MARK: Background Colors
        
        /// Ana ekran arka plan rengi.
        /// * Light: System Background
        /// * Dark: #1C1C1E
        public static let background = UIColor { trait in
            trait.userInterfaceStyle == .dark
                ? UIColor(hex: "#1C1C1E")
                : UIColor.systemBackground
        }
        
        /// Input alanları (TextField, SearchBar) için arka plan rengi.
        /// * Light: #F2F2F7
        /// * Dark: #2C2C2E
        public static let inputBackground = UIColor { trait in
            trait.userInterfaceStyle == .dark
                ? UIColor(hex: "#2C2C2E")
                : UIColor(hex: "#F2F2F7")
        }
        
        // MARK: Text Colors
        
        /// Birincil metin rengi. Ana başlıklar ve içerikler için kullanılır.
        /// * Light: #1C1C1E
        /// * Dark: White
        public static let primaryText = UIColor { trait in
            trait.userInterfaceStyle == .dark
                ? .white
                : UIColor(hex: "#1C1C1E")
        }
        
        /// İkincil metin rengi. Alt başlıklar ve açıklamalar için kullanılır.
        /// * Light: #636366
        /// * Dark: #8E8E93
        public static let secondaryText = UIColor { trait in
            trait.userInterfaceStyle == .dark
                ? UIColor(hex: "#8E8E93")
                : UIColor(hex: "#636366")
        }
        
        // MARK: Button Colors
        
        /// Ana aksiyon butonu rengi (Primary Action).
        /// * Light: #007AFF (Mavi)
        /// * Dark: #0A84FF (Açık Mavi)
        public static let primaryButton = UIColor { trait in
            trait.userInterfaceStyle == .dark
                ? UIColor(hex: "#0A84FF")
                : UIColor(hex: "#007AFF")
        }
        
        /// İkincil aksiyon butonu rengi (Secondary Action).
        /// Vazgeç veya daha az önemli butonlar için.
        public static let secondaryButton = UIColor { trait in
            trait.userInterfaceStyle == .dark
                ? UIColor(hex: "#48484A")
                : UIColor(hex: "#EBEBF0")
        }
        
        // MARK: Status Colors
        
        /// Başarılı işlem rengi (Yeşil).
        public static let success = UIColor { trait in
            trait.userInterfaceStyle == .dark
                ? UIColor(hex: "#30D158")
                : UIColor(hex: "#34C759")
        }
        
        /// Hata durumu rengi (Kırmızı).
        public static let error = UIColor { trait in
            trait.userInterfaceStyle == .dark
                ? UIColor(hex: "#FF453A")
                : UIColor(hex: "#FF3B30")
        }
        
        /// Uyarı durumu rengi (Turuncu/Sarı).
        public static let warning = UIColor { trait in
            trait.userInterfaceStyle == .dark
                ? UIColor(hex: "#FFD60A")
                : UIColor(hex: "#FF9500")
        }
        
        // MARK: Separator
        
        /// Listeler veya bölümler arası ayırıcı çizgi rengi.
        public static let separator = UIColor { trait in
            trait.userInterfaceStyle == .dark
                ? UIColor(hex: "#38383A")
                : UIColor(hex: "#C6C6C8")
        }
    }
    
    // MARK: - Typography
    
    /// Uygulama genelindeki yazı tipi stilleri.
    public enum Typography {
        
        // MARK: Headings
        
        /// En büyük başlık stili.
        /// * Boyut: **28pt**
        /// * Ağırlık: **Bold**
        public static let title1 = UIFont.systemFont(ofSize: 28, weight: .bold)
        
        /// İkinci seviye başlık stili.
        /// * Boyut: **22pt**
        /// * Ağırlık: **Bold**
        public static let title2 = UIFont.systemFont(ofSize: 22, weight: .bold)
        
        /// Üçüncü seviye başlık stili.
        /// * Boyut: **20pt**
        /// * Ağırlık: **Semibold**
        public static let title3 = UIFont.systemFont(ofSize: 20, weight: .semibold)
        
        // MARK: Body
        
        /// Standart gövde metni.
        /// * Boyut: **17pt**
        /// * Ağırlık: **Regular**
        public static let body = UIFont.systemFont(ofSize: 17, weight: .regular)
        
        /// Vurgulu gövde metni.
        /// * Boyut: **17pt**
        /// * Ağırlık: **Semibold**
        public static let bodyBold = UIFont.systemFont(ofSize: 17, weight: .semibold)
        
        /// Çağrı metinleri veya butonlar için.
        /// * Boyut: **16pt**
        /// * Ağırlık: **Regular**
        public static let callout = UIFont.systemFont(ofSize: 16, weight: .regular)
        
        // MARK: Small Text
        
        /// Alt başlıklar için küçük metin.
        /// * Boyut: **15pt**
        public static let subheadline = UIFont.systemFont(ofSize: 15, weight: .regular)
        
        /// Dipnotlar için.
        /// * Boyut: **13pt**
        public static let footnote = UIFont.systemFont(ofSize: 13, weight: .regular)
        
        /// Resim altı yazıları vb.
        /// * Boyut: **12pt**
        public static let caption1 = UIFont.systemFont(ofSize: 12, weight: .regular)
        
        /// En küçük yardımcı metin.
        /// * Boyut: **11pt**
        public static let caption2 = UIFont.systemFont(ofSize: 11, weight: .regular)
        
        // MARK: Dynamic Type Support
        
        /// Kullanıcının cihazındaki yazı tipi boyutu ayarlarına (Dynamic Type) uyum sağlar.
        /// - Parameter style: İstenen yazı tipi stili (ör. .headline, .body)
        public static func preferredFont(for style: UIFont.TextStyle) -> UIFont {
            return UIFont.preferredFont(forTextStyle: style)
        }
    }
    
    // MARK: - Spacing
    
    /// Elemanlar arası boşluk (margin/padding) değerleri.
    public enum Spacing {
        /// En küçük boşluk değeri: **2 pt**
        public static let xxxs: CGFloat = 2
        
        /// Çok küçük boşluk değeri: **4 pt**
        public static let xxs: CGFloat = 4
        
        /// Küçük boşluk değeri: **8 pt**
        /// İlgili elemanları gruplamak için ideal.
        public static let xs: CGFloat = 8
        
        /// Küçük-Orta boşluk değeri: **12 pt**
        public static let sm: CGFloat = 12
        
        /// Standart boşluk değeri: **16 pt**
        /// Ekran kenar boşlukları (padding) için varsayılan.
        public static let md: CGFloat = 16
        
        /// Geniş boşluk değeri: **24 pt**
        public static let lg: CGFloat = 24
        
        /// Çok geniş boşluk değeri: **32 pt**
        public static let xl: CGFloat = 32
        
        /// En geniş boşluk değeri: **40 pt**
        /// Bölümler arası ana ayrım için.
        public static let xxl: CGFloat = 40
    }
    
    // MARK: - Button Sizes
    
    /// Standart buton yükseklikleri.
    public enum ButtonSize {
        /// Küçük buton yüksekliği: **44pt**
        /// İkincil veya sıkışık alanlardaki butonlar için.
        public static let sm: CGFloat = 44
        
        /// Orta (Standart) buton yüksekliği: **56pt**
        /// Ana aksiyon butonları için varsayılan.
        public static let md: CGFloat = 56
        
        /// Büyük buton yüksekliği: **64pt**
        /// Çok belirgin olması gereken butonlar için.
        public static let lg: CGFloat = 64
    }
    
    // MARK: - Corner Radius
    
    /// Köşe yuvarlama değerleri.
    public enum CornerRadius {
        /// Çok hafif yuvarlama: **4pt**
        public static let xs: CGFloat = 4
        
        /// Hafif yuvarlama: **8pt**
        public static let sm: CGFloat = 8
        
        /// Orta seviye yuvarlama: **12pt**
        /// Kart yapılarında standart kullanım.
        public static let md: CGFloat = 12
        
        /// Belirgin yuvarlama: **16pt**
        public static let lg: CGFloat = 16
        
        /// Geniş yuvarlama: **20pt**
        public static let xl: CGFloat = 20
        
        /// Tam yuvarlak (Capsule) görünüm.
        /// Değer: **999pt**
        public static let full: CGFloat = 999
    }
    
    // MARK: - Elevation (Shadows)
    
    /// Katmanlara (Layer) gölge eklemek için kullanılır.
    public enum Elevation {
        
        /// Gölge seviyeleri.
        public enum Level {
            /// Gölge yok.
            case none
            /// Hafif gölge (Kartlar vb. için).
            case low
            /// Orta seviye gölge (Öne çıkan elemanlar için).
            case medium
            /// Derin gölge (Modal veya Floating Button için).
            case high
        }
        
        /// Belirtilen katmana (layer) seçilen seviyedeki gölgeyi uygular.
        /// - Parameters:
        ///   - level: Uygulanacak gölge seviyesi (.low, .medium, .high).
        ///   - layer: Gölgenin ekleneceği UIView layer'ı.
        public static func apply(_ level: Level, to layer: CALayer) {
            switch level {
            case .none:
                layer.shadowOpacity = 0
                
            case .low:
                layer.shadowColor = UIColor.black.cgColor
                layer.shadowOffset = CGSize(width: 0, height: 2)
                layer.shadowRadius = 4
                layer.shadowOpacity = 0.1
                
            case .medium:
                layer.shadowColor = UIColor.black.cgColor
                layer.shadowOffset = CGSize(width: 0, height: 4)
                layer.shadowRadius = 8
                layer.shadowOpacity = 0.15
                
            case .high:
                layer.shadowColor = UIColor.black.cgColor
                layer.shadowOffset = CGSize(width: 0, height: 8)
                layer.shadowRadius = 16
                layer.shadowOpacity = 0.2
            }
        }
    }
    
    // MARK: - Animation
    
    /// Animasyon süreleri ve yardımcı fonksiyonlar.
    public enum Animation {
        /// Hızlı animasyon süresi: **0.15 sn**
        public static let durationFast: TimeInterval = 0.15
        
        /// Normal animasyon süresi: **0.3 sn**
        public static let durationNormal: TimeInterval = 0.3
        
        /// Yavaş animasyon süresi: **0.5 sn**
        public static let durationSlow: TimeInterval = 0.5
        
        /// Spring (yay) efektiyle animasyon çalıştırır.
        ///
        /// - Parameters:
        ///   - duration: Animasyon süresi (Varsayılan: Normal).
        ///   - animations: Yapılacak değişiklikler bloğu.
        ///   - completion: Animasyon bitince çalışacak blok.
        @MainActor
        public static func spring(
            duration: TimeInterval = durationNormal,
            animations: @escaping () -> Void,
            completion: ((Bool) -> Void)? = nil
        ) {
            UIView.animate(
                withDuration: duration,
                delay: 0,
                usingSpringWithDamping: 0.8,
                initialSpringVelocity: 0.5,
                options: [.curveEaseInOut],
                animations: animations,
                completion: completion
            )
        }
    }
}
