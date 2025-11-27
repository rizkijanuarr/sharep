# Digital Asset Links untuk Deep Linking

File ini harus di-upload ke server `https://siboyo.store/.well-known/assetlinks.json`

## Cara Upload ke Server:

1. Upload file `assetlinks.json` ke server Anda di path:
   ```
   https://siboyo.store/.well-known/assetlinks.json
   ```

2. Pastikan file bisa diakses publik dengan content-type `application/json`

3. Test dengan browser:
   ```
   https://siboyo.store/.well-known/assetlinks.json
   ```

4. Verify dengan Google tool:
   ```
   https://developers.google.com/digital-asset-links/tools/generator
   ```

## Package Name

Pastikan package name di `assetlinks.json` sesuai dengan `android/app/build.gradle`:
- Current: `com.example.sharep`

## SHA-256 Fingerprint

Debug key fingerprint:
```
E0:93:E1:BB:D5:85:AC:B9:A7:D2:4C:D2:04:BC:46:C6:0D:21:72:FE:B6:32:00:7D:7E:4E:AF:0E:25:C9:4E:1E
```

**PENTING:** Untuk production, Anda perlu generate release key dan tambahkan SHA-256 nya juga ke array `sha256_cert_fingerprints`.

## Generate Release Key SHA-256

```bash
keytool -list -v -keystore your-release-key.jks -alias your-key-alias
```

Lalu tambahkan SHA-256 release key ke `assetlinks.json`:
```json
"sha256_cert_fingerprints": [
  "E0:93:E1:BB:D5:85:AC:B9:A7:D2:4C:D2:04:BC:46:C6:0D:21:72:FE:B6:32:00:7D:7E:4E:AF:0E:25:C9:4E:1E",
  "YOUR_RELEASE_KEY_SHA256_HERE"
]
```
