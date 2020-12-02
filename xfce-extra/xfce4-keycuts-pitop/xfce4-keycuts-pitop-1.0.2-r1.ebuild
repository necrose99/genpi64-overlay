# Copyright (c) 2017 sakaki <sakaki@deciban.com>
# License: GPL v3+
# NO WARRANTY

EAPI=6

KEYWORDS="~arm ~arm64"

DESCRIPTION="Baseline keyboard shortcuts for the Pi-Top (brightness etc.)"
HOMEPAGE="https://github.com/sakaki-/gentoo-on-rpi3-64bit"
SRC_URI=""
LICENSE="GPL-3+"
SLOT="0"
IUSE="-systemd"
RESTRICT="mirror"

# required by Portage, as we have no SRC_URI...
S="${WORKDIR}"

DEPEND="
	>=xfce-base/xfce4-meta-4.12
	systemd?  ( >=sys-apps/systemd-242-r6 )
	!systemd? ( >=sys-apps/openrc-0.41 )"
RDEPEND="${DEPEND}
	>=xfce-extra/xfce4-fixups-rpi3-1.0.0
	>=sci-calculators/qalculate-gtk-0.9.9
	>=sys-apps/pitop-poweroff-1.0.2-r3
	>=dev-embedded/pitop-utils-1.20170723-r1
	>=x11-terms/xfce4-terminal-0.6.3
	>=xfce-base/thunar-1.6.10-r1
	>=app-shells/bash-4.0"

src_install() {
	newbin "${FILESDIR}/${PN}-3" "${PN}"
	insinto "/etc/xdg/autostart/"
	newins "${FILESDIR}/${PN}.desktop-1" "${PN}.desktop" 
}

pkg_postinst() {
	if [[ -z ${REPLACING_VERSIONS} ]]; then
		elog "Some simple per-user keyboard shortcuts for the Pi-Top have"
		elog "been installed. These will take effect for each user from their"
		elog "next graphical login; however, once set, you may change them"
		elog "as desired (via the ~/.Xmodmap file, and the menu item:"
		elog "Applications -> Settings -> Keyboard, under the"
		elog "'Application Shortcuts' tab)."
	fi
	if use systemd; then
		ewarn "You are running with the systemd USE flag set!"
		ewarn "However, this package does not yet formally support systemd, so"
		ewarn "you are on your own to get things working ><"
	fi
}
