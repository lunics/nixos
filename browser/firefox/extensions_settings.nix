{ programs.firefox.policies.ExtensionSettings = {

# https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions/manifest.json/browser_action
# valid synthax
# "install_url"       = "https://addons.mozilla.org/firefox/downloads/latest/{17c7f098-dbb8-4f15-ad39-8b578da80f7e}/latest.xpi";

"uBlock0@raymondhill.net" = {                   # Ublock Origin
  "installation_mode" = "force_installed";      # allowed, normal_installed, force_installed, blocked
  "install_url"       = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
  "default_area"      = "menupanel";            # menupanel, navbar, tabstrip, personaltoolbar (bookmarks toolbar), titlebar
};

"{17c7f098-dbb8-4f15-ad39-8b578da80f7e}" = {    # Behave
  "installation_mode" = "force_installed";
  "install_url"       = "https://addons.mozilla.org/firefox/downloads/latest/behave/latest.xpi";
  "default_area"      = "menupanel";
};

"skipredirect@sblask" = {                       # Skip Redirect
  "installation_mode" = "force_installed";
  "install_url"       = "https://addons.mozilla.org/firefox/downloads/latest/skip-redirect/latest.xpi";
  "default_area"      = "menupanel";
};

"gdpr@cavi.au.dk" = {                           # consent-o-matic
  "installation_mode" = "force_installed";
  "install_url"       = "https://addons.mozilla.org/firefox/downloads/latest/consent-o-matic/latest.xpi";
  "default_area"      = "menupanel";
};

"idcac-pub@guus.ninja" = {                      # istilldontcareaboutcookies
  "installation_mode" = "force_installed";
  "install_url"       = "https://addons.mozilla.org/firefox/downloads/latest/istilldontcareaboutcookies/latest.xpi";
  "default_area"      = "menupanel";
};

# keeper-password-manager

"Tab-Session-Manager@sienori" = {               # Tab-Session-Manager
  "installation_mode" = "force_installed";
  "install_url"       = "https://addons.mozilla.org/firefox/downloads/latest/tab-session-manager/latest.xpi";
  "default_area"      = "navbar";
};

"{d7742d87-e61d-4b78-b8a1-b469842139fa}" = {    # Vimium
  "installation_mode" = "force_installed";
  "install_url"       = "https://addons.mozilla.org/firefox/downloads/latest/vimium-ff/latest.xpi";
  "default_area"      = "menupanel";
};

"{92e6fe1c-6e1d-44e1-8bc6-d309e59406af}" = {    # hover-zoom-plus
  "installation_mode" = "force_installed";
  "install_url"       = "https://addons.mozilla.org/firefox/downloads/latest/hover-zoom-plus/latest.xpi";
  "default_area"      = "menupanel";
};

"simple-translate@sienor" = {                   # simple-translate
  "installation_mode" = "force_installed";
  "install_url"       = "https://addons.mozilla.org/firefox/downloads/latest/simple-translate/latest.xpi";
  "default_area"      = "menupanel";
};

"extension@tabliss.io" = {                      # tabliss
  "installation_mode" = "force_installed";
  "install_url"       = "https://addons.mozilla.org/firefox/downloads/latest/tabliss/latest.xpi";
  "default_area"      = "menupanel";
};

"{7be2ba16-0f1e-4d93-9ebc-5164397477a9}" = {    # videospeed
  "installation_mode" = "force_installed";
  "install_url"       = "https://addons.mozilla.org/firefox/downloads/latest/videospeed/latest.xpi";
  "default_area"      = "menupanel";
};

"pipewire-screenaudio@icenjim" = {              # pipewire-screenaudio
  "installation_mode" = "force_installed";
  "install_url"       = "https://addons.mozilla.org/firefox/downloads/latest/pipewire-screenaudio/latest.xpi";
  "default_area"      = "menupanel";
};

# Keepa (amazon price tracker)
"amptra@keepa.com" = {
  "installation_mode" = "force_installed";
  "install_url"       = "https://addons.mozilla.org/firefox/downloads/latest/keepa/latest.xpi";
  "default_area"      = "menupanel";
};

"github-forks-addon@musicallyut.in" = {         # github-forks-addon@musicallyut.in
  "installation_mode" = "force_installed";
  "install_url"       = "https://addons.mozilla.org/firefox/downloads/latest/github-forks-addon/latest.xpi";
  "default_area"      = "menupanel";
};

# 	# Dark Reader
# 	"addon@darkreader.org" = {
# 		"installation_mode" = "force_installed";
# 		"install_url" = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
# 		"default_area" = "menupanel";
# 	};

# 	# New Tab Override
# 	"newtaboverride@agenedia.com" = {
# 		"installation_mode" = "force_installed";
# 		"install_url" = "https://addons.mozilla.org/firefox/downloads/latest/new-tab-override/latest.xpi";
# 		"default_area" = "menupanel";
# 	};

# 	# Bitwarden password manager
# 	"{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
# 		"installation_mode" = "force_installed";
# 		"install_url" = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
# 		"default_area" = "menupanel";
# 	};

# 	# Floccus bookmarks
# 	"floccus@handmadeideas.org" = {
# 		"installation_mode" = "force_installed";
# 		"install_url" = "https://addons.mozilla.org/firefox/downloads/latest/floccus/latest.xpi";
# 		"default_area" = "menupanel";
# 	};

};}
