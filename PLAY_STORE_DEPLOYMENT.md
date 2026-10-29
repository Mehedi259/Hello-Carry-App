# Google Play Store Deployment Guide - Hello Carry

This document contains everything needed to complete the Google Play Console deployment for **Hello Carry**.

---

## 1. Initial "Create app" Screen (Step 1)
In the screen you currently have open:

| Field | Exact Value to Enter |
|---|---|
| **App name** | `Hello Carry` |
| **Package name** | `com.hellocarry.app` |
| **Default language** | `English (United Kingdom) - en-GB` or `English (United States) - en-US` |
| **App or game** | Select **App** |
| **Free or paid** | Select **Free** |
| **Developer Programme Policies** | Check ✅ **Confirm that app meets the Developer Programme Policies** |
| **US export laws** | Check ✅ **Accept US export laws** |

👉 Click the blue button: **`Create app`** (bottom right).

---

## 2. Release Artifacts (Files to Upload)

### Production / Closed Testing App Bundle:
* **Format:** Android App Bundle (`.aab`) — **Required by Google Play**
* **File Location:** [`app-release.aab`](file:///Users/mehedihasanmridul/app/Hello-Carry-App/build/app/outputs/bundle/release/app-release.aab)
* **Full Path:** `/Users/mehedihasanmridul/app/Hello-Carry-App/build/app/outputs/bundle/release/app-release.aab`
* **Signing Status:** ✅ **Signed in Release Mode** (`CN=Mehedi Hasan Mridul, OU=Hello Probash Tech, O=Hello Carry`)
* **Version:** `1.0.0 (1)`
* **Package Name:** `com.hellocarry.app`

### Keystore Information (Securely Preserved):
* **Keystore File:** `android/app/upload-keystore.jks`
* **Properties File:** `android/key.properties`
* **Key Alias:** `upload`
* **Store Password:** `hellowoman123`
* **Key Password:** `hellowoman123`
* **Validity:** Until Year 2054 (10,000 days)

### Direct Testing APK (For your phones):
* **Format:** Release APK (`.apk`)
* **File Location:** [`app-release.apk`](file:///Users/mehedihasanmridul/app/Hello-Carry-App/build/app/outputs/flutter-apk/app-release.apk)
* **Full Path:** `/Users/mehedihasanmridul/app/Hello-Carry-App/build/app/outputs/flutter-apk/app-release.apk`
* **Signing Status:** ✅ **Signed in Release Mode** (APK Signature Scheme v2)

---

## 3. Store Listing Assets (Ready in `play_store_assets/`)

| Asset | Specs | Location |
|---|---|---|
| **App Icon** | 512 x 512 PNG, up to 1 MB | [`icon_512.png`](file:///Users/mehedihasanmridul/app/Hello-Carry-App/play_store_assets/icon_512.png) |
| **Feature Graphic** | 1024 x 500 PNG, up to 15 MB | [`feature_graphic_1024x500.png`](file:///Users/mehedihasanmridul/app/Hello-Carry-App/play_store_assets/feature_graphic_1024x500.png) |
| **Screenshot 1 (Home)** | 1080 x 1920 PNG | [`1_home.png`](file:///Users/mehedihasanmridul/app/Hello-Carry-App/play_store_assets/screenshots/1_home.png) |
| **Screenshot 2 (Track)** | 1080 x 1920 PNG | [`2_track_cargo.png`](file:///Users/mehedihasanmridul/app/Hello-Carry-App/play_store_assets/screenshots/2_track_cargo.png) |
| **Screenshot 3 (Products)** | 1080 x 1920 PNG | [`3_products.png`](file:///Users/mehedihasanmridul/app/Hello-Carry-App/play_store_assets/screenshots/3_products.png) |
| **Screenshot 4 (Details)** | 1080 x 1920 PNG | [`4_product_details.png`](file:///Users/mehedihasanmridul/app/Hello-Carry-App/play_store_assets/screenshots/4_product_details.png) |
| **Screenshot 5 (Shipments)** | 1080 x 1920 PNG | [`5_shipments.png`](file:///Users/mehedihasanmridul/app/Hello-Carry-App/play_store_assets/screenshots/5_shipments.png) |
| **Screenshot 6 (Timeline)** | 1080 x 1920 PNG | [`6_shipment_details.png`](file:///Users/mehedihasanmridul/app/Hello-Carry-App/play_store_assets/screenshots/6_shipment_details.png) |

---

## 4. Store Listing Text (Copy & Paste)

### App Name (max 30 characters):
```text
Hello Carry
```

### Short Description (max 80 characters):
```text
Direct express cargo & wholesale product sourcing between Bangladesh and Oman.
```

### Full Description (max 4000 characters):
```text
Hello Carry is your premier, trusted cargo shipping and cross-border product sourcing partner connecting Bangladesh and Oman (Muscat, Salalah, Sohar, Nizwa). Whether you are sending personal parcels, commercial freight, export garments, or sourcing wholesale electronics and authentic Bangladeshi goods, Hello Carry guarantees fast, safe, and transparent delivery right to your doorstep.

✨ KEY FEATURES:

✈️ FAST AIR CARGO EXPRESS (3 - 5 DAYS)
Direct air shipments between Dhaka (DAC) / Chittagong (CGP) and Muscat (MCT). Ideal for urgent commercial shipments, documents, electronics, and priority packages.

🚢 COST-EFFECTIVE SEA FREIGHT (15 - 20 DAYS)
Economic sea container solutions for high-volume commercial goods, heavy luggage, furniture, and bulk merchandise with optimal pricing.

📦 WHOLESALE PRODUCT SOURCING
Browse hundreds of high-demand items from Bangladesh's top factories and GCC markets:
- Premium RMG export quality garments & traditional fashion
- Electronics, mobile accessories & home appliances
- Organic food items, tea, spices & daily essentials
Request custom sourcing quotations directly within the app with instant pricing!

📍 REAL-TIME LIVE CARGO TRACKING
Know exactly where your shipment is at every milestone:
- Real-time hub radar tracking
- Step-by-step journey timeline from pickup to final doorstep delivery
- Push notifications on customs clearance and dispatch updates
- Download verified digital waybills and commercial invoices anytime

🌐 100% BILINGUAL SUPPORT (বাংলা ও ENGLISH)
Switch effortlessly between Bengali (বাংলা) and English throughout the entire application with a single tap.

🛡️ HELLO CARRY SECURITY GUARANTEE
- 100% verified cargo insurance coverage
- Full customs clearance assistance in both Bangladesh and Oman
- Dedicated 24/7 customer support via WhatsApp and hotline

Hello Carry is a proud sister concern of Hello Probash, developed by Hello Probash Tech.

Download Hello Carry today — Your Cargo, Our Priority!
```

---

## 5. Store Settings & Classification
* **App category:** `Shopping` or `Business`
* **Tags:** `Shopping`, `Logistics`, `Productivity`, `Business`
* **Contact details:**
  * **Email:** `support@hellocarry.com` (or your preferred contact email)
  * **Website:** `https://helloprobash.com`

---

## 6. App Content Questionnaires (Mandatory Play Console Setup)

1. **Privacy Policy URL:**
   `https://helloprobash.com/privacy-policy`
2. **App Access:**
   Select: **"All functionality is available without special access"**
3. **Ads:**
   Select: **"No, my app does not contain ads"**
4. **Content Rating (Questionnaire):**
   * Category: Utility / Productivity / Commercial
   * Violence, Sex, Language: **No** to all questions
   * Result: **Rated 3+ / Everyone**
5. **Target Audience and Content:**
   * Target age: Select **18 and over**
   * Appeal to children: Select **No**
6. **News Apps:**
   Select: **"No"**
7. **COVID-19 Contact Tracing:**
   Select: **"My app is not a COVID-19 contact tracing or status app"**
8. **Data Safety:**
   * Does your app collect user data? **Yes** (Name, phone, address for delivery and shipping order fulfillment).
   * Encrypted in transit? **Yes**
   * Account deletion? **Yes**
9. **Government Apps:**
   Select: **"No"**
10. **Financial Features:**
   Select: **"My app doesn't provide any financial features"**

---

## 7. Creating the Release in Play Console
1. In the left navigation, go to **Testing** > **Internal testing** (or **Production** > **Releases**).
2. Click **Create new release**.
3. Upload [`app-release.aab`](file:///Users/mehedihasanmridul/app/Hello-Carry-App/build/app/outputs/bundle/release/app-release.aab).
4. **Release name:** `1.0.0 (1)`
5. **Release notes:**
```text
Initial official release of Hello Carry!
- Express Air Cargo & Sea Freight booking between Bangladesh and Oman
- Real-time milestone cargo tracking with live radar
- Wholesale product sourcing catalog with instant quotation
- Complete bilingual support: Bengali (বাংলা) and English
```
6. Click **Next** > **Review release** > **Start rollout**!
