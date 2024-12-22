{ programs.firefox.policies.ExtensionSettings = {

# Ublock Origin
"uBlock0@raymondhill.net" = {
  "installation_mode" = "force_installed";    # normal_installed, force_installed
  "install_url"       = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
  "default_area"      = "toolbar";            # menupanel, toolbar
};

# Vimium
"{d7742d87-e61d-4b78-b8a1-b469842139fa}" = {
  "installation_mode" = "force_installed";
  "install_url"       = "https://addons.mozilla.org/firefox/downloads/latest/vimium-ff/latest.xpi";
  "default_area"      = "menupanel";
};

# Tab-Session-Manager@sienori

# Keepa (amazon price tracker)
"amptra@keepa.com" = {
  "installation_mode" = "force_installed";
  "install_url" = "https://addons.mozilla.org/firefox/downloads/latest/keepa/latest.xpi";
  "default_area" = "menupanel";
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
