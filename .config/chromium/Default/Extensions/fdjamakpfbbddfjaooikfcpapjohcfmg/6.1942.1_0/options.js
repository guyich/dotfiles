const STANDALONE_SETTINGS_STORAGE_KEY = 'options.standalone';

// Won't show the "Switch mode" form on OS like Linux, Chrome OS, etc.
chrome.runtime.getPlatformInfo(platformInfo => {
    const isDesktopModeAvailable = ['win', 'mac'].some(
        desktopModeOS => platformInfo.os === desktopModeOS
    );
    if (!isDesktopModeAvailable) {
        document.querySelector('#mode_selector_form').style.display = 'none';
    }
});

function saveOptions(evt) {
    evt.preventDefault();

    chrome.storage.local.get(STANDALONE_SETTINGS_STORAGE_KEY, res => {
        let previousMode = res[STANDALONE_SETTINGS_STORAGE_KEY];
        let userSelectedValue = document.querySelector(
            'input[name="standalone"]:checked'
        ).value;
        if (userSelectedValue) {
            let isStandalone = userSelectedValue === 'true';
            let hasSwitchedExtensionMode =
                previousMode && previousMode !== isStandalone;
            chrome.storage.local.set(
                {
                    'options.standalone': isStandalone,
                    hasSwitchedExtensionMode: hasSwitchedExtensionMode
                },
                () => chrome.runtime.reload()
            );
        }
    });
}

function getVersionInfo() {
    chrome.runtime.getBackgroundPage(backgroundPage => {
        const versionInfo = backgroundPage.backgroundController.getVersionInfo();

        document.getElementById('short_version_info').textContent =
            'v' + versionInfo.versions.extension + ' / ' + versionInfo.mode;
        document.getElementById('full_version_info').textContent =
            'Version Info:\n' + JSON.stringify(versionInfo, null, 4);

        if (versionInfo.mode.toLowerCase() === 'standalone') {
            document.querySelector('input#standalone').checked = true;
        } else {
            document.querySelector('input#desktop').checked = true;
        }
    });
}

function showFullVersionInfo() {
    document.getElementById('short_version_info').style.display = 'none';
    document.getElementById('full_version_info').style.display = 'block';
}

getVersionInfo();
document
    .getElementById('mode_selector_form')
    .addEventListener('submit', saveOptions);
document
    .getElementById('short_version_info')
    .addEventListener('click', showFullVersionInfo);
