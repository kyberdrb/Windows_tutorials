**Install downloaded extensions from the `chrome://extensions/` page.**  
https://support.google.com/chrome/thread/7757612?hl=en&msgid=12927643 

Extensions:

- Chromium.Web.Store-1.4.4.3.crx
    - https://github.com/NeverDecaf/chromium-web-store/releases
    - if the Drag & Drop installation to the Extensions page  with error message `Package is invalid: CRX_REQUIRD_PROOF_MISSING` - **even with `Developer Mode` enabled** - **go to `chrome://flags/#extension-mime-request-handling` and set the flag to `Always prompt for install`**
        - set it in flags: https://github.com/NeverDecaf/chromium-web-store/issues/92
        - set it at launch: https://github.com/ungoogled-software/ungoogled-chromium/issues/879#issuecomment-562057654
        - https://stackoverflow.com/questions/56930454/chrome-extension-throws-crx-file-error-crx-requird-proof-missing/65451540#65451540
        - https://blog.plasmo.com/p/crx-required-proof-missing
- enhanced-h264ify-extension_2_1_0_0.crx
- Open_Tabs_Next_to_Current-extension_2_0_14_0.crx
- uBlock_Origin-extension_1_44_2_0.crx
- DuckDuckGo_Privacy_Essentials-extension_2022_8_25_0.crx
- Ninja_Cookie-extension_0_7_0_0.crx
    - https://duckduckgo.com/?q=auto+deny+all+cookies+extension&ia=web
    - https://ninja-cookie.com/
- Tab_Suspender-extension_1_4_11_0.crx
    - to decrease memory usage
- Empty_New_Tab_Page-extension_1_2_0_0.crx
    - to display an empty new tab page
    - https://duckduckgo.com/?q=blank+new+tab+chromium&atb=v344-5vb&ia=web
- Disable_Cookies-extension_1_4_0_0.crx - **maybe replace this with `Awesome Cookie Manager` to save cookies, because ungoogled-chromium deletes cookies at each launch**
    - keeps or deletes cookies on a site-specific basis
    - https://chrome.google.com/webstore/detail/disable-cookies/lkmjmficaoifggpfapbffkggecbleang

---

- Sources:
    - https://duckduckgo.com/?q=chrome+store+ungoogled+chromium&ia=software
    - https://avoidthehack.com/manually-install-extensions-ungoogled-chromium
    - https://duckduckgo.com/?q=crx+required+proof+missing&ia=web
    - https://support.google.com/chrome/thread/7757612/what-does-crx-required-proof-missing-mean-when-trying-to-install-a-chrome-extension?hl=en
