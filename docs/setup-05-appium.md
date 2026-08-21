# Setup 5 — Install Appium & the XCUITest Driver
**Section 3 · Clip 5** · ~10 min · One-time · *The heaviest setup — take it slowly.*

Appium needs three things: the server, the iOS driver, and the Python client.

## 1. Appium server
```bash
npm install -g appium
appium -v
```

## 2. The iOS (XCUITest) driver
Appium reaches iOS *through* Apple's XCUITest — hence the driver name.
```bash
appium driver install xcuitest
appium driver list --installed
```

## 3. Run the doctor — your best friend here
```bash
appium driver doctor xcuitest
```
It checks Xcode, the developer tools, and the Simulator setup, and prints exactly what is
missing with how to fix it. **Fix everything it flags before moving on.**

## 4. Python client
```bash
python3 -m pip install --upgrade pip
python3 -m pip install Appium-Python-Client pytest
```

## Troubleshooting
| Symptom (doctor or run) | Fix |
|---|---|
| `xcodebuild` / dev tools missing | Complete [setup-01](setup-01-install-xcode.md); `sudo xcodebuild -license accept`. |
| Driver install fails | Update Node; re-run `appium driver install xcuitest`. |
| Cannot connect to server | Start `appium` in a separate terminal; check `APPIUM_SERVER`. |
| Tests can't find the app | Install a TechShop build first; conftest launches bundle id `com.techshop.ios`. |

If this felt like the most work — it is. It is also a one-time cost. CLI reference:
[`snippets/appium-commands.sh`](../snippets/appium-commands.sh).
