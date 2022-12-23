################################################################################
# rbenv helper functions
################################################################################

provision_rbenv_version() {
	if [ -f ~/.rbenv/bin/rbenv ]; then
		! [ -d "$HOME/.rbenv/versions/$(cat .ruby-version)" ] && rbenv install
	fi
}

provision_rbenv_gemset() {
	if [ -f Gemfile ]; then
		! [ -d "$HOME/.rbenv/versions/$(cat .ruby-version)/gemsets/$(cat .ruby-gemset)" ] && gem install bundler && bundle
	fi
}

provision_rbenv_yard_gems() {
	if [ -f "$HOME/.rbenv/versions/$(cat .ruby-version)/gemsets/$(cat .ruby-gemset)/bin/yard" ]; then
		! [ -d "$HOME/.rbenv/versions/$(cat .ruby-version)/gemsets/$(cat .ruby-gemset)/doc" ] && yard gems
	fi
}

provision_rbenv_full() {
	provision_rbenv_version
	provision_rbenv_gemset
	provision_rbenv_yard_gems
}

direnv_auto_rbenv() {
	provision_rbenv_full
}

############################################################################## @
